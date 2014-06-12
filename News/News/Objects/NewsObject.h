//
//  NewsObject.h
//  News
//
//  Created by Bishal on 13/06/2014.
//  Copyright (c) 2014 Bishal Bhansali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsObject : NSObject{
    NSString *_headLine;
    NSString *_slugLine;
    NSString *_tinyUrl;
    NSString *_dateLine;
    NSString *_thumbimgURl;
}
@property (nonatomic, copy) NSString *headLine;
@property (nonatomic, copy) NSString *slugLine;
@property (nonatomic, copy)NSString *tinyUrl;
@property (nonatomic, copy) NSString *dateLine;
@property (nonatomic, copy) NSString *thumbimgURl;

- (id)initWithUniqueId:(NSString *)headLine slugLine:(NSString *)slugLine tinyUrl:(NSString *)tinyUrl dateLine:(NSString *)dateLine thumbimgURl:(NSString *)thumbimgURl;

@end
