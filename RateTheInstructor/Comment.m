//
//  Comment.m
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/14/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import "Comment.h"
@interface Comment ()
@property NSArray *allComments;
@end

@implementation Comment
- (NSArray*) loadComments: (NSString *)commentURL {
    NSData *returnData;
    NSURLRequest *theRequest=[NSURLRequest
                              requestWithURL:[NSURL URLWithString: commentURL]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
//    NSString *jsonString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    
//    NSData * jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    self.allComments = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers
                                                            error:nil];
    return self.allComments;
}
@end
