# Етап 1: Збірка
FROM golang:1.19 AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Етап 2: Мінімальний образ
FROM scratch
COPY --from=builder /app/main /main
EXPOSE 8080
CMD ["/main"]