package handlers

import (
	"encoding/json"
	"log"
	"net/http"
	"order-service/app/models"
	"order-service/app/services"
	"strings"
)

func CreateOrder(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
	}

	var order models.OrderRequest
	err := json.NewDecoder(r.Body).Decode(&order)
	if err != nil || order.Qty == 0 {
		http.Error(w, "Bad Request", http.StatusBadRequest)
		return
	}

	err = services.CreateOrderService(order)
	if err != nil {
		if strings.Contains(err.Error(), "not found") {
			http.Error(w, err.Error(), http.StatusNotFound)
		}

		log.Printf("Internal Error creating order: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	w.Write([]byte(`{"message": "Order created successfully"}`))
}
