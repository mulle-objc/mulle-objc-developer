#! /bin/sh
#
#   Copyright (c) 2016 Nat! - Mulle kybernetiK
#   All rights reserved.
#
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions are met:
#
#   Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
#   Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#   Neither the name of Mulle kybernetiK nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#   POSSIBILITY OF SUCH DAMAGE.
#

MULLE_BUILD_MIN_MAJOR="0"
MULLE_BUILD_MIN_MINOR="7"

REPOHOSTDIR="${1:-git@github.com:mulle-objc}"
[ $# -ne 0 ] && shift

BRANCH="${1:-master}"
[ $# -ne 0 ] && shift

#
# These are actualy non-bare repositories, that act like bare repositories.
# You can push to them and from there you can push to the origin
# In a hurry you can also edit in them. Be careful though, pushes
# from other repositories overwrite your changes!
#
QUASI_BARE_REPOS='mulle-tests
mulle-configuration
mulle-homebrew'

#
# These repositories must be in proper order of initialization.
# They are regular repositories that push to the origin
#
REPOS='mulle-c11
mulle-thread
mulle-allocator
mulle-vararg
mulle-aba
mulle-concurrent
mulle-container
mulle-objc
MulleObjC'

fail()
{
   echo "%@" >&2
   exit 1
}


setup_hooks()
{
   cat <<EOF >> "$i/.git/hooks/pre-receive" || exit 1
#!/bin/sh

#
# in case the user did some local edits: at least save them
# in the stash
#
SRC_DIR="\`dirname -- "\$PWD"\`"

(
   GIT_DIR="\$PWD" &&
   cd "\${SRC_DIR}" &&
   git stash save
)
EOF
   chmod 755 "$i/.git/hooks/pre-receive" || exit 1

   cat <<EOF >> "$i/.git/hooks/post-receive" || exit 1
#!/bin/sh
#
# ensure that pushes get reflected in the repository, so that
# old files don't look like edits.
#
SRC_DIR="\`dirname -- "\$PWD"\`"

(
   GIT_DIR="\$PWD" &&
   cd "\${SRC_DIR}" &&
   git reset -q --hard
)
EOF

   chmod 755 "$i/.git/hooks/post-receive" || exit 1
}


enable_push()
{
   ( GIT_DIR="$1/.git" git config receive.denyCurrentBranch ignore ) || exit 1
}


blurb_and_ask()
{
   cat <<EOF >&2
This script will clone the branch "${BRANCH}" of all needed mulle-objc
repositories from "${REPOHOSTDIR}" into the current directory. Then it
will set them up in a convenient way using mulle-build.

There will be a lot of warnings due to symlinks, but that's OK.

Press [RETURN] to continue, [CTRL]-[C] to abort
EOF

   read
}


check_mulle_build_version()
{
   local version
   local major
   local minor

   version="`mulle-build --version | head -1`"
   [ -z "${version}" ] && fail "mulle-build missing"

   major="`echo "${version}" | cut -s -d. -f1`"
   if [ "${major}" -gt "${MULLE_BUILD_MIN_MAJOR}" ]
   then
      return 1
   fi

   if [ "${major}" -eq "${MULLE_BUILD_MIN_MAJOR}" ]
   then
      minor="`echo "${version}" | cut -s -d. -f2`"
      if [ "${minor}" -lt "${MULLE_BUILD_MIN_MINOR}" ]
      then
         return 1
      fi
   fi

   return 0
}



main()
{
   check_mulle_build_version || fail "mulle-build too old, please update"

   [ -z "${DONT_ASK}" ] && blurb_and_ask

   local i

   for i in $QUASI_BARE_REPOS
   do
      if [ ! -d "$i" ]
      then
         git clone --branch "${BRANCH}" "${REPOHOSTDIR}/${i}" "${i}" || exit 1
         # setup_hooks "$i"
         # enable_push "$i"
         echo >&2
      else
         echo "${i} already exists, skipping..."
      fi
   done

   for i in $REPOS
   do
      if [ ! -d "$i" ]
      then
         git clone --branch "${BRANCH}" "${REPOHOSTDIR}/${i}" "${i}" || exit 1
         echo >&2
      else
         echo "${i} already exists, skipping..."
      fi
   done

   for i in $REPOS
   do
      echo "" >&2
      echo "### Setup $i" >&2
      echo "" >&2
      ( cd "$i" ; mulle-clean dist; mulle-build -y -es ) || exit 1
   done
}

main "$@"
