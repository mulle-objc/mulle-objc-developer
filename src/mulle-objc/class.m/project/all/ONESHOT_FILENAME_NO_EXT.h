<|HEADER|>
#ifdef __has_include
# if __has_include( "<|SUPERCLASS:-NSObject|>.h")
#  import "<|SUPERCLASS:-NSObject|>.h"
# endif
#endif

#import "import.h"


@interface <|ONESHOT_CLASS|> : <|SUPERCLASS:-NSObject|>
//{
// @private                     // Tip: avoid @private as much as possible
//   NSMutableArray   *_others; // Tip: use properties if possible
//}


// @property( readonly, copy) NSString  *value;         // prefer copy for all value objects 
// @property( retain) id                iOwnObject;     // retain for objects you own and cant copy
// @property( assign) id                myOwnerObject;  // assign for relationships to objects that own you

// - (id) method:(id) argument;

@end
<|FOOTER|>

