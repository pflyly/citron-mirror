# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

# Apply patches that are tagged with a specific label
# Current labels include:
# "canary merge benefit"

import os
import sys
org = os.getenv("PRIVATEMERGEORG", "Citron-Project")
base = os.getenv("PRIVATEMERGEBASE", "Cit")
head = os.getenv("PRIVATEMERGEBASE", "Cit-canary")

# We use different files for the 3 PR checkers.
check_label_presence_file = ".ci/scripts/merge/check-label-presence.py"
check_reviews_file = ".ci/scripts/merge/check-reviews-private.py"

# python3 python_file org repo pr# label
os.system(f"python3 .ci/scripts/merge/apply-patches-by-label.py {sys.argv[1]} {org} {base} {head} {check_label_presence_file} {check_reviews_file}")
