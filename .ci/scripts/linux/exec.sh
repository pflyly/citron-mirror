#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

mkdir -p "ccache"  || true
chmod a+x ./.ci/scripts/linux/docker.sh
# the UID for the container citron user is 1027
sudo chown -R 1027 ./

# The environment variables listed below:
# AZURECIREPO TITLEBARFORMATIDLE TITLEBARFORMATRUNNING DISPLAYVERSION
#  are requested in src/common/CMakeLists.txt and appear to be provided somewhere in Azure DevOps

docker run -e AZURECIREPO -e TITLEBARFORMATIDLE -e TITLEBARFORMATRUNNING -e DISPLAYVERSION -e ENABLE_COMPATIBILITY_REPORTING -e CCACHE_DIR=/citron/ccache -v "$(pwd):/citron" -w /citron yuzu-emu-mirror/build-environments:linux-fresh /bin/bash /citron/.ci/scripts/linux/docker.sh "$1"
sudo chown -R $UID ./
