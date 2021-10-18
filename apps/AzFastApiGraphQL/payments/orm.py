from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, scoped_session
from config import load_config

config = load_config()
engine = create_engine(config.POSTGRESDB_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Session = scoped_session(SessionLocal)

Base = declarative_base()

def get_db():
    try:
        db = SessionLocal()
        return db
    finally:
        db.close()