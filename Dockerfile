FROM ubuntu:24.04

# Make sure UTF-8 characters printed by librepcb-cli are displayed properly.
# For a different language of the output of librepcb-cli, the environment
# variable LANG can be overridden at container runtime with the '-e' flag.
# Note: Not using LC_ALL since it leads to a runtime warning printed to stderr.
ENV LANG=C.UTF-8

# Install APT packages
# Note: git is actually not needed in this image, but it might be useful for
# users to have it installed (to clone/push/diff projects or libraries).
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q && apt-get -y -q install --no-install-recommends \
    ca-certificates git libegl1 libfontconfig1 libglib2.0-0 libglu1-mesa wget xvfb \
  && rm -rf /var/lib/apt/lists/*

# Install LibrePCB CLI
ARG LIBREPCB_VERSION=2.0.1
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
