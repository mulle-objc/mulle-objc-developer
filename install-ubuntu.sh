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

   # needed for travis but why ???
   sudo chown 755 /etc/apt/sources.list.d

   #
   # add Codeon debian/ubuntu key and repository
   #
   log_verbose "Add Codeon GmbH apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "https://www.codeon.de/dists/nat-codeon.asc" |
      sudo apt-key add -

    sudo echo "deb [arch=amd64] http://download.codeon.de `lsb_release -c -s` main" \
       > "/etc/apt/sources.list.d/codeon.de-main.list" || exit 1

   #
   # add Mulle kybernetiK debian/ubuntu key and repository
   #
   log_verbose "Add Mulle kybernetiK apt source"

   ${HTTPGET} ${HTTPGETFLAGS} "${PUBLISHER_PUBLICKEY_URL}" |
      sudo apt-key add - &&
      sudo echo "deb [arch=all] ${PUBLISHER_DEBIAN_URL} `lsb_release -c -s` main" \
         > "/etc/apt/sources.list.d/${PUBLISHER_DOMAIN}-main.list" || exit 1

   #
   # We need cmake >= 3.0.0 eventually, so add it for older linux versions
   #
   case `lsb_release -c -s` in
      trusty|xenial|wily)
        #
        # same as `sudo add-apt-repository ppa:george-edison55/cmake-3.x`, but
        # doesn't require software-properties-common which adds 40MB for just
        # these two lines
        #
        log_verbose "Install cmake 3.x from george-edison55"

        sudo apt-key adv --keyserver keyserver.ubuntu.com \
                         --recv-keys  0x084ECFC5828AB726 &&
        sudo echo "deb http://ppa.launchpad.net/george-edison55/cmake-3.x/ubuntu `lsb_release -c -s` main" \
           > "/etc/apt/sources.list.d/george-edison55-main.list" || exit 1
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
