from flask import Blueprint
from app.services.user_details_service import get_user_details

userdetails_bp = Blueprint("userdetails", __name__)

@userdetails_bp.route('/details/<user_id>', methods=["GET"])
def user_details(user_id):
    return get_user_details(user_id)