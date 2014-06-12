//
//  NewList_VController.h
//  News
//
//  Created by Bishal on 12/06/2014.
//  Copyright (c) 2014 Bishal Bhansali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class News_WebView;
@interface NewList_VController : UIViewController<UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
    long long expectedLength;
	long long currentLength;
     NSMutableData *receivedData;
    NSMutableArray *Displaydata;
}
@property (strong, nonatomic) IBOutlet UITableView *Tbl_News;
@property (strong, nonatomic) News_WebView *News_webview;
- (IBAction)BtnRefresh:(id)sender;


@end
