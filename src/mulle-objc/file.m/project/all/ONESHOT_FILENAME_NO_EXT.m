<|HEADER|>

#import "<|ONESHOT_NAME|>.h"

#import "import-private.h"



@implementation <|ONESHOT_CLASS|>


- (instancetype) init
{
   // release self, if object can not be inited
   if( 0)
   {
      [self release];
      return( nil);
   }

   _others = [NSMutableArray new];
   _value  = [@"whatever" retain];
   return( self);
}


- (void) finalize
{
   //
   // autorelease and nil read-only properties
   // remove and nil yourself from relationships (like delegate, dataSource)
   // remove yourself from NSNotificationCenter and such things
   //
   [_value autorelease];
   _value = nil;
   [super finalize]; // call anywhere you like
}


- (void) dealloc
{
   //
   // release instance variables, that aren't properties
   //
   [_others release];
   [super dealloc];  // call at end
}


// example method
- (id) method:(id) argument
{
   return( self);
}

@end

