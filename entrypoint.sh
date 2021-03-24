#!/bin/bash

# Copyright © 2021 The Homeport Team
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.



set -euo pipefail

# Login into IBM Cloud
ibmcloud login && \
   -a https://cloud.ibm.com && \
   -r "${REGION}" && \
   -g "${RESOURCE_GROUP}" && \
   --apikey "${APIKEY}"

# Create a registry secret
ibmcloud ce registry create && \
   -n "foobarsecret" && \
   -s "${REGISTRY_ENDPOINT}" && \
   -u "${REGISTRY_USERNAME}" && \
   -p "${REGISTRY_PASSWORD}" && \
   -e "foobar@mail"

# Create a Build resource
ibmcloud ce build create && \
   -n "action-build" && \
   --registry-secret "foobarsecret" && \
   --source "${SOURCE_URL}" && \
   --strategy "${STRATEGY}" && \