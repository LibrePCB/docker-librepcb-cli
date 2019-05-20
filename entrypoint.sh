#!/usr/bin/env sh

set -euo pipefail

# LibrePCB CLI requires a running X server, as explained in documentation:
#   https://docs.librepcb.org/#cli-headless
# Note: The option "-nolisten unix" is required to allow running the container
# as a user other than root which would otherwise lead to the following issue:
#   ERROR: euid != 0,directory /tmp/.X11-unix will not be created.
Xvfb :99 -nolisten tcp -nolisten unix -nolock &
export DISPLAY=:99

# Start the LibrePCB CLI and forward all arguments
librepcb-cli "$@"
