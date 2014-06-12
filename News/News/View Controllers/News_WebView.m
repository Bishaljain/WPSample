//
//  News_WebView.m
//  News
//
//  Created by Bishal on 12/06/2014.
//  Copyright (c) 2014 Bishal Bhansali. All rights reserved.
//

#import "News_WebView.h"
#import "NewsObject.h"

@interface News_WebView ()
@end

@implementation News_WebView

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
    // Do any additional setup after loading the view.
    webView.delegate=self;
    [webView addSubview: activityIndicator ];
    NewsObject *info = self.detailItem;
    [activityIndicator startAnimating];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:info.tinyUrl]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Configure Web
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

#pragma mark webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
	[activityIndicator stopAnimating];
}
-(void)webViewDidStartLoad:(UIWebView *)theWebView{
    [activityIndicator startAnimating];
}

- (void)webView:(UIWebView *)theWebView didFailLoadWithError:(NSError *)error {
	[activityIndicator stopAnimating];
}
@end
