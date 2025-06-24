package services

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"order-service/app/db"
	"order-service/app/models"
)

func CreateOrderService(order models.OrderRequest) error {
	var userinfo *models.UserInfo
	var err error

	userinfo, err = fetchUserDetails(order.UserID)
	if err != nil {
		return fmt.Errorf("could not fetch user details: %w", err)
	}

	useraddr := fmt.Sprintf("%s, %s, %s, %d", userinfo.UserAddr.Flat, userinfo.UserAddr.Street, userinfo.UserAddr.City, userinfo.UserAddr.Zip)

	productID, err := getProductIdByName(order.ProductName)
	if err != nil {
		return fmt.Errorf("could not find product id for %s: %w", order.ProductName, err)
	}

	query := `INSERT INTO orders (user_id, user_email, user_address, product_id, qty) VALUES ($1, $2, $3, $4, $5)`
	_, err = db.DB.Exec(query, order.UserID, userinfo.UserEmail, useraddr, productID, order.Qty)
	return err
}

func getProductIdByName(name string) (int, error) {
	var productId int
	query := `SELECT product_id FROM products WHERE product_name = $1`
	err := db.DB.QueryRow(query, name).Scan(&productId)
	if err != nil {
		return 0, fmt.Errorf("product not found: %w", err)
	}
	return productId, nil
}

func fetchUserDetails(userId string) (*models.UserInfo, error) {
	url := fmt.Sprintf("http://user-service:8080/users/details/%s", userId)
	resp, err := http.Get(url)
	if err != nil {
		return nil, fmt.Errorf("failed to call user-service for user details: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("user service returned %d", resp.StatusCode)
	}

	var userinfo models.UserInfo
	if err = json.NewDecoder(resp.Body).Decode(&userinfo); err != nil {
		return nil, fmt.Errorf("error decoding user service response %w", err)
	}
	log.Printf("User Struct: %+v", userinfo)
	return &userinfo, nil
}