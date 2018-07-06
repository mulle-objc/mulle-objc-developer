#
# The following includes include definitions generated
# during `mulle-sde update`. Don't edit those files. They are
# overwritten frequently.
#
# === MULLE-SDE START ===

include( _Headers)
include( _Sources)

# === MULLE-SDE END ===
#

# add ignored headers back in
set( PUBLIC_HEADERS
"<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-import.h"
"<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include.h"
${PUBLIC_HEADERS}
)

set( PRIVATE_HEADERS
"<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-import-private.h"
"<|PROJECT_SOURCE_DIR|>/_<|PROJECT_NAME|>-include-private.h"
${PRIVATE_HEADERS}
)

#
# You can put more source and resource file definitions here.
#
