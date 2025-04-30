# SPDX-FileCopyrightText: 2019 citron Emulator Project
# SPDX-License-Identifier: GPL-2.0-or-later

# Check if a pull request has a specific label
# Usage: python3 check-label-presence.py <PR Number> <Label Text>

import json, sys
from urllib import request
import os

url = 'https://api.github.com/repos/Citron-Project/Cit/issues/%s' % sys.argv[1]
headers = {'Accept': 'application/vnd.github.v3+json'}
token = os.environ.get('EARLY_ACCESS_TOKEN')
if token:
    headers['Authorization'] = f'token {token}'
req = request.Request(url, headers=headers)
try:
    response = request.urlopen(req)
    j = json.loads(response.read().decode('utf-8'))
    for label in j['labels']:
        if label['name'] == sys.argv[2]:
            print('true')
            sys.exit(0)
except Exception as e:
    print(f'Error: {e}')
print('false')
sys.exit(1)
