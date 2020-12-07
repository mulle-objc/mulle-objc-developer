<|HEADER|>
// prefer a local <|ONESHOT_CLASS|> over one in import.h
#ifdef __has_include
# if __has_include( "<|ONESHOT_CLASS|>.h")
#  import "<|ONESHOT_CLASS|>.h"
# endif
#endif

// we want "import.h" always anyway
#import "import.h"


@interface <|ONESHOT_CLASS|>( <|ONESHOT_CATEGORY|>)

// @property( assign) NSUInteger  value;
// @property( retain) id          other;

// - (id) method:(id) other;

@end
<|FOOTER|>
