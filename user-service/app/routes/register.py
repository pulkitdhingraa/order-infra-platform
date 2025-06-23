from flask import Blueprint,request
from app.services.register_service import register_user

register_bp = Blueprint("register", __name__)

@register_bp.route('/register', methods=["POST"])
def register():
    data = request.get_json()
    return register_user(data)