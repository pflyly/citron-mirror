#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

mkdir -p "ccache" || true
chmod a+x ./.ci/scripts/windows/docker.sh
# the UID for the container citron user is 1027
sudo chown -R 1027 ./
docker run -e CCACHE_DIR=/citron/ccache -v "$(pwd):/citron" -w /citron yuzu-emu-mirror/build-environments:linux-mingw /bin/bash -ex /citron/.ci/scripts/windows/docker.sh "$1"
sudo chown -R $UID ./
