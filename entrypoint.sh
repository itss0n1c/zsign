#!/bin/sh
set -e

# This script serves as the entrypoint for the Docker container.
# It ensures that the zsign binary is executed with any provided arguments.

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
  set -- /usr/local/bin/zsign "$@"
fi

exec "$@"