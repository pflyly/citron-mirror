#!/bin/bash -ex

# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

export NDK_CCACHE="$(which ccache)"
ccache -s

BUILD_FLAVOR="stable"

mkdir -p "artifacts"

BUILD_TYPE="release"
if [ "${GITHUB_REPOSITORY}" == "Citron-Project/Cit" ]; then
    BUILD_TYPE="relWithDebInfo"
fi

# We'll use the Android debug keystore for builds
# This removes the requirement for storing a keystore in secrets
# For production builds, this should be replaced with a proper signing configuration
export USE_DEBUG_KEYSTORE=true

cd src/android
chmod +x ./gradlew
./gradlew clean
./gradlew app:assemble${BUILD_FLAVOR}${BUILD_TYPE}

ccache -s
