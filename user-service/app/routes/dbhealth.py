from flask import jsonify, Blueprint
from app.db.mongo import mongo

db_health_bp = Blueprint("health", __name__)

@db_health_bp.route("/ping-mongo", methods=["GET"])
def ping_mongo():
    try:
        mongo.cx.admin.command("ping")
        return jsonify({"status": "Connected to MongoDB"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500