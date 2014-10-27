//
//  MasterViewController.m
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/16/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DetailCollectionViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Dashboard.h"
#import "KPIData.h"
#import "KPI.h"
#import "Helper.h"
#import <ChameleonFramework/Chameleon.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface MasterViewController ()

@property NSArray *dashboards;

@end

@implementation MasterViewController
{
    bool loggedIn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    loggedIn = NO;
    
    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
     */
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (loggedIn)
    {
        [self getData];
    }
    self.navigationController.navigationBar.tintColor = FlatWhite;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!loggedIn)
    {
        //LoginViewController *lvc = [[LoginViewController alloc] init];
        //[self presentViewController:lvc animated:YES completion:nil];
        [self performSegueWithIdentifier:@"login" sender:self];
        loggedIn = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    //UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    //aiv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //[self.view addSubview:aiv];
    //[aiv startAnimating];
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Retrieving Data";
    
    
    // Create request
    NSString *string = @"http://apopocsample.azurewebsites.net/SampleData.json";
    //NSString *string = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@", responseObject);
         self.responseDictionary = (NSDictionary*)responseObject;
         [self decomposeResponseObjectData];
         [self.tableView reloadData];
         [hud hide:YES];
         //[MBProgressHUD hideHUDForView:self.view animated:YES];
         //[aiv stopAnimating];
         //[aiv removeFromSuperview];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         //[MBProgressHUD hideHUDForView:self.view animated:YES];
         [hud hide:YES];
         [alertView show];
     }];
    
    // Do it
    [operation start];

}

- (void)decomposeResponseObjectData {
    
    self.responseArray = self.responseDictionary[@"data"];
    NSMutableArray *allDashboardData = [[NSMutableArray alloc] init];
    for (NSDictionary *d in self.responseArray)
    {
        NSMutableArray *kpis = [[NSMutableArray alloc] init];
        
        Dashboard *dashboard = [[Dashboard alloc] init];
        dashboard.dashboardName = d[@"dashboardname"];
        dashboard.graphType = d[@"graphtype"];
        NSDictionary *kpiDataDict = (NSDictionary*)d[@"dashboarddata"];
        
        KPIData *kpiData = [[KPIData alloc] init];
        kpiData.dates = (NSArray*)kpiDataDict[@"dates"];
        
        NSArray *tempKPIData = (NSArray*)kpiDataDict[@"kpidata"];
            
        for (NSDictionary *kpiDict in tempKPIData)
        {
            KPI *kpi = [[KPI alloc] init];
            kpi.name = kpiDict[@"name"];
            kpi.data = (NSArray*)kpiDict[@"data"];
            kpi.goodLowerBound = kpiDict[@"goodlowerbound"];
            kpi.warningLowerBound = kpiDict[@"warninglowerbound"];
            [kpis addObject:kpi];
        }
        
        kpiData.kpiDataArray = [[NSArray alloc] initWithArray:kpis];
        
        dashboard.dashboardData = kpiData;
        [allDashboardData addObject:dashboard];
    }
    
    self.dashboards = [[NSArray alloc] initWithArray:allDashboardData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Dashboard *dashboard = self.dashboards[indexPath.row];
        DetailViewController *dvc = (DetailViewController*)[[segue destinationViewController] topViewController];
        dvc.detailItem = dashboard;
        
        dvc.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        dvc.navigationItem.leftItemsSupplementBackButton = YES;
    }
    else if ([[segue identifier] isEqualToString:@"showDetailCollection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Dashboard *dashboard = self.dashboards[indexPath.row];
        DetailCollectionViewController *dcvc = (DetailCollectionViewController*)[[segue destinationViewController] topViewController];
        dcvc.detailItem = dashboard;
        
        dcvc.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        dcvc.navigationItem.leftItemsSupplementBackButton = YES;

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dashboards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Dashboard *dash = self.dashboards[indexPath.row];
    cell.textLabel.text = dash.dashboardName;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Dashboard *destDash = self.dashboards[indexPath.row];
    if ([destDash.graphType isEqualToString: @"circle"])
    {
        [self performSegueWithIdentifier:@"showDetailCollection" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
    
    //[self performSegueWithIdentifier:@"test" sender:self];
}


@end
