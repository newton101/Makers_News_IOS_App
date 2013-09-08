//
//  MKADViewController.h
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MakersNewsURLKey;

@interface MKADViewController : UIViewController
{
//    int instance;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)getNews:(id)sender;
- (IBAction)showMessage:(id)sender;

@end