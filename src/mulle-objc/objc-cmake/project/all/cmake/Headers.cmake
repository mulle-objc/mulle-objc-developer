#
# The following includes include definitions generated
# during `mulle-sde update`. Don't edit those files. They are
# overwritten frequently.
#
# === MULLE-SDE START ===

include( _Headers OPTIONAL)

# === MULLE-SDE END ===
#

# add ignored headers back in


# add ignored headers back in so that the generators pick them up
if( EXISTS "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-import.h")
   set( PUBLIC_HEADERS
      "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include.h"
      ${PUBLIC_HEADERS}
   )
endif()
if( EXISTS "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include.h")
   set( PUBLIC_HEADERS
      "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include.h"
      ${PUBLIC_HEADERS}
   )
endif()


# keep headers to install separate to make last minute changes
set( INSTALL_PUBLIC_HEADERS ${PUBLIC_HEADERS})

#
# Do not install generated private headers and include-private.h
# which aren't valid outside of the project scope.
#
set( INSTALL_PRIVATE_HEADERS ${PRIVATE_HEADERS})
if( INSTALL_PRIVATE_HEADERS)
   list( REMOVE_ITEM INSTALL_PRIVATE_HEADERS "import-private.h")
   list( REMOVE_ITEM INSTALL_PRIVATE_HEADERS "include-private.h")
endif()

# add ignored headers back in so that the generators pick them up
if( EXISTS "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-import-private.h")
   set( PRIVATE_HEADERS
      "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include-private.h"
      ${PRIVATE_HEADERS}
   )
endif()
if( EXISTS "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include-private.h")
   set( PRIVATE_HEADERS
      "<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include-private.h"
      ${PRIVATE_HEADERS}
   )
endif()


#
# You can put more source and resource file definitions here.
#
