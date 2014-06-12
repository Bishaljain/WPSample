//
//  NewList_VController.m
//  News
//
//  Created by Bishal on 12/06/2014.
//  Copyright (c) 2014 Bishal Bhansali. All rights reserved.
//
#import "NewList_VController.h"
#import "News_WebView.h"
#import "NewsObject.h"
#import "UIImageView+WebCache.h"

@interface NewList_VController ()

@end

@implementation NewList_VController
#pragma mark - View Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Displaydata = [[NSMutableArray alloc] init];
    [self BtnRefresh:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma Mark - Table Life Cycle


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return Displaydata.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NewsObject *info = [Displaydata objectAtIndex:indexPath.row];
    if ([info.thumbimgURl length]>0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_News" forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_News_NoImg" forIndexPath:indexPath];
    }
    
   
    UILabel *Headline = (UILabel *)[cell viewWithTag:101];
    UILabel *SlugLine = (UILabel *)[cell viewWithTag:102];
    Headline.text = info.headLine;
    SlugLine.text = info.slugLine;

    if ([info.thumbimgURl length]>0) {
         UIImageView *logoimg = (UIImageView *)[cell viewWithTag:100];
        [logoimg setImageWithURL:[NSURL URLWithString:info.thumbimgURl]
                placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
    }
   
    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"] || [[segue identifier] isEqualToString:@"showDetailnoImg"] ) {
        NSIndexPath *indexPath = [self.Tbl_News indexPathForSelectedRow];
        NewsObject *info = [Displaydata objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:info];
    }
}


#pragma Mark - Load Data


- (IBAction)BtnRefresh:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"http://mobilatr.mob.f2.com.au/services/views/9.json"];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
	
	HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	HUD.delegate = self;
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	expectedLength = MAX([response expectedContentLength], 1);
	currentLength = 0;
    receivedData=[[NSMutableData alloc] init];
	HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	currentLength += [data length];
    [receivedData appendData:data];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self fetchedData:receivedData];
    receivedData = nil;
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    receivedData = nil;
	[HUD hide:YES];
}
#pragma Mark - Parse Data 
- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* NewsListDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                              options:kNilOptions
                                                                error:&error];
    NSMutableArray *ArrangeNewsList;
    ArrangeNewsList = [NewsListDict objectForKey:@"items"];
    if (ArrangeNewsList.count > 0) {
        [Displaydata removeAllObjects];
    }
    for (int i=0; i<ArrangeNewsList.count; i++) {
        NSDictionary* FetchArray = [ArrangeNewsList objectAtIndex:i];
        NSString *ThumbUrl ;
        if ([FetchArray objectForKey:@"thumbnailImageHref"] &&
            [FetchArray objectForKey:@"thumbnailImageHref"] != [NSNull null]) {
            ThumbUrl =[FetchArray objectForKey:@"thumbnailImageHref"];
        }else{
           ThumbUrl =@"";
        }
        NewsObject *AddObjectsToDisplay = [[NewsObject alloc]initWithUniqueId:[FetchArray objectForKey:@"headLine"] slugLine:[FetchArray objectForKey:@"slugLine"] tinyUrl:[FetchArray objectForKey:@"tinyUrl"] dateLine:[FetchArray objectForKey:@"dateLine"] thumbimgURl:ThumbUrl];
        
        [Displaydata addObject:AddObjectsToDisplay];
    }
    NSSortDescriptor *SortNewsByDate = [[NSSortDescriptor alloc] initWithKey:@"dateLine" ascending:NO];
    NSArray *sortDescriptors = @[SortNewsByDate];
    NSArray *FinalNewList = [Displaydata sortedArrayUsingDescriptors:sortDescriptors];
    Displaydata=[FinalNewList mutableCopy];
    [self.Tbl_News reloadData];
    SortNewsByDate = nil;
    
}
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}




@end
