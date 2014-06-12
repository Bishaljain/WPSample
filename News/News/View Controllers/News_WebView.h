//
//  News_WebView.h
//  News
//
//  Created by Bishal on 12/06/2014.
//  Copyright (c) 2014 Bishal Bhansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News_WebView : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *webView;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}
@property (strong, nonatomic) id detailItem;
@end
