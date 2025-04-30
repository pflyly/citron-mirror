# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

# Apply patches that are tagged with a specific label
# Current labels include:
# "canary merge benefit"

import json
import os
import sys
import subprocess
import re
from urllib import request


def get_pull_request_list(page=1):
    url = f"https://api.github.com/repos/Citron-Project/Cit/pulls?page={page}"
    headers = {'Accept': 'application/vnd.github.v3+json'}
    token = os.environ.get('EARLY_ACCESS_TOKEN')
    if token:
        headers['Authorization'] = f'token {token}'
    req = request.Request(url, headers=headers)
    response = request.urlopen(req)
    result = json.loads(response.read().decode('utf-8'))
    if len(result) > 0:
        return result + get_pull_request_list(page + 1)
    return []


seen = {}

for pr in get_pull_request_list():
    pn = pr['number']
    if pn in seen:
        continue
    seen[pn] = True
    print(subprocess.check_output(["git", "fetch", "https://github.com/Citron-Project/Cit.git", f"pull/{pn}/head:pr-{pn}", "-f", "--no-recurse-submodules"]))
    out = subprocess.check_output(["python3", ".ci/scripts/merge/check-label-presence.py", str(pn), sys.argv[1]])
    if b'true' in out:
        print(f'Applying PR #{pn} matching label {sys.argv[1]}...')
        try:
            if b'changes requested' in subprocess.check_output(["python3", ".ci/scripts/merge/check-reviews.py", str(pn)]):
                print(f'PR #{pn} has requested changes, skipping')
                continue
            else:
                print(f'PR #{pn} has approving reviews, applying')
        except:
            print('Could not find any valid reviews, applying anyway')
        try:
            print(subprocess.check_output(["git", "merge", "--squash", f"pr-{pn}", "-m", f"Merge PR #{pn} tagged with: {sys.argv[1]}"]))
        except:
            print("Failed to merge cleanly, are there conflicts?")
            exit(0)

# Apply a tag to the EA release
try:
    print(subprocess.check_output(["git", "tag", "-f", f"canary/{sys.argv[1]}"]))
except:
    print("Failed to apply canary tag")
    exit(0)
