#!/usr/bin/env bash

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

kubectl \
  apply -f https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.20.1/release.yaml

kubectl \
  -n tekton-pipelines \
  rollout status deployment tekton-pipelines-controller \
  --timeout=1m

kubectl \
  -n tekton-pipelines \
  rollout status deployment tekton-pipelines-webhook \
  --timeout=1m

kubectl \
  apply -f https://github.com/qu1queee/build/releases/download/v0.97.0/release.yaml

kubectl \
  -n build-operator \
  rollout status deployment build-operator \
  --timeout=1m