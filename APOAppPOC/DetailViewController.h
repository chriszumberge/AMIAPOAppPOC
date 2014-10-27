//
//  DetailViewController.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/16/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PNChart/PNChart.h>
#import "Dashboard.h"
#import "KPIData.h"
#import "KPI.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *graphTitle;
@property (weak, nonatomic) IBOutlet UIView *graphView;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Dashboard* dashboard;


@end

