FROM golang:alpine as builder

LABEL maintainer="Christian Seki <chrisyuri_19@hotmail.com>"

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o main

FROM scratch

COPY --from=builder /app/main /usr/bin/
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

EXPOSE 8080

ENTRYPOINT ["main"]