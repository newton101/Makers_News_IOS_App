//
//  MKADArticleViewController.m
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import "MKADArticleViewController.h"
#import <MessageUI/MessageUI.h>

@interface MKADArticleViewController ()

@end

@implementation MKADArticleViewController

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

    self.titleLabel.text = self.article.title;
    self.dateLabel.text = self.article.publishedDate;
    self.bodyTextView.text = self.article.body;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    [mailComposeViewController setSubject:self.article.title];
    [mailComposeViewController setMessageBody:self.article.body isHTML:NO];
    [mailComposeViewController setMailComposeDelegate:self];

    [self presentViewController:mailComposeViewController animated:YES completion:NULL];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:^{

        NSString *message = nil;

        switch (result) {
            case MFMailComposeResultCancelled:
                message = @"Cancelled";
                break;
            case MFMailComposeResultFailed:
                message = @"Failed";
                break;
            case MFMailComposeResultSaved:
                message = @"Saved";
                break;
            case MFMailComposeResultSent:
                message = @"Sent";
                break;
            default:
                break;
        }

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert show];
    }];
}

@end