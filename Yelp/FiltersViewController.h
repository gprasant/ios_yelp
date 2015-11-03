//
//  FiltersViewController.h
//  Yelp
//
//  Created by Prasanth Guruprasad on 11/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>
-(void)filtersViewController: (FiltersViewController *)fvc
            didChangeFilters: (NSDictionary *) filters;
@end

@interface FiltersViewController : UIViewController

@property (nonatomic, weak) id <FiltersViewControllerDelegate> delegate;

@end

