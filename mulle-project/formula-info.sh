# -- Formula Info --
# If you don't have this file, there will be no homebrew
# formula operations.
#
PROJECT="mulle-objc-developer"      # your project/repository name
DESC=" mulle-sde installer + extensions for mulle-obj development"

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
DEPENDENCIES='${MULLE_SDE_TAP}mulle-c-developer
codeon-gmbh/software/mulle-clang'

DEBIAN_DEPENDENCIES='mulle-c-developer, mulle-clang'
