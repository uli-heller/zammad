#!/bin/sh
VERSION="$(git describe --tags "$(git rev-list --tags --max-count=1)")"
git clean -f
git archive --format=tar "${VERSION}"|bzip2 -c9 >zammad-${VERSION}.tar.bz2
sha256sum zammad-${VERSION}.tar.bz2 >zammad-${VERSION}.tar.bz2.sha256
