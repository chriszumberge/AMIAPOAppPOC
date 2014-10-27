//
//  LoginViewController.m
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/24/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "LoginViewController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation LoginViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

- (IBAction)btnLogin_touch:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
    UIColor *compBackground = [UIColor colorWithComplementaryFlatColorOf:FlatSkyBlueDark];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:self.view.frame andColors:@[compBackground, FlatSkyBlueDark]];
    self.btnLogin.backgroundColor = FlatSkyBlue;
    self.btnLogin.titleLabel.backgroundColor =
     */
    
    NSMutableArray *colorArray = [[NSMutableArray alloc] initWithArray:[NSArray arrayOfColorsWithColorScheme:ColorSchemeAnalogous for:[UIColor flatSkyBlueColorDark] flatScheme:YES]];
    CGRect newFrame = CGRectMake(self.view.frame.origin.x,
                                  self.view.frame.origin.y,
                                  (self.view.frame.size.width * 2),
                                  (self.view.frame.size.height * 2));
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleRadial withFrame:newFrame andColors:@[colorArray[0], FlatSkyBlueDark, colorArray[3]]];
    self.btnLogin.backgroundColor = FlatSkyBlue;
    self.btnLogin.titleLabel.textColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:self.btnLogin.backgroundColor isFlat:YES];
}

@end
