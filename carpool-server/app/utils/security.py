from passlib.context import CryptContext
from sqlalchemy.orm import Session
from ..models.models import User
from typing import Optional

# Password hashing configuration
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Проверяет соответствие открытого пароля хешированному
    Args:
        plain_password: пароль в открытом виде
        hashed_password: хешированный пароль из базы данных
    Returns:
        bool: True если пароли совпадают, False если нет
    """
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """
    Создает хеш из открытого пароля
    Args:
        password: пароль в открытом виде
    Returns:
        str: хешированный пароль
    """
    return pwd_context.hash(password)

def authenticate_user(db: Session, email: str, password: str) -> Optional[User]:
    """
    Аутентифицирует пользователя по email и паролю
    Args:
        db: сессия базы данных
        email: email пользователя
        password: пароль в открытом виде
    Returns:
        Optional[User]: объект пользователя если аутентификация успешна, None если нет
    """
    user = db.query(User).filter(User.email == email).first()
    if not user:
        return None
    if not verify_password(password, user.password):
        return None
    return user

