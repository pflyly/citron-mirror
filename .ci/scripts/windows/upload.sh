#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

. .ci/scripts/common/pre-upload.sh

REV_NAME="citron-windows-${GITDATE}-${GITREV}"
ARCHIVE_NAME="${REV_NAME}.tar.xz"
COMPRESSION_FLAGS="-cJvf"

if [ "${RELEASE_NAME}" = "stable" ]; then
    DIR_NAME="${REV_NAME}"
else
    DIR_NAME="${REV_NAME}_${RELEASE_NAME}"
fi

mkdir "$DIR_NAME"
# get around the permission issues
cp -r package/* "$DIR_NAME"

if [ "${RELEASE_NAME}" = "stable" ]; then
    MSVC_BUILD_ZIP="citron-stable-msvc.zip"
else
    MSVC_BUILD_ZIP="${REV_NAME}-msvc.zip"
fi

. .ci/scripts/common/post-upload.sh
