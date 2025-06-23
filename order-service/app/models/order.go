package models

type OrderRequest struct {
	UserID      string `json:"user_id"`
	ProductName string `json:"product_name"`
	Qty         int    `json:"qty"`
}

type Address struct {
	Flat   string `json:"flat"`
	Street string `json:"street"`
	City   string `json:"city"`
	Zip    int    `json:"zip"`
}

type UserInfo struct {
	UserEmail string  `json:"email"`
	UserAddr  Address `json:"address"`
}
