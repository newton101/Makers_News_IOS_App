//
//  MKADViewController.m
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import "MKADViewController.h"
#import "MKADArticlesTableViewController.h"

NSString * const MakersNewsURLKey = @"MakersNewsURLKey";

@interface MKADViewController ()

@end

@implementation MKADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:MakersNewsURLKey];
    if ([url length]){
        self.textField.text = url; //http://makers-news-app.herokuapp.com/articles.json
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMessage:(NSString *)myMsg{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                      message:myMsg
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (IBAction)getNews:(id)sender {

    if([self.textField.text length]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:MakersNewsURLKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

        MKADArticlesTableViewController *articlesTableViewController = [[MKADArticlesTableViewController alloc] initWithStyle:UITableViewStylePlain];

        articlesTableViewController.articlesURLString = self.textField.text;

        [self.navigationController pushViewController:articlesTableViewController animated:YES];
    } else {
        [self showMessage:@"You wants infinite news! No? Try entering something to look up news for"];
    }
}
@end
