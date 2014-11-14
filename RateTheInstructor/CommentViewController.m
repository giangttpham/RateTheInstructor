//
//  CommentViewController.m
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import "CommentViewController.h"
@interface CommentViewController()
@property NSMutableData* returnData;
@end;

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.commentURL]];
//    
//    // Create url connection and fire request
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.returnData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.returnData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString *jsonString = [[NSString alloc] initWithData:self.returnData encoding:NSUTF8StringEncoding];
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    self.allComments = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
                                                            error:nil];
    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Comment";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    NSDictionary *currentComment = [self.allComments objectAtIndex:[indexPath row]];
    cell.textLabel.text = [currentComment objectForKey:@"text"];
    cell.detailTextLabel.text = [currentComment objectForKey:@"date"];
    
    return cell;
                                
}
@end
