<|HEADER|>

#import "import.h"

//
// a MulleGenericObject contains a dictionary where to place key/values
// that way it can be easily expanded like a JavaScript object
// You can replace it with NSObject if you want
//
@interface <|ONESHOT_CLASS|> : MulleGenericObject
{
   NSMutableArray   *_others;
}


@property( readonly, copy) NSString  *value;
@property( retain) id                someObject;

- (id) method:(id) argument;

@end

