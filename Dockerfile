FROM alpine:3.9 as build

# Install build dependencies
RUN apk add --no-cache g++ make qt5-qtbase-dev qt5-qttools-dev wget zip
ENV PATH="$PATH:/usr/lib/qt5/bin"

# Build LibrePCB
ARG LIBREPCB_VERSION=0.1.1
RUN wget "https://download.librepcb.org/releases/$LIBREPCB_VERSION/librepcb-$LIBREPCB_VERSION-source.zip"
RUN unzip "./librepcb-$LIBREPCB_VERSION-source.zip"
WORKDIR "./librepcb-$LIBREPCB_VERSION"
RUN qmake librepcb.pro -r "PREFIX=/librepcb" && make -j8 && make install


# Start from a clean image to dramatically reduce image size due to discarded
# build dependencies
FROM alpine:3.9

# Install runtime dependencies
# Note: git is actually not needed in this image, but it might be useful for
# users to have it installed (to clone/push/diff projects or libraries).
RUN apk add --no-cache git qt5-qtbase qt5-qtbase-x11 xvfb

# Install LibrePCB
COPY --from=build /librepcb /usr

# Set working directory to /work so users don't have to change the working
# directory when mounting a volume to this path
WORKDIR /work

# Set entrypoint and run librepcb-cli to check if it works as expected
ADD entrypoint.sh /entrypoint.sh
RUN /entrypoint.sh --version
ENTRYPOINT ["/entrypoint.sh"]
