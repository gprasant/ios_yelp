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

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil]forCellReuseIdentifier:@"BusinessCell"];
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

@end
