<|HEADER|>
// we wan't "import.h" always anyway
#import "import.h"


// **EDIT** define your properties her, if any
#define <|ONESHOT_CLASS|>Properties \
// @property id   whatever1;        \
// @property id   whatever2

// **EDIT** define your required instance variable here, if any
struct _<|ONESHOT_CLASS|>Ivars
{
//   int   whatevs1;
//   int   whatevs2
};

// you can leave these unchanged
#define <|ONESHOT_CLASS|>Ivars \
struct _<|ONESHOT_CLASS|>Ivars   <|ONESHOT_CLASS|>

// use "_get" as a sign that it's dangerous and private
#define <|ONESHOT_CLASS|>IvarsGetterInterface               \
- (struct _<|ONESHOT_CLASS|>Ivars *) _get<|ONESHOT_CLASS|>Ivars

#define <|ONESHOT_CLASS|>IvarsGetterImplementation          \
- (struct _<|ONESHOT_CLASS|>Ivars *) <|ONESHOT_CLASS|>Ivars \
{                                                           \
   return( &self-><|ONESHOT_CLASS|>Ivars);                  \
}


// **EDIT** define your protocol here
PROTOCOLCLASS_INTERFACE( <|ONESHOT_CLASS|>, NSObject)

<|ONESHOT_CLASS|>Properties;
<|ONESHOT_CLASS|>IvarsGetterInterface;

@optional
// - (id) method;   // methods with default implementations

PROTOCOLCLASS_END();

// A typical adopting class will look like this:
// @interface Adopter : NSObject < <|ONESHOT_CLASS|>>
// {
//    <|ONESHOT_CLASS|>Ivars;
// }
// <|ONESHOT_CLASS|>Properties;
// @end
//
// @implementation Adopter
// <|ONESHOT_CLASS|>IvarsGetterImplementation;
// @end
<|FOOTER|>
