#! /bin/sh


PROJECT="MulleObjcDeveloper" # requires camel-case
DESC="mulle-objc Developer Environment"
DEPENDENCIES='${BOOTSTRAP_TAP}mulle-bootstrap
${BOOTSTRAP_TAP}mulle-build
codeon-gmbh/software/mulle-clang'     # no camel case, will be evaled later!
LANGUAGE=c                            # c,cpp, objc


# defaults that can be changed with options
PUBLISHER="mulle-nat"
PUBLISHER_TAP="mulle-kybernetik/software/"
DEPENDENCY_TAP="mulle-kybernetik/software/"
BOOTSTRAP_TAP="mulle-kybernetik/alpha/"


#
# Ideally you don't hafta change anything below this line
#
# source mulle-homebrew.sh (clumsily)
MULLE_BOOTSTRAP_FAIL_PREFIX="release.sh"

DIR="`dirname -- "$0"`"
. ${DIR}/mulle-homebrew/mulle-homebrew.sh || exit 1
cd "${DIR}/.."

VERSION="`head -1 "VERSION"`"
[ -z "${VERSION}" ] && echo "Can't find VERSION in $PWD" && exit 1


# parse options
homebrew_parse_options "$@"

# dial past options
while [ $# -ne 0 ]
do
   case "$1" in
      -*)
         shift
      ;;

      *)
         break;
      ;;
   esac
done


#
# these can usually be deduced, if you follow the conventions
#
NAME="`get_name_from_project "${PROJECT}" "${LANGUAGE}"`"

# --- HOMEBREW FORMULA ---
# Information needed to construct a proper brew formula
#
HOMEPAGE="${REMOTEURL}/${NAME}"

# --- HOMEBREW TAP ---
# Specify to where and under what bame to publish via your brew tap
#
RBFILE="${NAME}.rb"                    # ruby file for brew
HOMEBREWTAP="../homebrew-`basename -- ${PUBLISHER_TAP}`"     # your tap repository path


# ARCHIVEURL will be evaled later! keep it in single quotes
# where homebrew grabs the archive off
ARCHIVEURL="https://github.com/mulle-nat/${NAME}/archive/${VERSION}.tar.gz"

# written into formula for homebrew, will be evaled
HOMEPAGE="https://github.com/${PUBLISHER}/${NAME}"

# git remote to push to, usually origin
ORIGIN='origin'



# --- GIT ---
# tag to tag your release
# and the origin where
TAG="${TAG:-${VERSION}}"


main()
{
   git_main "${ORIGIN}" "${TAG}" || exit 1
   homebrew_main
}

main "$@"
