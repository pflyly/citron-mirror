#!/bin/bash -ex

# SPDX-FileCopyrightText: 2024 Citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

export NDK_CCACHE="$(which ccache)"
ccache -s

export ANDROID_KEYSTORE_FILE="${GITHUB_WORKSPACE}/ks.jks"
export SERVICE_ACCOUNT_KEY_PATH="${GITHUB_WORKSPACE}/service-account-key.json"

base64 --decode <<< "${CANARY_PLAY_ANDROID_KEYSTORE_B64}" > "${ANDROID_KEYSTORE_FILE}"
chmod 600 "${ANDROID_KEYSTORE_FILE}"

mkdir -p "$(dirname "${SERVICE_ACCOUNT_KEY_PATH}")"
base64 --decode <<< "${CANARY_SERVICE_ACCOUNT_KEY_B64}" > "${SERVICE_ACCOUNT_KEY_PATH}"
./gradlew "publishCanaryReleaseBundle"

ccache -s

rm "${ANDROID_KEYSTORE_FILE}" "${SERVICE_ACCOUNT_KEY_PATH}" 