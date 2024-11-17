from typing import List
from ...crud.user import user
from ...schemas.user import UserCreate, UserResponse
from fastapi import APIRouter, Depends, HTTPException, status, Form
from sqlalchemy.orm import Session
from datetime import timedelta
from ...utils.security import verify_password, create_access_token
from ...schemas.user import UserResponse
from ...models.models import User
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
def deactivate_user(
    user_id: int,
    db: Session = Depends(get_db)
):
    """Deactivate user"""
    db_user = user.deactivate(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user 