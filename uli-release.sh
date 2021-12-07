#!/bin/sh
BN="$(basename "$0")"
D="$(dirname "$0")"
D="$(cd "${D}" && pwd)"
VERSION="$1"

GIT_HASH="$(git rev-list -n 1 "${VERSION}" 2>/dev/null)"
test -z "${GIT_HASH}" && {
    echo >&2 "${BN}: Version '${VERSION}' existiert nicht!"
    exit 1
}

mkdir "${VERSION}"
#cp -a .git "${VERSION}"
git clone "file://${D}" "${VERSION}"
(
    set -x
  cd "${VERSION}"
  #git clone    
  git checkout -f "${VERSION}"
  git checkout -f "${VERSION}" .
  "${D}/uli-package.sh"
  mv "zammad-${VERSION}"* "${D}"
)
rm -rf "${VERSION}"
