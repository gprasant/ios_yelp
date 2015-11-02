//
//  BusinessCell.h
//  Yelp
//
//  Created by Prasanth Guruprasad on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@interface BusinessCell : UITableViewCell

    @property (strong, nonatomic) YelpBusiness *business;

@end
