<|HEADER|>
#import "<|ONESHOT_NAME|>.h"

#import "import-private.h"



@implementation <|ONESHOT_CLASS|>


- (instancetype) init
{
   // // Call [super init], if subclassing something else than NSObject.
   // // Some superclasses may fail and return nil.
   // self = [super init];
   // if( ! self)
   //    return( self);
   //
   //
   // // Release self and return nil, if object can not be inited
   // if( somethingElseThanSuperFailed)
   // {
   //    [self release];
   //    return( nil);
   // }

   //
   // // Initialize ivars and properties without using the setter (preferably)
   // // Avoid factory methods and using +instance or -autorelease, as init
   // // methods are special in this way.
   //   _others = [NSMutableArray new];
   //   _value  = [@"whatever" copy];

   return( self);
}


// If you want to support <NSCopying>, use this template
// code to avoid very hard to debug pitfalls in the future.
- (id) copy
{
   <|ONESHOT_CLASS|>   *copy;

   // check that the subclass is actually implementing -copy, otherwise the
   // user is probably in a world of pain soon afterwards
   // ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   // ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   // ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⠚⠋⢙⠉⠛⢶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   // ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⢴⣿⣷⣶⣤⣰⠆⠀⠀⢀⡰⢟⣩⣵⣷⣶⣶⣿⣿⣾⡀⢄⠐⠀⠐⠀⠂⠀⠆⠀⠆⠐⢀⣰⣠⣴⣿⣿⣶
   // ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠿⠿⠻⠀⠂⠀⠂⢻⣯⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⢮⡀⢆⠀⡂⢐⠀⡆⠠⠣⠌⢻⠛⠟⠩⠉⠍
   // ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠹⣿⣿⠿⠋⠉⠉⢲⡆⠀⡂⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀
   // ⣆⠀⣀⢠⡄⠤⢴⣴⣶⣶⣶⣶⣾⣿⣷⡄⠀⠀⢀⠀⠀⢠⣤⣤⣰⣶⣾⣿⣷⠆⠀⢀⠾⠿⠆⣧⣼⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⢺⠆⠀⠀⠀⠀
   // ⡃⠀⠈⢸⢐⢚⣺⣿⠿⣿⣿⣿⣿⣿⣿⠁⠀⠐⠻⣿⣦⣾⣿⣿⣿⣧⣿⣿⣿⣿⣾⡔⣀⠀⣠⣿⣟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀
   // ⡁⠀⠐⠘⢈⣈⣆⣹⣃⣻⣿⣿⣿⣿⣷⣀⠀⠀⠀⣈⡉⠙⢿⣿⣿⠈⣿⣿⣿⣿⣿⢨⣾⣏⢙⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀
   // ⠀⠀⠀⠀⢀⢀⡀⢀⠶⢂⠟⣿⣿⣿⣿⣿⣷⣶⣿⣿⣿⣷⡄⠀⠟⠀⢸⣆⠀⠁⠀⠈⠉⠉⠀⠉⠀⠀⠀⠤⠤⠤⠶⠶⠴⠶⠶⠶⠷⠶⠿⠷⠶
   // ⠂⠀⠀⠠⠶⣸⣘⣩⣉⣈⣉⣿⣿⣿⣿⣟⠉⠉⠙⠿⠿⢟⣵⣆⣠⡔⠀⠙⠷⡆⠀⠀⠀⠀⢀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   // ⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢿⣦⡀⠀⠀⠐⣤⣔⡀⢶⣾⣿⡄⠀⠢⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   // ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣁⣠⣤⣭⣷⣿⣷⡄⠹⣷⣤⡀⠀⠈⠻⣿⣿⣿⣿⣿⡆⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿
   // ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠛⠛⣛⣹⣿⣿⡧⠀⣿⣿⣿⣿⣦⠀⠙⢿⣿⣿⣿⡷⠀⠀⠀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
   // ⣿⣿⣿⣿⡿⠋⠠⠤⠀⠈⠋⠁⡀⠈⠹⢿⣦⣤⠀⠀⠻⢿⣿⣿⡇⠀⣻⣿⣿⣿⣿⣷⡄⠀⠈⠻⣿⡇⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
   // ⣿⣿⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠻⣿⡄⠀⠀⠀⠻⣿⠇⠀⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠘⠁⠀⠀⠀⠀⠀⠙⣿⣷⣶⡞⢉⣴⡾⡟⠫
   // ⡞⣷⠇⡟⣷⣿⢸⢸⢸⣻⢾⣟⢤⢸⡃⣿⣼⠘⡟⢸⣟⢸⣻⢸⡇⣷⣿⣼⣻⢹⢿⢿⢹⢹⣼⣧⡇⣿⣷⢸⣻⢸⡇⢸⢻⣎⢱⣿⡆⣟⡛⠛⠃
   // ⣿⠿⢀⠧⠟⠻⠼⢸⡸⠸⠿⠧⢸⠸⠤⠿⠿⠀⠇⠸⠧⠸⠸⠸⠇⠏⠿⠻⠽⢸⠸⠻⢾⡼⣟⡿⠇⠿⠿⠸⠸⠺⠧⠸⠼⣿⣼⠿⡇⠇⠀⠀⠀
   // ⠀⠀⢈⠀⠀⠀⠀⠉⠉⠈⠉⠉⠘⢛⠿⠸⠿⠇⠀⠀⠀⢀⣀⡀⣀⡀⣀⢐⢛⢻⣿⣿⣵⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿
   // ⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠴⠦⠀⠀⣴⣶⣾⡀⠀⠀⢸⡷⢇⣏⡇⣿⢸⣿⢸⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⣽⣿⢹⣿⣿⣿
   // ⡀⠀⢸⢀⣀⣀⡀⠤⢤⡄⠀⠀⠀⠀⠐⡿⠿⣿⣷⣤⣤⠘⡃⠘⠃⠓⠛⠘⣸⣼⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⡇⣇⣈⣈⣉⣉⣹
   assert( MulleObjCClassImplementsSelector( [self class], @selector( copy)) &&
           "your subclass must implement -copy and then start by "
           "calling [super copy] then add additional copy code");

   copy = [super copy];
   if( copy)
   {
      // additional copy code
      // You be the judge what should appear in a copy or not.
      // For a CALayer you want at least all observable properties
      // For a UIView you probably want to use self as a prototype for
      // another view (copy/paste)
      // Copying a UUID would be bad obviously.
   }
   return( copy);
}


- (void) finalize
{
   //
   // // Autorelease and nil read-only properties.
   // // Remove and nil yourself from relationships (like delegate, dataSource).
   // // Remove yourself from NSNotificationCenter and such things.
   //
   //   [_value autorelease];
   //   _value = nil;
   [super finalize]; // call anywhere you like, but usually last
}


- (void) dealloc
{
   //
   // Release instance variables, that aren't properties.
   //
   //   [_others release];
   [super dealloc];  // call at end
}


// example method
//- (id) method:(id) argument
//{
//   return( self);
//}

@end
<|FOOTER|>
