# -- Formula Info --
# If you don't have this file, there will be no homebrew
# formula operations.
#
PROJECT="mulle-objc-developer"      # your project/repository name
DESC="🎁  Developer tools for mulle-objc"
LANGUAGE="bash"             # c,cpp, objc, bash ...

# LANGUAGE="c"             # c,cpp, objc, bash ...
# NAME="${PROJECT}"        # formula filename without .rb extension

#
# Specify needed homebrew packages by name as you would when saying
# `brew install`.
#
# Use the ${DEPENDENCY_TAP} prefix for non-official dependencies.
# DEPENDENCIES and BUILD_DEPENDENCIES will be evaled later!
# So keep them single quoted.
#
DEPENDENCIES='${BOOTSTRAP_TAP}mulle-bootstrap
${BOOTSTRAP_TAP}mulle-sde
codeon-gmbh/software/mulle-clang
'

DEBIAN_DEPENDENCIES="mulle-clang, mulle-sde, mulle-bootstrap, binutils, git, curl, cmake (>= 3.0.0), make"

#
# Build via mulle-build. If you don't like this
# edit bin/release.sh. Need to specify mulle-build dependencies
# so that brew picks up the internal path!
#
BUILD_DEPENDENCIES='${BOOTSTRAP_TAP}mulle-build
${BOOTSTRAP_TAP}mulle-bootstrap
cmake'


