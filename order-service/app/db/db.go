package db

import (
	"database/sql"
	"log"
	_ "github.com/lib/pq"
)

var DB *sql.DB

func Init() {
	connStr := "host=postgres port=5432 user=postgres password=postgres dbname=order_service_db sslmode=disable"
	var err error
	DB, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to connect to the db: %v", err)
	}

	if err = DB.Ping(); err != nil {
		log.Fatalf("DB ping error %v", err)
	}

	log.Println("Connected to PostgreSQL")
	// applySchemaFromFile("app/db/schema.sql")
}

// func applySchemaFromFile(path string) {
// 	sqlBytes, err := os.ReadFile(path)
// 	if err != nil {
// 		log.Fatalf("Could not read schema file: %v", err)
// 	}

// 	queries := strings.Split(string(sqlBytes), ";")
// 	for _, q := range queries {
// 		q = strings.TrimSpace(q)
// 		if q == "" {
// 			continue
// 		}
// 		_, err := DB.Exec(q)
// 		if err != nil {
// 			log.Fatalf("Failed to execute schema query: %v", err)
// 		}
// 	}
// 	log.Println("Schema Applied Successfully")
// }