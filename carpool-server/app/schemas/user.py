from pydantic import BaseModel, EmailStr, Field
from datetime import datetime
from .enums import UserRolesEnum

class UserBase(BaseModel):
    username: str
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    user_id: int = Field(..., alias='id')
    carbon_bonus_points: int
    created_at: datetime

    class Config:
        from_attributes = True
        populate_by_name = True