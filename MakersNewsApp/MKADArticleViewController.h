//
//  MKADArticleViewController.h
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKArticle.h"
#import <MessageUI/MessageUI.h>

@interface MKADArticleViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong) MKADArticle *article;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

- (IBAction)share:(id)sender;

@end
