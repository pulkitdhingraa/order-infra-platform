from flask import jsonify
from app.db.mongo import mongo
from bson.objectid import ObjectId

def get_user_details(userId):

    try:
        obj_id = ObjectId(userId)
    except Exception:
        return {"error": "Invalid user id"}, 400

    user = mongo.db.users.find_one({"_id": obj_id}, {"email": 1, "address": 1, "_id": 0})

    if not user: 
        return {"error": "User Not found"}, 404
    return jsonify(user)