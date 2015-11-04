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

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) NSMutableArray *filteredBusinesses;

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
                          self.filteredBusinesses = [NSMutableArray arrayWithArray:self.businesses];
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
    
#pragma - Search 
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchBar sizeToFit];
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = self;
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText {
    NSLog(@"Searching with term: %@", searchText);
    [self filterContentForSearchText:searchText scope:nil];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    [theSearchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // handle empty search
    if([searchText length] == 0) {
        self.filteredBusinesses = [NSMutableArray arrayWithArray:self.businesses];
        return;
    }
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredBusinesses removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredBusinesses = [NSMutableArray arrayWithArray:[self.businesses filteredArrayUsingPredicate:predicate]];
    NSLog(@"filtered result row count : %li", self.filteredBusinesses.count);
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.businesses.count;
    NSLog(@"fiteredBusinesses.count : %li", self.filteredBusinesses.count);
    return self.filteredBusinesses.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];

    cell.business = self.filteredBusinesses[indexPath.row];
    
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
                          self.filteredBusinesses = [NSMutableArray arrayWithArray:self.businesses];
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
