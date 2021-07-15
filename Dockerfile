FROM golang:1.16.6-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git npm && \
    ./prepare.sh

RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o "bin-release"

FROM alpine:3.14.0

WORKDIR /

COPY --from=builder "/src/bin-release" "/"

VOLUME ["/data"]

ENTRYPOINT ["/bin-release"]
EXPOSE 8080
