from flask import Blueprint,request,jsonify
from app.services.delete_account_service import delete_user

delete_bp = Blueprint("delete", __name__)

@delete_bp.route('/delete', methods=["DELETE"])
def delete_account():
    data = request.get_json()
    if not data or "email" not in data: 
        return jsonify({"error": "Missing email in the request body"}), 400
    print(data["email"])
    return delete_user(data["email"])

