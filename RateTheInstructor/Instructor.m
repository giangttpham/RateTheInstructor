//
//  Instructor.m
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import "Instructor.h"
@interface Instructor()
@property NSDictionary* instructorInfo;
@property NSDictionary* ratingInfo;
@end

@implementation Instructor
- (void) loadInstructorDetail: (NSString *)detailURL {
    NSData *returnData;
    NSURLRequest *theRequest=[NSURLRequest
                              requestWithURL:[NSURL URLWithString: detailURL]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    self.instructorInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
                                                            error:nil];
    self.ratingInfo = [self.instructorInfo objectForKey:@"rating"];
}

- (NSString*) fullName {
    return [NSString stringWithFormat:@"%@, %@", [self.instructorInfo objectForKey:@"firstName"],[self.instructorInfo objectForKey:@"lastName"]];
}
- (NSString*) instructorId {
    return  [NSString stringWithFormat:@"%@",[self.instructorInfo objectForKey:@"id"]];
}
- (NSString*) office {
    return [self.instructorInfo objectForKey:@"office"];
}
- (NSString*) phone
{
    return [self.instructorInfo objectForKey:@"phone"];
}
- (NSString*) email {
    return [self.instructorInfo objectForKey:@"email"];
}
- (NSString*) averageRating {
    return [NSString stringWithFormat:@"%@",[self.ratingInfo objectForKey:@"average"]];
}
- (NSString*) totalRatings {
    return [NSString stringWithFormat:@"%@",[self.ratingInfo objectForKey:@"totalRatings"]];

}

- (NSDictionary*) ratingData {
    return self.ratingInfo;
}
@end
