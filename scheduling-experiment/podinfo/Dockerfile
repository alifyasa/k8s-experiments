FROM golang:1.23.1 AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .
FROM scratch
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 80
CMD ["./server"]
