//
//  DetailCollectionViewController.m
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/20/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "DetailCollectionViewController.h"
#import "RBCollectionViewBalancedColumnLayout.h"
#import "KPI.h"
#import "KPIData.h"
#import <PNChart/PNChart.h>
#import "Helper.h"
#import "CircleCollectionViewCell.h"
#import <ChameleonFramework/Chameleon.h>

@interface DetailCollectionViewController ()

@property (nonatomic) CGFloat cellHeights;
@property (nonatomic) CGFloat graphHeights;
@property (nonatomic, strong) NSArray *dataKeys;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic) CGFloat size;

@end

@implementation DetailCollectionViewController
{
    CGFloat screenWidth;
    CGFloat screenHeight;
}
@synthesize dashboard;

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        
        dashboard = (Dashboard*)_detailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.cellHeights = 150.0f;
    self.graphHeights = 150.0f;
    
    RBCollectionViewBalancedColumnLayout *layout = (id)self.collectionView.collectionViewLayout;
    layout.interItemSpacingY = 40;
    layout.stickyHeader = YES;
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:RBCollectionViewBalancedColumnHeaderKind withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:RBCollectionViewBalancedColumnFooterKind withReuseIdentifier:@"footer"];
    
    self.dataKeys = @[@"Administrative", @"Management", @"Development"];
    
    NSMutableArray *graphs = [[NSMutableArray alloc] init];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    
    for (KPI *kpi in dashboard.dashboardData.kpiDataArray)
    {
        PNCircleChart *circleChart = [[PNCircleChart alloc]
                                      initWithFrame:CGRectMake(8, 0,
                                                               150 - 35,
                                                               150 - 35)
                                      andTotal:[NSNumber numberWithInt:100]
                                      andCurrent:[NSNumber numberWithInt:[[kpi.data firstObject] intValue]]
                                      andClockwise:YES
                                      andShadow:NO];
        circleChart.backgroundColor = [UIColor clearColor];
        [circleChart setStrokeColor:[Helper getColorFromValue:[[kpi.data firstObject] intValue]
                                            andGoodLowerBound:[kpi.goodLowerBound intValue]
                                         andWarningLowerBound:[kpi.warningLowerBound intValue]]];
        [circleChart setLineWidth:@12];
        [circleChart strokeChart];
        
        [graphs addObject:circleChart];
        [names addObject:kpi.name];
    }
    
    /*
    for (KPI *kpi in dashboard.dashboardData.kpiDataArray)
    {
        [graphs addObject:kpi.data.firstObject];
        [names addObject:kpi.name];
    }
     */
    self.data = @{ self.dataKeys[0] : @{@"names" : names, @"graphs" : graphs},
                   self.dataKeys[1] : @{@"names" : [Helper reverseMutableArrayToArray:names], @"graphs" : [Helper reverseMutableArrayToArray:graphs]},
                   self.dataKeys[2] : @{@"names" : names, @"graphs" : graphs}
                   };
    
    // Do any additional setup after loading the view.
    //[self configureView];
}

- (void)configureView {
    // Update the user interface for the detail item.
    //if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
    //}
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Helper configureNavBarProperties:self.navigationController.navigationBar];
    self.navigationController.navigationBar.tintColor = FlatWhite;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataKeys count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data[self.dataKeys[section]][@"names"] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reuseView;
    
    if (kind == RBCollectionViewBalancedColumnHeaderKind)
    {
        reuseView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        reuseView.backgroundColor = (indexPath.section == 1) ? FlatWhite : FlatSkyBlue;
        UILabel *label = (id)[reuseView viewWithTag:1];
        if (label == nil)
        {
            label = [[UILabel alloc] init];
            label.tag = 1;
            label.frame = CGRectMake(0, 0, reuseView.frame.size.width, reuseView.frame.size.height);
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            label.textAlignment = NSTextAlignmentCenter;
            [reuseView addSubview:label];
        }
        
        label.text = self.dataKeys[indexPath.section];
        label.textColor = (indexPath.section == 1) ? FlatSkyBlue : FlatWhite;
    }
    
    if (kind == RBCollectionViewBalancedColumnFooterKind)
    {
        reuseView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        reuseView.backgroundColor = [UIColor colorWithRed:0xdc/255.0 green:0xdc/255.0 blue:0xdc/255.0 alpha:1];
        
        UILabel *label = (id)[reuseView viewWithTag:1];
        if (label == nil)
        {
            label = [[UILabel alloc] init];
            label.tag = 1;
            label.frame = CGRectMake(0, 0, reuseView.frame.size.width, reuseView.frame.size.height);
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            label.textAlignment = NSTextAlignmentCenter;
            [reuseView addSubview:label];
        }
        
        label.text = [NSString stringWithFormat:@"Data at %@", [NSDate date]];
    }
    
    return reuseView;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //CircleCollectionViewCell *cell = (CircleCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //if (!cell)
    //{
    //    cell = [[CircleCollectionViewCell alloc] init];
    //}
    
    NSDictionary *sectionDictionary = self.data[self.dataKeys[indexPath.section]];
    NSString *name = sectionDictionary[@"names"][indexPath.row];
    //UIView *graph = sectionDictionary[@"graphs"][indexPath.row];
    PNCircleChart *graph = sectionDictionary[@"graphs"][indexPath.row];
    
    //NSNumber *amt = sectionDictionary[@"graphs"][indexPath.row];
    
    ///// NEW IMPLEMENTATION
    /*
    PNCircleChart *circleChart = [[PNCircleChart alloc]
                                      initWithFrame:CGRectMake(0, 0,
                                                               150,
                                                               150)
                                      andTotal:[NSNumber numberWithInt:100]
                                      andCurrent:[NSNumber numberWithInt:[amt intValue]]
                                      andClockwise:YES
                                      andShadow:NO];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:PNGreen];
    
    [cell addSubview:circleChart];
     */
    [cell addSubview:graph];
    //UIView *container = (id)[cell viewWithTag:101];
    //container.backgroundColor = [UIColor yellowColor];
    //[container addSubview:circleChart];
    //cell.container = circleChart;
    
    //UILabel *label = (id)[cell viewWithTag:201];
    //label.text = name;
    //cell.label.text = name;
    //[circleChart strokeChart];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 160 - 42, 150, 42)];
    label.text = name;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    
    cell.layer.masksToBounds = NO;
    /*
    cell.layer.shadowOpacity = 0.4f;
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOffset = CGSizeMake(0, 1);
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    */
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - RBCollectionViewBalancedColumnLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RBCollectionViewBalancedColumnLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RBCollectionViewBalancedColumnLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RBCollectionViewBalancedColumnLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section
{
    //return 25.0f;
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RBCollectionViewBalancedColumnLayout *)collectionViewLayout widthForCellsInSection:(NSInteger)section
{
    return 150.0f;
}



@end
