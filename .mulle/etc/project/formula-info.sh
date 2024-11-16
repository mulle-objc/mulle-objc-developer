# -- Formula Info --
# If you don't have this file, there will be no homebrew
# formula operations.
#
PROJECT="mulle-objc-developer"      # your project/repository name
DESC="🎩 mulle-objc developer kit for mulle-sde"

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
DEPENDENCIES='${MULLE_C_TAP}mulle-c-developer
${MULLE_KYBERNETIK_TAP}/mulle-clang-project'


DEBIAN_DEPENDENCIES='mulle-c-developer'
