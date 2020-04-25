# https://cryptic.io/go-http/
# https://medium.com/the-andela-way/build-a-restful-json-api-with-golang-85a83420c9da

FROM golang:1.14-alpine as develop

RUN apk add --no-cache --virtual .git-dependencies git make g++ \
    && git clone https://github.com/eradman/entr.git \
        && cd entr \
        && git checkout --quiet 4.5 \
        && ./configure \
        && make test \
        && make install \
        && cd - \
        && rm -rf entr \
    && go get github.com/gorilla/mux  \
    && apk del .git-dependencies

WORKDIR /src

COPY . .

FROM develop as build

RUN go build -o /build/app

FROM alpine:3 as release
WORKDIR /release

# Copy build artifacts
COPY --from=build /build/app /release

CMD ./app

EXPOSE 80
