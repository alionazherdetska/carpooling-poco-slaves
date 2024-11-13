from typing import List, Optional  # Импортируем типы для аннотаций: список и необязательный тип
from sqlalchemy.orm import Session  # Импортируем класс Session из SQLAlchemy для работы с сессиями базы данных
from ..models.models import Ride  # Импортируем модель Ride из модуля models
from ..schemas.ride import RideCreate  # Обновленный импорт
from .base import CRUDBase  # Импортируем базовый класс CRUDBase из текущего пакета

class CRUDRide(CRUDBase[Ride, RideCreate, RideCreate]):  # Определяем класс CRUDRide, наследующий от CRUDBase
    def get_by_driver(self, db: Session, driver_id: int) -> List[Ride]:  # Метод для получения поездок по ID водителя
        return db.query(self.model).filter(self.model.driver_id == driver_id).all()  # Выполняем запрос к базе данных для получения всех поездок водителя
    
    def get_active_rides(self, db: Session, skip: int = 0, limit: int = 100) -> List[Ride]:  # Метод для получения активных поездок с возможностью пропуска и ограничения
        return db.query(self.model)\
            .filter(self.model.is_active == True)\
            .offset(skip)\
            .limit(limit)\
            .all()  # Получаем все записи, соответствующие условиям
    
    def deactivate_ride(self, db: Session, ride_id: int) -> Optional[Ride]:  # Метод для деактивации поездки по её ID
        ride = db.query(self.model).filter(self.model.ride_id == ride_id).first()  # Ищем поездку по ID
        if ride:  # Если поездка найдена
            ride.is_active = False  # Устанавливаем статус активности в False
            db.commit()  # Фиксируем изменения в базе данных
            db.refresh(ride)  # Обновляем объект ride из базы данных
        return ride  # Возвращаем объект ride (или None, если поездка не найдена)

ride = CRUDRide(Ride)  # Создаем экземпляр CRUDRide для работы с моделью Ride
