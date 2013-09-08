//
//  MKArticle.h
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKArticle : NSObject

@property (strong) NSNumber *numericID;
@property (strong) NSString *title;
@property (strong) NSString *body;
@property (strong) NSString *publishedDate;
@property (strong) NSString *urlPath;

@end
