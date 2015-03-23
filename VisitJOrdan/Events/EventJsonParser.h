//
//  EventJsonParser.h
//  Visit Jordan
//
//  Created by Faris on 10/21/13.
//
//

#import <Foundation/Foundation.h>
#import "EventModel.h"
#import "JSONModel.h"

@interface EventJsonParser : JSONModel
@property (nonatomic,strong) EventModel * event;
-(id)initWithDictionary:(NSDictionary*)d error:(NSError *__autoreleasing *)err;
@end
