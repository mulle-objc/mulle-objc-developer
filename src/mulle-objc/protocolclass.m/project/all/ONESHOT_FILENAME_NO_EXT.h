<|HEADER|>
// prefer a local <|ONESHOT_CLASS|> over one in import.h
#ifdef __has_include
# if __has_include( "<|ONESHOT_CLASS|>.h")
#  import "<|ONESHOT_CLASS|>.h"
# endif
#endif

// we wan't "import.h" always anyway
#import "import.h"


// **EDIT** define your properties her, if any
#define <|ONESHOT_CLASS|>Properties \
// @property id   whatever1;        \
// @property id   whatever2


// **EDIT** define your protocol here
PROTOCOLCLASS_INTERFACE( <|ONESHOT_CLASS|>, NSObject)

<|ONESHOT_CLASS|>Properties;

@optional
// - (id) method;   // methods with default implementations

PROTOCOLCLASS_END();

// A typical adopting class will look like this:
// @interface Adopter : NSObject < <|ONESHOT_CLASS|>>
// <|ONESHOT_CLASS|>Properties;
// @end
//
// @implementation Adopter
// @end
<|FOOTER|>
