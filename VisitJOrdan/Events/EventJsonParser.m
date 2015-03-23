//
//  EventJsonParser.m
//  Visit Jordan
//
//  Created by Faris on 10/21/13.
//
//

#import "EventJsonParser.h"

@implementation EventJsonParser

-(id)initWithDictionary:(NSDictionary*)d error:(NSError *__autoreleasing *)err
{
    self = [super init];
    
    if (self) {
        self.event = [[EventModel alloc] initWithDictionary: d[@"name"] error:err];
         if (!self.event) return nil;
    }
    
    return self;
}
@end
