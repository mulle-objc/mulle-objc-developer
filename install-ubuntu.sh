#! /bin/sh

if [ ! -z "${TRACE}" ]
then
   echo "$0" >&2
   env | sort >&2
   set -x
fi

DEVELOPER_PACKAGE="${DEVELOPER_PACKAGE:-mulle-objc-developer}"
CC_PRIORITY="${CC_PRIORITY:-18}"


CURLFLAGS="-sS"
WGETFLAGS="-q -O -"

HTTPGET="curl"
HTTPGETFLAGS="${CURLFLAGS}"

# todo: use -n an exekutor

fail()
{
   echo "${FAIL_EXE} error: $*" >&2
   exit 1
}


# colorize later or never
log_verbose()
{
   echo "<(|)> $*" >&2
}


add_codeon_apt_source()
{
   local osrelease="$1"

   log_verbose "Add Codeon GmbH apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "https://www.codeon.de/dists/codeon-pub.asc" |
      apt-key add - &&
      echo "deb [arch=amd64] http://download.codeon.de ${osrelease} main" \
         > "/etc/apt/sources.list.d/codeon.de-main.list"
}


add_mulle_apt_source()
{
   local osrelease="$1"

   log_verbose "Add Mulle kybernetiK apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "https://www.mulle-kybernetik.com/dists/debian-admin-pub.asc" |
      apt-key add - &&
      echo "deb [arch=all] http://www.mulle-kybernetik.com ${osrelease} main" \
         > "/etc/apt/sources.list.d/mulle-kybernetik.com-main.list"
}


add_community_apt_source()
{
   local osrelease="$1"

   log_verbose "Add mulle-objc community apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "https://www.mulle-kybernetik.com/mulle-objc-community/dists/admin-pub.asc" |
      apt-key add - &&
      echo "deb [arch=all] http://www.mulle-kybernetik.com/mulle-objc-community ${osrelease} main" \
         > "/etc/apt/sources.list.d/mulle-objc-community.mulle-kybernetik.com-main.list"
}


#
# same as `add-apt-repository ppa:george-edison55/cmake-3.x`, but
# doesn't require software-properties-common which adds 40MB for just
# these two lines
#

add_cmake_3_apt_source()
{
   local osrelease="$1"

   log_verbose "Install cmake 3.x from george-edison55"

   apt-key adv --keyserver keyserver.ubuntu.com \
                    --recv-keys  0x084ECFC5828AB726 &&
   echo "deb http://ppa.launchpad.net/george-edison55/cmake-3.x/ubuntu ${osrelease} main" \
      > "/etc/apt/sources.list.d/george-edison55-main.list"
}


main()
{
   case "$1" in
      -h|--help)
         cat <<EOF  >&2
Usage: install-ubuntu

This script uses apt-get to install. There are no options.

It will add a few public keys to your apt gpg keys.
It will also add a few sources to your apt sources.

Then it will install cmake requirements for mulle-clang if necessary.
Finally it will install mulle-clang and other required development tools.
EOF
         return 0
      ;;
   esac

   #
   # use wget because it's more lightweight
   #
   if [ -z "`command -v "curl"`" ]
   then
      HTTPGET="wget"
      HTTPGETFLAGS="${WGETFLAGS}"

      if [ -z "`command -v "wget"`" ]
      then
         apt-get update ${APTFLAGS} "$@"  # ignore failures here
         apt-get install ${APTFLAGS} "$@" wget || exit 1
      fi
   fi

   #
   # travis doesn't have this ?
   #
   if [ ! -d "/etc/apt/sources.list.d" ]
   then
      mkdir -p /etc/apt/sources.list.d
   fi

   if dpkg -l mulle-clang > /dev/null
   then
      echo "This script is only useful for an initial installation." >&2
      echo "But mulle-clang is already installed. Please just use" >&2
      echo "   sudo apt-get upgrade ${DEVELOPER_PACKAGE}" >&2
      exit 1
   fi

   local osrelease

   osrelease="`lsb_release -c -s`" || exit 1


   #
   # add Codeon debian/ubuntu key and repository
   #
   add_codeon_apt_source "${osrelease}" || exit 1

   #
   # add Mulle kybernetiK debian/ubuntu key and repository
   #
   add_mulle_apt_source "${osrelease}" || exit 1


   #
   # add Mulle kybernetiK debian/ubuntu key and repository
   #
   add_community_apt_source "${osrelease}" || exit 1

   #
   # We need cmake >= 3.0.0 eventually, so add it for older linux versions
   #
   case "${osrelease}" in
      trusty|xenial|wily)
        add_cmake_3_apt_source "${osrelease}" || exit 1
      ;;
   esac


   #
   # Now update and install
   #
   log_verbose "Install ${DEVELOPER_PACKAGE}"

   apt-get update ${APTFLAGS} "$@"  # ignore failures
   apt-get install ${APTFLAGS} "$@" "${DEVELOPER_PACKAGE}" || exit 1

   #
   # Make known as a viable c compiler
   # Should the priority be above gcc ? Probably not
   #
   log_verbose "Set mulle-clang as cc with priority ${CC_PRIORITY}"

   update-alternatives --install "/usr/bin/cc" \
                                 "cc" \
                                 "/usr/bin/mulle-clang" \
                                 "${CC_PRIORITY}"

   DEVELOPER_INIT="`echo "${DEVELOPER_PACKAGE}" | sed 's/developer/init/'`"
   cat <<EOF

Done! For starters try:
   ${DEVELOPER_INIT} -d hello executable

EOF
}

main "$@"
