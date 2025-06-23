from app.db.mongo import mongo
from app.schema.user import UserSchema
from pydantic import ValidationError

def register_user(data):
    try:
        user = UserSchema(**data).dict()
        result = mongo.db.users.insert_one(user)
        return {"message": "User registered successfully", "user_id": str(result.inserted_id)}, 201
    except ValidationError as ve:
        return {"error": ve.errors()}, 400
    except Exception as e:
        return {"error": str(e)}, 500