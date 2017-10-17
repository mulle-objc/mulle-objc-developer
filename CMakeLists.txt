cmake_minimum_required (VERSION 3.0)

project( mulle-objc-developer C)

execute_process( COMMAND mulle-objc-init --version
                 WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
                 OUTPUT_VARIABLE MULLE_OBJC_DEVELOPER_VERSION
                 OUTPUT_STRIP_TRAILING_WHITESPACE)
message( STATUS "MULLE_OBJC_DEVELOPER_VERSION is ${MULLE_OBJC_DEVELOPER_VERSION} according to mulle-objc-init")

set( PROJECT_VERSION "${MULLE_OBJC_DEVELOPER_VERSION}")
set( PUBLISHER "mulle-objc")

set( SCRIPTS
mulle-objc-init
mulle-objc-clone
)

set( RESOURCES
mulle-objc-logo-opaque-48x48.txt
)


if( APPLE)
  set( SCRIPTS
${SCRIPTS}
mulle-clang-add-to-xcode
)
endif()


INSTALL( FILES ${SCRIPTS}
PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
            GROUP_EXECUTE GROUP_READ
            WORLD_EXECUTE WORLD_READ
DESTINATION "bin")

INSTALL( FILES ${RESOURCES}
PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
            GROUP_EXECUTE GROUP_READ
            WORLD_EXECUTE WORLD_READ
DESTINATION "share/mulle-objc-init")


include( CMakePackage.txt)
