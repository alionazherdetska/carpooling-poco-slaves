from typing import List, Optional
from ...crud.user import user
from ...schemas.user import UserCreate, UserResponse
from fastapi import APIRouter, Depends, HTTPException, status, Form
from sqlalchemy.orm import Session
from datetime import timedelta
from ...utils.security import verify_password, create_access_token
from ...schemas.user import UserResponse
from ...schemas.car import CarResponse, CarCreate
from ...models.models import User, Car
from ...database import get_db
from ...config import settings
from ...utils.security import get_current_user

router = APIRouter()
@router.get("/me", tags=["users"])
def get_me(current_user: User = Depends(get_current_user)):
    car_details = [
        {"make": car.make, "model": car.model, "year": car.year, "plate_number": car.plate_number}
        for car in current_user.cars
    ]
    return {
        "email": current_user.email,
        "username": current_user.username,
        "name": current_user.name,
        "surname": current_user.surname,
        "cars": car_details,
    }

@router.put("/me", response_model=UserResponse, tags=["users"])
def update_profile(
    name: Optional[str] = Form(None),
    surname: Optional[str] = Form(None),
    username: Optional[str] = Form(None),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Update user profile"""
    if name:
        current_user.name = name
    if surname:
        current_user.surname = surname
    if username:
        current_user.username = username
    db.commit()
    db.refresh(current_user)
    return current_user


@router.post("/me/cars", response_model=CarResponse, tags=["users"])
def add_car(
    car: CarCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Add a car to the user's profile"""
    new_car = Car(
        user_id=current_user.id,
        make=car.make,
        model=car.model,
        year=car.year,
        plate_number=car.plate_number,
    )
    db.add(new_car)
    db.commit()
    db.refresh(new_car)
    return new_car


@router.put("/me/cars/{car_id}", response_model=CarResponse, tags=["users"])
def update_car(
    car_id: int,
    car: CarCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Update a car in the user's profile"""
    car_obj = db.query(Car).filter(Car.id == car_id, Car.user_id == current_user.id).first()
    if not car_obj:
        raise HTTPException(status_code=404, detail="Car not found")
    car_obj.make = car.make
    car_obj.model = car.model
    car_obj.year = car.year
    car_obj.plate_number = car.plate_number
    db.commit()
    db.refresh(car_obj)
    return car_obj


@router.delete("/me/cars/{car_id}", response_model=dict, tags=["users"])
def delete_car(
    car_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Delete a car from the user's profile"""
    car_obj = db.query(Car).filter(Car.id == car_id, Car.user_id == current_user.id).first()
    if not car_obj:
        raise HTTPException(status_code=404, detail="Car not found")
    db.delete(car_obj)
    db.commit()
    return {"detail": "Car deleted successfully"}

@router.post("/login", response_model=dict, tags=["auth"])
def login(
        username: str = Form(...),  # OAuth2 standard field
        password: str = Form(...),  # OAuth2 standard field
        db: Session = Depends(get_db)
):
    # Authenticate user by email
    user = db.query(User).filter(
        User.email == username).first()  # 'username' maps to 'email'
    if not user or not verify_password(password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # Create JWT token
    access_token_expires = timedelta(minutes=settings.JWT_ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(data={"sub": user.email},
                                       expires_delta=access_token_expires)

    # Return access token
    return {"access_token": access_token, "token_type": "bearer"}

@router.post("/", response_model=UserResponse)
def create_user(
    user_in: UserCreate,
    db: Session = Depends(get_db)
):
    """Create new user"""
    db_user = user.get_by_email(db, email=user_in.email)
    if db_user:
        raise HTTPException(
            status_code=400,
            detail="Email already registered"
        )
    return user.create(db=db, obj_in=user_in)

@router.get("/", response_model=List[UserResponse])
def read_users(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    """Get list of active users"""
    users = user.get_active_users(db, skip=skip, limit=limit)
    return users

@router.get("/{user_id}", response_model=UserResponse)
def read_user(
    user_id: int,
    db: Session = Depends(get_db)
):
    """Get user by ID"""
    db_user = user.get(db, id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user

@router.delete("/{user_id}", response_model=UserResponse)
def remove(
    user_id: int,
    db: Session = Depends(get_db)
):
    """Delete user"""
    db_user = user.delete(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user