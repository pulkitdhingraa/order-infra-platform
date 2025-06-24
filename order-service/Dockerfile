FROM golang:1.25rc1-alpine3.22 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o order-service ./main.go

FROM alpine:latest

COPY --from=builder /app/order-service .

CMD ["./order-service"]