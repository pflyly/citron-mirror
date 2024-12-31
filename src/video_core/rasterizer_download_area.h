// SPDX-FileCopyrightText: Copyright 2023 yuzu Emulator Project & 2025 citron Homebrew Project
// SPDX-License-Identifier: GPL-3.0-or-later

#pragma once

#include "common/common_types.h"

namespace VideoCore {

struct RasterizerDownloadArea {
    VAddr start_address;
    VAddr end_address;
    bool preemtive;
};

} // namespace VideoCore
