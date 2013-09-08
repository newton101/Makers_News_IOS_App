//
//  MKArticle.m
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import "MKArticle.h"

@implementation MKArticle

- (void)dealloc
{
    self.numericID = nil;
    self.title = nil;
    self.body = nil;
    self.publishedDate = nil;
    self.urlPath = nil;
}

@end
