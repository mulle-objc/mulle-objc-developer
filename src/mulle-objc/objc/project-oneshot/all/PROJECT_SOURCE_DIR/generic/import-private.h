/* DO:    #import this files in sources
 *
 * DONT:  #import this files in headers
 *        #include this file anywhere
 *
 * This is a central include file to not expose includes to consumers of
 * this library. It must not be imported by .h files, but by .m and
 * .aam files only.
*/

/*
 * Get C includes first, if any
 *
 * #ifdef __has_include
 * # if __has_include( "include-private.h")
 * #   include "include-private.h"
 * # endif
 * #endif
 */

#import "import.h"

/* Include the header file automatically generated by mulle-sourcetree-to-c.
   Here the prefix is harmless and serves disambiguation. If you have no
   sourcetree, then you don't need it.
 */
#import "_<|PROJECT_NAME|>-import-private.h"

/* You can add some more import statements here */


