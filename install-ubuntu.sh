#! /bin/sh

PUBLISHER_PUBLICKEY_URL="http://www.mulle-kybernetik.com/dists/admin-pub.asc"
PUBLISHER_DEBIAN_URL="http://www.mulle-kybernetik.com"
PUBLISHER_DOMAIN="mulle-kybernetik.com"


CURLFLAGS="-sS -O"
WGETFLAGS="-q -O -"

HTTPGET="curl"
HTTPGETFLAGS="${CURLFLAGS}"

#
# use wget because it's more lightweight
#
if [ -z "`command -v "curl"`" ]
then
   HTTPGET="wget"
   HTTPGETFLAGS="${WGETFLAGS}"

   if [ -z "`command -v "wget"`" ]
   then
      sudo apt-get update &&
      sudo apt-get "$@" install wget
   fi
fi


#
# add Codeon debian/ubuntu key and repository
#
${HTTPGET} ${HTTPGETFLAGS} "https://www.codeon.de/dists/nat-codeon.asc" | sudo apt-key add -
sudo echo "deb [arch=amd64] http://download.codeon.de `lsb_release -c -s` main" > /etc/apt/sources.list.d/codeon.de-main.list

#
# add Mulle kybernetiK debian/ubuntu key and repository
#
${HTTPGET} ${HTTPGETFLAGS} "${PUBLISHER_PUBLICKEY_URL}" | sudo apt-key add -
sudo echo "deb [arch=all] ${PUBLISHER_DEBIAN_URL} `lsb_release -c -s` main" > /etc/apt/sources.list.d/${PUBLISHER_DOMAIN}-main.list

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
     sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys  0x084ECFC5828AB726
     sudo echo "deb http://ppa.launchpad.net/george-edison55/cmake-3.x/ubuntu  `lsb_release -c -s` main" > /etc/apt/sources.list.d/george-edison55-main.list
   ;;
esac


#
# Now update and install
#
sudo apt-get update &&
sudo apt-get "$@" install "${DEVELOPER_PACKAGE:-mulle-objc-developer}"

#
# Make known as a viable c compiler
# Should the priority be above gcc ? Probably not
#
sudo update-alternatives --install "/usr/bin/cc"  "cc" "/usr/bin/mulle-clang" "${CC_PRIORITY:-18}"


