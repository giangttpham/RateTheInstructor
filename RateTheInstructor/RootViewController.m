//
//  RootViewController.m
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"


@interface RootViewController () //<NSURLConnectionDelegate>
@property (copy, nonatomic) NSArray * allInstructors;
@property NSMutableData *returnData;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bismarck.sdsu.edu/rateme/list"]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    
//    NSURLRequest *theRequest=[NSURLRequest
//                              requestWithURL:[NSURL URLWithString: @"http://bismarck.sdsu.edu/rateme/list"]
//                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//
//    self.returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
//    
//    
//    NSString *jsonString = [[NSString alloc] initWithData:self.returnData encoding:NSUTF8StringEncoding];
//    
//    NSData * jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
//    self.allInstructors = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
//                                                           error:nil];
//    UITableView *tableView = (id)[self.view viewWithTag:1];
    //    [tableView registerClass:[NameAndColorCell class]
    //      forCellReuseIdentifier:CellTableIdentifier];
//    
//    UIEdgeInsets contentInset = tableView.contentInset;
//    contentInset.top = 20;
//    [tableView setContentInset:contentInset];
}


#pragma mark NSURLConnection Delegate Methods

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
    self.allInstructors = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.allInstructors count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return @"All Instructors";
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Instructor";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary * currProf = [self.allInstructors objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[currProf objectForKey:@"firstName"],[currProf objectForKey:@"lastName"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"id: %@",[currProf objectForKey:@"id"]];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.navigationItem.title = @"Instructor Info";
    NSDictionary * currProf = [self.allInstructors objectAtIndex:indexPath.row];
    
    detailVC.labelText = [NSString stringWithFormat:@"%@ %@",[currProf objectForKey:@"firstName"],[currProf objectForKey:@"lastName"]];
    
}


@end

