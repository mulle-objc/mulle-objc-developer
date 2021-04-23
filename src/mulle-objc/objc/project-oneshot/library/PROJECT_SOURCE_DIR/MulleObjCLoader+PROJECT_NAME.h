/*
 * template: project-oneshot/library/PROJECT_SOURCE_DIR/MulleObjCLoader+PROJECT_NAME.h
 * vendor/extension: mulle-objc/objc
 */
#ifdef __MULLE_OBJC__

#import <MulleObjC/MulleObjC.h>

//
// This header file is required to be public, to enable other libraries that
// depend on this library to properly declare their load in their
// MulleObjcLoader class.
//
@interface MulleObjCLoader( <|PROJECT_IDENTIFIER|>)

+ (struct _mulle_objc_dependency *) dependencies;

@end

#endif

