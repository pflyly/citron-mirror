#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

. .ci/scripts/common/pre-upload.sh

REV_NAME="citron-linux-clang-${GITDATE}-${GITREV}"
ARCHIVE_NAME="${REV_NAME}.tar.xz"
COMPRESSION_FLAGS="-cJvf"

if [ "${RELEASE_NAME}" = "stable" ]; then
    DIR_NAME="${REV_NAME}"
else
    DIR_NAME="${REV_NAME}_${RELEASE_NAME}"
fi

mkdir -p $DIR_NAME

cp build/bin/citron "$DIR_NAME"
cp build/bin/citron-cmd "$DIR_NAME"

. .ci/scripts/common/post-upload.sh
