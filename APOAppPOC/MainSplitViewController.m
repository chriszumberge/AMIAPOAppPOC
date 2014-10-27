//
//  MainSplitViewController.m
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/24/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "MainSplitViewController.h"
#import "LoginViewController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation MainSplitViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
    static bool login = YES;
    if (login)
    {
        //LoginViewController *lvc = [[LoginViewController alloc] init];
        //[self presentViewController:lvc animated:YES completion:nil];
        [self performSegueWithIdentifier:@"login" sender:self];
        login = NO;
    }
     */
}

@end
