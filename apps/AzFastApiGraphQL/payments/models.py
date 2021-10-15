from sqlalchemy import Column, Integer, String

from payments.orm import Base

class CreditCard(Base):
    __tablename__ = "creditcard"

    card_id = Column(Integer, primary_key=True)
    budget = Column(Integer)


