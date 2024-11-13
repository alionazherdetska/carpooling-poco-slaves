# Импортируем BaseSettings из pydantic_settings для управления настройками приложения
from pydantic_settings import BaseSettings

# Класс настроек приложения, наследуется от BaseSettings
class Settings(BaseSettings):
    # URL подключения к базе данных PostgreSQL
    # Значение по умолчанию используется, если не указано в переменных окружения
    DATABASE_URL: str = "postgresql://postgres:postgres@localhost:5432/carpool-db"
    
    # Название проекта
    # Также может быть переопределено через переменные окружения
    PROJECT_NAME: str = "Carpool App"
    
    # Вложенный класс для дополнительной конфигурации
    class Config:
        # Указываем файл, из которого будут загружаться переменные окружения
        env_file = ".env"

# Создаем экземпляр класса настроек
# Этот объект будет использоваться в других частях приложения
settings = Settings()
