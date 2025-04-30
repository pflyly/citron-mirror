#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

chmod a+x ./.ci/scripts/format/docker.sh
# the UID for the container citron user is 1027
sudo chown -R 1027 ./
docker run -v "$(pwd):/citron" -w /citron yuzu-emu-mirror/build-environments:linux-clang-format /bin/bash -ex /citron/.ci/scripts/format/docker.sh
sudo chown -R $UID ./
