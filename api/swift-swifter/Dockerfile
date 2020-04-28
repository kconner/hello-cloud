FROM swift:latest AS develop

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

FROM ubuntu:18.04 AS release

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libatomic1 libxml2 libz-dev libbsd0 tzdata libicu60 libcurl4 \
  && rm -r /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /usr/lib/swift/linux/ /usr/lib/swift/linux/
COPY --from=build /app/.build/release/app .

CMD ./app
EXPOSE 80
