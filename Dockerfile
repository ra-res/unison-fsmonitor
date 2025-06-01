FROM golang:1.24.1-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \ 
    CGO_ENABLED=0 go build -ldflags="-s -w"

FROM alpine:3.21.3

WORKDIR /

COPY --from=builder "/src/unison-fsmonitor" "/"

ENTRYPOINT ["/unison-fsmonitor"]

