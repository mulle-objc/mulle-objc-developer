#! /bin/sh


DIR="`dirname -- "$0"`"

"${DIR}/release.sh" --publisher "mulle-nat" \
                    --bootstrap-tap "mulle-kybernetik/alpha/" \
                    --dependency-tap "mulle-kybernetik/software/" \
                     "$@"
