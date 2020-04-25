# https://cryptic.io/go-http/
# https://medium.com/the-andela-way/build-a-restful-json-api-with-golang-85a83420c9da

FROM golang:1.14-alpine

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
