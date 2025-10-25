#!/bin/sh
# start virtual framebuffer in background if not already running
if ! pgrep -x Xvfb >/dev/null 2>&1; then
  Xvfb :99 -screen 0 1280x1024x24 >/dev/null 2>&1 &
fi

exec "$@"