# https://github.com/swift-server/guides

FROM vapor/swift:latest as develop
WORKDIR /src

RUN git clone https://github.com/eradman/entr.git \
    && cd entr \
    && git checkout --quiet 4.5 \
    && ./configure \
    && make test \
    && make install \
    && cd - \
    && rm -rf entr

# First just resolve dependencies.
# This creates a cached layer that can be reused 
# as long as your Package.swift/Package.resolved
# files do not change.
COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

FROM develop as build

# Compile with optimizations
RUN swift build \
	--enable-test-discovery \
	-c release

FROM vapor/ubuntu:18.04 as release
WORKDIR /release

# Copy the build product
COPY --from=build /src/.build/release/Run /release
# Copy Swift runtime libraries
COPY --from=build /usr/lib/swift/linux/ /usr/lib/swift/linux/
# Uncomment the next line if you need to load resources from the `Public` directory
#COPY --from=build /build/Public /release/Public

CMD ./Run serve --env production --hostname 0.0.0.0 --port 80

EXPOSE 80
