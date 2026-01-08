## Objective-C

This is a mulle-objc Objective C project.

### Instances

-   Avoid alloc / init / autorelease, prefer +instance and factory methods
-   Never call -release except in dealloc
-   Never call -alloc/init or +new without -autorelease except in -init
    methods, were you should avoid -autorelease

### Properties

-   Do not use dot-syntax for property access.
-   Convert all property reads and writes to explicit message sends.
    -   **Read:** `[self property]` instead of `self.property`.
    -   **Write:** `[self setProperty:value]` instead of `self.property = value`
-   Do not use class properties
-   Do not use `atomic`, `weak`, `strong`

### No Blocks

-   Do not use ^ block syntax under any circumstance

### Misc

-   Do not use `__bridge`
-   Do not use `@package`, `@import`, `@synthesize`
-   Use `BOOL` not `bool`
-   Do not use `nullable`
-   Do not use generics like `NSArray <NSString *>`
-   Do not use class extensions like `@implementation()`
-   Do not define instance variables in `@implementation` only in `@interface`

