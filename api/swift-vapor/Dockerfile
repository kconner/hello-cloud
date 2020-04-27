# https://github.com/swift-server/guides

FROM vapor/swift:latest AS develop

RUN git clone https://github.com/eradman/entr.git \
    && cd entr \
    && git checkout --quiet 4.5 \
    && ./configure \
    && make test \
    && make install \
    && cd - \
    && rm -rf entr
WORKDIR /app
COPY ./Package.* ./
RUN swift package resolve
COPY . .

FROM develop AS build

RUN swift build \
	--enable-test-discovery \
	-c release

FROM vapor/ubuntu:18.04 AS release

WORKDIR /app
COPY --from=build /usr/lib/swift/linux/ /usr/lib/swift/linux/
COPY --from=build /app/.build/release/Run .

CMD ./Run serve --env production --hostname 0.0.0.0 --port 80
EXPOSE 80
