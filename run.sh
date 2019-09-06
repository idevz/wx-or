#!/usr/bin/env bash

### BEGIN ###
# Author: idevz
# Since: 09:08:02 2019/09/03
# Description:       a OR  test obj
# run          ./run.sh
#
# Environment variables that control this script:
#
### END ###

set -e
BASE_DIR=$(dirname $(cd $(dirname "$0") && pwd -P)/$(basename "$0"))

prove "$@"
