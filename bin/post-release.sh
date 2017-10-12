# -- Post Release --
# Push stuff into debian repository
#

post_release()
{
   local projectidentifier
   local flag
   local key

   #
   #

   if [ -z "${PUBLISHER_DEBIAN_GPG_PATH}" ]
   then
      log_verbose "PUBLISHER_DEBIAN_GPG_PATH is not defined, so no debian release"
      return
   fi

   projectidentifier="`echo "${PROJECT}" | tr '[-._]' '_' | tr 'a-z' 'A-Z'`"
   key="${projectidentifier}_DEBIAN"
   flag="`eval echo \$\{${key}\}`"
   if [ "${flag}" = "NO" ]
   then
      log_verbose "${key} is set to NO, so no debian release"
      return
   fi

   #
   # sanity check
   #

   exekutor mulle-homebrew-debian
}

