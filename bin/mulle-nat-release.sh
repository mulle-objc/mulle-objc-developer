#! /bin/sh


TAPNAME="${1:-software}"
[ $# -ne 0 ] && shift
BRANCH="{$1:-release}"
[ $# -ne 0 ] && shift

DIR="`dirname -- "$0"`"

"${DIR}/release.sh" --publisher "mulle-nat" \
                    --publisher-tap "mulle-nat/${TAPNAME}/" \
                    --branch "${BRANCH} \
                    --bootstrap-tap "mulle-kybernetik/alpha/" \
                    --dependency-tap "mulle-kybernetik/${TAPNAME}/" \
                     "$@"
