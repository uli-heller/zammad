#!/bin/sh
BN="$(basename "$0")"
GITHUB_REMOTE=origin
GITHUB_USER="$(git remote get-url "${GITHUB_REMOTE}"|sed -e 's/^[^:]*://' -e 's,/.*$,,')"
GITHUB_PUBKEY="$(curl -sq "https://github.com/${GITHUB_USER}.keys")"

TMPDIR="/tmp/${BN}-$(openssl rand -hex 20).$$~"

RC=0
cleanUp () {
    rm -rf "${TMPDIR}"
    exit "${RC}"
}

trap cleanUp 0 1 2 3 4 5 6 7 8 9 10 12 13 14 15

#VERSION="$(git describe --tags "$(git rev-list --tags --max-count=1)")"
VERSION="$(git describe --tags "$(git rev-list HEAD~1..HEAD)")"
git clean -f
git archive --format=tar "${VERSION}"|bzip2 -c9 >zammad-${VERSION}.tar.bz2
sha256sum zammad-${VERSION}.tar.bz2 >zammad-${VERSION}.tar.bz2.sha256

mkdir -p "${TMPDIR}"
echo "${GITHUB_PUBKEY}" >"${TMPDIR}/ssh.pub"
ssh-keygen -q -Y sign -n file -f "${TMPDIR}/ssh.pub" <"zammad-${VERSION}.tar.bz2" >"zammad-${VERSION}.tar.bz2.ssh-sig" || RC=1

cleanUp
exit "${RC}"
