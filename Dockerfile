FROM ubuntu:18.04

# Install APT packages
# Note: git is actually not needed in this image, but it might be useful for
# users to have it installed (to clone/push/diff projects or libraries).
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q && apt-get -y -q install --no-install-recommends \
    ca-certificates git libfontconfig1 libglib2.0-0 libglu1-mesa wget xvfb \
  && rm -rf /var/lib/apt/lists/*

# Install LibrePCB CLI
ARG LIBREPCB_VERSION=0.1.3
RUN wget "https://download.librepcb.org/releases/$LIBREPCB_VERSION/librepcb-$LIBREPCB_VERSION-linux-x86_64.tar.gz" \
  && mkdir /opt/librepcb \
  && tar -xvzf librepcb-$LIBREPCB_VERSION-linux-x86_64.tar.gz -C /opt/librepcb --strip-components=1 \
  && rm librepcb-$LIBREPCB_VERSION-linux-x86_64.tar.gz \
  && rm /opt/librepcb/bin/librepcb

# Set working directory to /work so users don't have to change the working
# directory when mounting a volume to this path
WORKDIR /work

# Add wrapper around librepcb-cli to get it run with xvfb-run
ADD librepcb-cli /usr/local/bin/librepcb-cli

# Check if the librepcb-cli works as expected
RUN librepcb-cli --version

# Set entrypoint to librepcb-cli
ENTRYPOINT ["librepcb-cli"]
