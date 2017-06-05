#! /usr/bin/env bash
#
#   Copyright (c) 2017 Nat! - Mulle kybernetiK
#   Copyright (c) 2017 Nat! - Codeon GmbH
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

MULLE_BUILD_VERSION=3.6.3
MULLE_BOOTSTRAP_VERSION=3.6.2
MULLE_CLANG_VERSION=4.0.0.4

#
# This script will eventually vanish and be replaced with proper deb
# packages
#
BOTTLES_URL='http://download.codeon.de/bottles'
BOOTSTRAP_URL='https://github.com/mulle-nat'
MULLE_OBJC_URL='https://github.com/mulle-nat'

PREFIX="/usr"


# todo: use -n an exekutor

fail()
{
   echo "${FAIL_EXE} error: $*" >&2
   exit 1
}

#
# will return
# zesty, yakkety, xenial, trusty, precise or so
#
ubuntu_releasename()
{
   lsb_release -s -c
}


preliminaries_trusty()
{
   # depressing: cmake on debian is too old and add-apt-repository
   # requires python and a lot of crap
   # from software-properties-common
   apt-get -y install software-properties-common &&

   #
   # git is needed by mulle-bootstrap
   # cmake is needed by mulle-bootstrap
   # build-essential is needed (?) by mulle-clang
   #
   add-apt-repository -y ppa:george-edison55/cmake-3.x
}


preliminaries_xenial()
{
   preliminaries_trusty
}


# modern enough I think
preliminaries_zesty()
{
   :
}


preliminaries_common()
{
   apt-get update &&
   apt-get -y install curl git build-essential cmake || exit 1
}


install_compiler()
{
   DIST="${UBUNTUNAME}-${ARCH}"
   DOWNLOAD_URL="${BOTTLES_URL}/mulle-clang-${MULLE_CLANG_VERSION}-${DIST}.deb"

   # get mulle-clang first, if this fails you don't need to wait so long
   curl -O -L "${BOTTLES_URL}/mulle-clang-${MULLE_CLANG_VERSION}-${DIST}.deb" &&
   dpkg --install "mulle-clang-${MULLE_CLANG_VERSION}-${DIST}.deb"
}


install_mulle_bootstrap()
{
   curl -O -L "${BOOTSTRAP_URL}/mulle-bootstrap/archive/${MULLE_BOOTSTRAP_VERSION}.tar.gz" &&
   tar xfz "${MULLE_BOOTSTRAP_VERSION}.tar.gz" &&
   ( cd mulle-bootstrap-${MULLE_BOOTSTRAP_VERSION}/ ; ./install.sh "${PREFIX}" )
}


install_mulle_build()
{
   curl -O -L "${BOOTSTRAP_URL}/mulle-build/archive/${MULLE_BUILD_VERSION}.tar.gz" &&
   tar xfz "${MULLE_BUILD_VERSION}.tar.gz" &&
   ( cd "mulle-build-${MULLE_BUILD_VERSION}" && ./install.sh "${PREFIX}" )
}



main()
{
   UBUNTUNAME="`ubuntu_releasename`" || fail "This is not an Ubunutu Linux"

   #
   # figure out bottle
   #
   ARCH="`uname -i`" || fail "Failed to figure out architecture"

   case "${ARCH}" in
      x86_64)
         ARCH="amd64"
      ;;

      *)
         fail "Only x86_64 is possible with this script. Build mulle-clang manually"
      ;;
   esac

   case "${UBUNTUNAME}" in
      zesty|trusty|xenial)
         preliminaries_${UBUNTUNAME}
      ;;

      *)
         fail "This script doesn't support ${UBUNTUNAME}"
      ;;

      "")
         fail "Could not figure out the ubuntu release"
      ;;
   esac

   preliminaries_common || exit 1

   install_compiler || exit  1

   # get mulle-bootstrap
   install_mulle_bootstrap || exit 1

   # get mulle-build
   install_mulle_build || exit 1

   #
   # build mulle-objc libraries
   # Don't do this, prefer people to use sandboxed stuff
   # mulle-install --prefix "${PREFIX}" --branch release "${MULLE_OBJC_URL}"/MulleObjC || exit 1
   if [ ! -f "CMakeLists.txt" ]
   then
      git clone "${MULLE_OBJC_URL}/mulle-objc-developer.git" mulle-objc-developer || exit 1
      cd mulle-objc-developer
   fi

   mulle-install --prefix "${PREFIX}"
}


FAIL_EXE="`basename -- $0`"

if [ "`id -u`" -ne 0 ]
then
   fail "use sudo to run this"
fi

main "$@"