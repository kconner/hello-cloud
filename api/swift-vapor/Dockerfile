# ================================
# Test image
# ================================
FROM vapor/swift:latest as test
WORKDIR /src

RUN apt-get update && apt-get install -y \
    entr \
    && rm -rf /var/lib/apt/lists/*

# First just resolve dependencies.
# This creates a cached layer that can be reused 
# as long as your Package.swift/Package.resolved
# files do not change.
COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

# ================================
# Build image
# ================================
FROM test as build

# Compile with optimizations
RUN swift build \
	--enable-test-discovery \
	-c release \
	-Xswiftc -g

# ================================
# Run image
# ================================
FROM vapor/ubuntu:18.04
WORKDIR /run

# Copy build artifacts
COPY --from=build /src/.build/release /run
# Copy Swift runtime libraries
COPY --from=build /usr/lib/swift/ /usr/lib/swift/
# Uncomment the next line if you need to load resources from the `Public` directory
#COPY --from=build /build/Public /run/Public

CMD ./Run serve --env production --hostname 0.0.0.0 --port 80

EXPOSE 80
