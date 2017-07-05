#! /bin/sh

if [ ! -z "${TRACE}" ]
then
   echo "$0" >&2
   env | sort >&2
   set -x
fi

PUBLISHER_PUBLICKEY_URL="http://www.mulle-kybernetik.com/dists/admin-pub.asc"
PUBLISHER_DEBIAN_URL="http://www.mulle-kybernetik.com"
PUBLISHER_DOMAIN="mulle-kybernetik.com"
DEVELOPER_PACKAGE="${DEVELOPER_PACKAGE:-mulle-objc-developer}"
CC_PRIORITY="${CC_PRIORITY:-18}"

[ -z "${PUBLISHER_PUBLICKEY_URL}" ] && echo "PUBLISHER_PUBLICKEY_URL is missing" >&2 && exit 1
[ -z "${PUBLISHER_DEBIAN_URL}" ] && echo "PUBLISHER_DEBIAN_URL is missing" >&2 && exit 1
[ -z "${PUBLISHER_DOMAIN}" ] && echo "PUBLISHER_DOMAIN is missing" >&2 && exit 1

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


# run with sudo
add_codeon_apt_source()
{
   local osrelease="$1"

   log_verbose "Add Codeon GmbH apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "https://www.codeon.de/dists/nat-codeon.asc" |
      apt-key add - &&
      echo "deb [arch=amd64] http://download.codeon.de ${osrelease} main" \
         > "/etc/apt/sources.list.d/codeon.de-main.list"
}


add_mulle_apt_source()
{
   local osrelease="$1"

   log_verbose "Add Mulle kybernetiK apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "${PUBLISHER_PUBLICKEY_URL}" |
      apt-key add - &&
      echo "deb [arch=all] ${PUBLISHER_DEBIAN_URL} ${osrelease} main" \
         > "/etc/apt/sources.list.d/${PUBLISHER_DOMAIN}-main.list"
}


#
# same as `sudo add-apt-repository ppa:george-edison55/cmake-3.x`, but
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
   #
   # use wget because it's more lightweight
   #
   if [ -z "`command -v "curl"`" ]
   then
      HTTPGET="wget"
      HTTPGETFLAGS="${WGETFLAGS}"

      if [ -z "`command -v "wget"`" ]
      then
         sudo apt-get update ${APTFLAGS} &&
         sudo apt-get install ${APTFLAGS} "$@" wget || exit 1
      fi
   fi

   #
   # travis doesn't have this ?
   #
   if [ ! -d "/etc/apt/sources.list.d" ]
   then
      sudo mkdir -p /etc/apt/sources.list.d
   fi

   local osrelease

   osrelease="`lsb_release -c -s`" || exit 1


   #
   # add Codeon debian/ubuntu key and repository
   #
   sudo add_codeon_apt_source "${osrelease}" || exit 1

   #
   # add Mulle kybernetiK debian/ubuntu key and repository
   #
   sudo add_mulle_apt_source "${osrelease}" || exit 1

   #
   # We need cmake >= 3.0.0 eventually, so add it for older linux versions
   #
   case "${osrelease}" in
      trusty|xenial|wily)
        sudo add_cmake_3_apt_source "${osrelease}" || exit 1
      ;;
   esac


   #
   # Now update and install
   #
   log_verbose "Install ${DEVELOPER_PACKAGE}"

   sudo apt-get update ${APTFLAGS} &&
   sudo apt-get install ${APTFLAGS} "$@" "${DEVELOPER_PACKAGE}" || exit 1

   #
   # Make known as a viable c compiler
   # Should the priority be above gcc ? Probably not
   #
   log_verbose "Set mulle-clang as cc with priority ${CC_PRIORITY}"

   sudo update-alternatives --install "/usr/bin/cc" \
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
