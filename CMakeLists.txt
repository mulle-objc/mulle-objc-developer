cmake_minimum_required( VERSION 3.0)

project( mulle-objc-developer NONE)

set( PROJECT_VERSION 0.14.7)


if( APPLE)
   set( SCRIPTS
      mulle-clang-add-to-xcode
   )
endif()

set( EXTENSIONS
   src/  #backslash is important
)

set( PIX
   pix/mulle-logo-48x48.txt
   pix/mulle-objc-logo-opaque-48x48.txt
)

INSTALL( FILES ${SCRIPTS}
   PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
               GROUP_EXECUTE GROUP_READ
               WORLD_EXECUTE WORLD_READ
   DESTINATION "bin"
)

install( DIRECTORY ${EXTENSIONS}
   DESTINATION "share/mulle-sde/extensions"
   USE_SOURCE_PERMISSIONS
   PATTERN "*._DS_Store|.ignore" EXCLUDE
)

install( FILES ${PIX}
   DESTINATION "share/mulle-sde/pix"
)


######
#
# must be after CPACK_PACKAGE_VERSION
include( CMakePackage.cmake) # need extension
include( CPack)
