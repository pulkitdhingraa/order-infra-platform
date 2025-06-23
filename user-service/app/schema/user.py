from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime

class Address(BaseModel):
    flat: str
    street: str
    city: str
    zip: int

class UserSchema(BaseModel):
    email: EmailStr
    first_name: str
    last_name: Optional[str] = None
    address: Address
    created_at: Optional[datetime] = Field(default_factory=datetime.now)