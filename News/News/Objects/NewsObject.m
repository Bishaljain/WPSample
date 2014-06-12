//
//  NewsObject.m
//  News
//
//  Created by Bishal on 13/06/2014.
//  Copyright (c) 2014 Bishal Bhansali. All rights reserved.
//

#import "NewsObject.h"

@implementation NewsObject

@synthesize headLine = _headLine;
@synthesize slugLine =_slugLine;
@synthesize tinyUrl =_tinyUrl;
@synthesize dateLine =_dateLine;
@synthesize thumbimgURl =_thumbimgURl;

- (id)initWithUniqueId:(NSString *)headLine slugLine:(NSString *)slugLine tinyUrl:(NSString *)tinyUrl dateLine:(NSString *)dateLine thumbimgURl:(NSString *)thumbimgURl{
    if ((self = [super init])) {
        self.headLine = headLine;
        self.slugLine =slugLine;
        self.tinyUrl= tinyUrl;
        self.dateLine =dateLine;
        self.thumbimgURl =thumbimgURl;
    }
    return self;
}
@end