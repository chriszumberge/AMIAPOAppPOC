//
//  TodayViewController.h
//  APOWidget
//
//  Created by Christopher Zumberge on 10/21/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PNChart/PNChart.h>

@interface TodayViewController : UIViewController
- (IBAction)btnAction:(id)sender;
@property (weak, nonatomic) IBOutlet PNLineChart *graphView;

@end
