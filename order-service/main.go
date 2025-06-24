package main

import (
	"log"
	"net/http"
	"order-service/app/db"
	"order-service/app/handlers"
	"time"
)

type statusRecorder struct {
	http.ResponseWriter
	status int
}

func (r *statusRecorder) WriteHeader(code int) {
	r.status = code
	r.ResponseWriter.WriteHeader(code)
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		rec := &statusRecorder{ResponseWriter: w, status: 200}
		next.ServeHTTP(rec, r)
		log.Printf("%s %s -> %d (%v)", r.Method, r.URL.Path, rec.status, time.Since(start))
	})
}

func main() {
	db.Init()
	mux := http.NewServeMux()
	mux.HandleFunc("/order", handlers.CreateOrder)
	loggedMux := loggingMiddleware(mux)
	log.Println("Listening on port :8080")
	log.Fatal(http.ListenAndServe(":8080", loggedMux))
}