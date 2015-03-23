//
//  LoadHotelsJSONData.h
//  Visit Jordan
//
//  Created by Faris on 10/30/13.
//
//

#import <Foundation/Foundation.h>

@interface LoadHotelsJSONData : NSObject
 @property  (nonatomic,strong) NSDictionary* json,*data;
-(NSDictionary *)loadDataFromURL:(NSString *) url;
-(void) executeInBackground:(NSString *) url;
-(void) executeOnMainThread:(NSString *) url;
@end
