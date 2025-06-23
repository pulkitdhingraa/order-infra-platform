from app.db.mongo import mongo

def delete_user(email: str):
    result = mongo.db.users.delete_one({"email": email})
    if result.deleted_count == 0:
        return {"message": f"No user found with email {email}"}, 404
    return {"message": f"User with email {email} deleted successfully"}, 204