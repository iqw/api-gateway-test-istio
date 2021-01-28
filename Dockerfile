FROM golang:1.15 as builder
RUN mkdir /code
COPY . /code
WORKDIR /code

ARG APP_NAME

ENV GO111MODULE on
ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOARCH amd64

RUN go mod download
RUN go build -a -o ./app ./cmd/${APP_NAME}

FROM alpine:3.12
WORKDIR /go/bin

# Application artifacts
COPY --from=builder /code/app .

## System required data
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

CMD ["./app"]
