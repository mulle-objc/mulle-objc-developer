#! /bin/sh
#
#   Copyright (c) 2015 Nat! - Codeon GmbH
#   Copyright (c) 2016 3a4oT
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
# This shells scripts creates a clang plugin for mulle-clang. It copies
# an existing Apple LLVM compiler template and modifies it a little bit.
#
XCPLUGIN="$1"

if [ "${NO_COLOR}" != "YES" ]
then
   C_RESET="\033[0m"

   # Foreground colours
   C_BLACK="\033[0;30m"   C_RED="\033[0;31m"    C_GREEN="\033[0;32m"
   C_YELLOW="\033[0;33m"  C_BLUE="\033[0;34m"   C_MAGENTA="\033[0;35m"
   C_CYAN="\033[0;36m"    C_WHITE="\033[0;37m"  C_BR_BLACK="\033[0;90m"

   C_BR_RED="\033[0;91m" C_BR_YELLOW="\033[0;93m"

   trap 'printf "${C_RESET}"' TERM EXIT
fi


fail()
{
	echo "fatal error:" "$@" >&2
	exit 1
}


# bail when something fails
set -e

XCODE_DEVELOPER_PATH="`"xcode-select" -p`"
[ -d "${XCODE_DEVELOPER_PATH}" ] || fail "Xcode not installed ?"

XCODE_BUILD_VERSION=$(xcodebuild -version | grep -o '[0-9].[0-9].[0-9]$') # => major.minor.patch
MAJOR_VERSION=(${XCODE_BUILD_VERSION//./ }[0]) # => split to array and take major value
if [[ $MAJOR_VERSION > 7 ]]; then
  fail "Xcode ${XCODE_BUILD_VERSION} uses library validation. It won't load in-process plugins anymore. See https://github.com/alcatraz/Alcatraz/issues/475"
fi

XCODE_CONTENTS_PATH="`dirname ${XCODE_DEVELOPER_PATH}`"


if [ ! -d "${XCPLUGIN}" ]
then
	echo "Looking for Apple's Clang plugin in \"${XCODE_CONTENTS_PATH}\", this may take a while..." >&2

	XCPLUGIN="`find "${XCODE_CONTENTS_PATH}" -name "Clang LLVM*.xcplugin" -type d -print0 | tail -1`"
fi

XCPLUGIN_NAME="`basename "${XCPLUGIN}" .xcplugin`"

[ ! -z "${XCPLUGIN}" ] || fail "Clang LLVM not found."

echo "Found \"${XCPLUGIN}\"" >&2

#
# Install method #1 does not need sudo, I think that's preferable
#
sudo=
MULLE_XCPLUGIN="${HOME}/Library/Application Support/Developer/Shared/Xcode/Plug-ins/Mulle Clang.xcplugin"

#MULLE_XCPLUGIN="`dirname "${XCPLUGIN}"`/Mulle Clang.xcplugin"

MULLE_XCPLUGIN_NAME="`basename "${MULLE_XCPLUGIN}" .xcplugin`"

echo ""
echo "${C_GREEN}This script will now create the plugin${C_RESET}
\"${MULLE_XCPLUGIN}\""

if [ ! -z "${sudo}" ]
then
	echo "sudo will be needed for this."
fi
echo "${C_YELLOW}press RETURN to continue${C_RESET}"
read -r

if [ -e "${MULLE_XCPLUGIN}" ]
then
	echo "${C_RED}\"${MULLE_XCPLUGIN}\" already exists${C_RESET}"
	echo "It will be erased."

	if [ ! -z "${sudo}" ]
	then
		echo "sudo will be needed for this."
	fi
	echo "${C_YELLOW}press RETURN to continue${C_RESET}"
	read -r

	${sudo} rm -rf "${MULLE_XCPLUGIN}"
fi

${sudo} mkdir -p "${MULLE_XCPLUGIN}/Contents/Resources/English.lproj"

#
# bundle binary just gets copied, I don't know what it does
#

UUID="`defaults read "${XCODE_CONTENTS_PATH}/Info" DVTPlugInCompatibilityUUID`"
echo "Retrieved DVTPlugInCompatibilityUUID from \"${XCODE_CONTENTS_PATH}/Info\" as $UUID" >&2


echo "Installing custom \"Contents/Info.plist\" ..." >&2
cat <<EOF | ${sudo} tee "${MULLE_XCPLUGIN}/Contents/Info.plist" > /dev/null
{
	"CFBundleDevelopmentRegion" = English;
	CFBundleIdentifier = "de.codeon.compilers.mulle-clang";
	"CFBundleInfoDictionaryVersion" = "6.0";
	CFBundleName = "Mulle Clang Compiler Xcode Plug-in";
	XC4Compatible = YES;
	CFBundleVersion = 1848;
	CFBundlePackageType = BNDL;
	CFBundleSignature = "????";
	"CFBundleShortVersionString" = "5.3";
	DVTPlugInCompatibilityUUIDs = (
		"$UUID",
		"7265231C-39B4-402C-89E1-16167C4CC990",
		"0420B86A-AA43-4792-9ED0-6FE0F2B16A13",
		"7FDF5C7A-131F-4ABB-9EDC-8C5F8F0B8A90",
		"E969541F-E6F9-4D25-8158-72DC3545A6C6"
	);
	XCGCReady = YES;
	XCPluginHasUI = NO;
}
EOF


echo "Installing custom \"Contents/version.plist\" ..." >&2
cat <<EOF | ${sudo} tee "${MULLE_XCPLUGIN}/Contents/version.plist" > /dev/null
{
	BuildVersion = 2;
	"CFBundleShortVersionString" = "5.3";
	CFBundleVersion = 1848;
	ProjectName = XcodeMulleClangPlugin;
}
EOF


XCSPEC="${XCPLUGIN}/Contents/Resources/${XCPLUGIN_NAME}.xcspec"
MULLE_XCSPEC="${MULLE_XCPLUGIN}/Contents/Resources/${MULLE_XCPLUGIN_NAME}.xcspec"

#
# uses absolute paths, because otherwise Xcode  may not find it
#
echo "Patching \"Contents/Resources/${MULLE_XCPLUGIN_NAME}.xcspec\" ..." >&2
sed -e \
's/\.llvm\.clang\.1_0/\.mulle-clang/g' -e \
's/com\.apple\./de\.codeon\./g' -e \
's/LLVM [0-9\.]*/Clang/g' -e \
's/\=\ Apple/\=\ \"Codeon GmbH\"/g' -e \
's/Apple/Mulle/g' -e \
's/\"clang\"/\"\/usr\/local\/bin\/mulle-clang\"/g' -e \
's/\$(CLANG)/\/usr\/local\/bin\/mulle-clang/g' -e \
's/clang\+\+/\/usr\/local\/bin\/mulle-clang/g' -e \
's/DefaultValue\ =\ clang/DefaultValue = \/usr\/local\/bin\/mulle-clang/g' -e \
's/Apple Inc./Codeon GmbH/g' < "${XCSPEC}" | ${sudo} tee "${MULLE_XCSPEC}" > /dev/null

XCSTRINGS="${XCPLUGIN}/Contents/Resources/English.lproj/${XCPLUGIN_NAME}.strings"
MULLE_XCSTRINGS="${MULLE_XCPLUGIN}/Contents/Resources/English.lproj/${XCPLUGIN_NAME}.strings"

if [ -f "XCSTRINGS" ]
then
	echo "Copying \"Contents/Resources/English.lproj/${MULLE_XCPLUGIN_NAME}.strings\" ..." >&2
	${sudo} cp "${XCSTRINGS}" "${MULLE_XCSTRINGS}"
fi
