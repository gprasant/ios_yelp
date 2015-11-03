//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpBusiness.h"
#import "Businesscell.h"
#import "FiltersViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate>

@property (nonatomic, strong) NSArray *businesses;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YelpBusiness searchWithTerm:@"Restaurants"
                        sortMode:YelpSortModeBestMatched
                      categories:@[@"burgers"]
                           deals:NO
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          [self.tableView reloadData];
                          for (YelpBusiness *business in businesses) {
                              NSLog(@"%@", business);
                          }
                      }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onFiltersTapped)];
    self.title = @"Yelp";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil]forCellReuseIdentifier:@"BusinessCell"];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Row Count : %lu", self.businesses.count);
    return self.businesses.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];

    cell.business = self.businesses[indexPath.row];
    
    return cell;
}

#pragma mark - filter delegate Methods

-(void) filtersViewController:(FiltersViewController *)fvc didChangeFilters:(NSDictionary *)filters {
    NSString *categoryFilterString = filters[@"category_filter"];
    NSArray *categoryFilterArray = [categoryFilterString componentsSeparatedByString:@","];
    
    [YelpBusiness searchWithTerm:@"Restaurants"
                        sortMode: YelpSortModeBestMatched
                      categories: categoryFilterArray
                           deals:NO
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          [self.tableView reloadData];
                          for (YelpBusiness *business in businesses) {
                              NSLog(@"%@", business);
                          }
                      }];
    NSLog(@"Fire network event %@", filters);
}

#pragma mark - Private methods

-(void) onFiltersTapped {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc
                       animated:YES
                     completion:nil];
}

@end
