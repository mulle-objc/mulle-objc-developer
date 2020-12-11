/* DOS:   #import this files in public headers

   DONTS: #import this file in private headers
          #import this files directly in sources
          #include this file anywhere
*/

/* This is a central include file to keep dependencies out of the library
   Objective-C files. It is usally imported by Objective-C .h files only.
   .m and .aam use import-private.h.
*/

/*
 * Get C includes first, if
 *
 * #ifdef __has_include
 * # if __has_include( "include.h")
 * #   include "include.h"
 * # endif
 * #endif
*/

/* Include the header file automatically generated by mulle-sourcetree-to-c.
   Here the prefix is harmless and serves disambiguation. If you have no
   sourcetree, then you don't need it.
 */

#import "_<|PROJECT_NAME|>-import.h"

/* You can add some more import statements here */
