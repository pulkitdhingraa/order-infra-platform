from flask import Flask
from app.routes.register import register_bp
from app.routes.delete import delete_bp
from app.routes.dbhealth import db_health_bp
from app.routes.userdetails import userdetails_bp
from app.db.mongo import mongo


def create_app():
    app = Flask(__name__)

    app.config["MONGO_URI"] = "mongodb://admin:password@mongo:27017/user_service_db"

    app.register_blueprint(register_bp, url_prefix="/users")
    app.register_blueprint(delete_bp, url_prefix="/users")
    app.register_blueprint(userdetails_bp, url_prefix="/users")
    app.register_blueprint(db_health_bp, url_prefix="/health")

    mongo.init_app(app)

    return app