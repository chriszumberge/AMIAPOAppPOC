//
//  LoginViewController.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/24/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)btnLogin_touch:(id)sender;

@end
