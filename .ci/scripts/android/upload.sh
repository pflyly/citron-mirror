#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

. .ci/scripts/common/pre-upload.sh

APPNAME="org.citron.citron"

REV_NAME="${APPNAME}-${GITDATE}-${GITREV}"

APK="${REV_NAME}.apk"

if [ "${GITHUB_REPOSITORY}" == "Citron-Project/Cit" ]; then
    cd src/android
    ./gradlew app:bundleRelease
    # RELEASE_BODY gets reset here, but its fine since we're uploading after the GitHub Release
    . .ci/scripts/common/post-upload.sh

    sudo apt-get install -y jq

    ls app/build/outputs/bundle/release/

    echo "Downloading CI scripts bundle"
    ARTIFACTS_DIR="/tmp/artifact-pool"
    mkdir -p "$ARTIFACTS_DIR"
fi

BUILD_FLAVOR="stable"

BUILD_TYPE_LOWER="release"
BUILD_TYPE_UPPER="Release"
if [ "${GITHUB_REPOSITORY}" == "Citron-Project/Cit" ]; then
    BUILD_TYPE_LOWER="relWithDebInfo"
    BUILD_TYPE_UPPER="RelWithDebInfo"
fi

cp src/android/app/build/outputs/apk/"${BUILD_FLAVOR}/${BUILD_TYPE_LOWER}/app-${BUILD_FLAVOR}-${BUILD_TYPE_LOWER}.apk" \
  "artifacts/${REV_NAME}.apk"
cp src/android/app/build/outputs/bundle/"${BUILD_FLAVOR}${BUILD_TYPE_UPPER}"/"app-${BUILD_FLAVOR}-${BUILD_TYPE_LOWER}.aab" \
  "artifacts/${REV_NAME}.aab"
