//
//  BusinessCell.m
//  Yelp
//
//  Created by Prasanth Guruprasad on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import "YelpBusiness.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingsImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@end

@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
    self.thumbImageView.layer.cornerRadius = 33;
    self.thumbImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBusiness:(YelpBusiness *)business {
    _business = business;
    
    [self.thumbImageView setImageWithURL: self.business.imageUrl];
    self.nameLabel.text = self.business.name;
    [self.ratingsImageView setImageWithURL: self.business.ratingImageUrl];
    self.distanceLabel.text = self.business.distance;
 
    self.ratingsLabel.text = [NSString stringWithFormat:@"%@ Reviews", [self.business.reviewCount stringValue]];
    self.addressLabel.text = self.business.address;
    self.categoriesLabel.text = self.business.categories;
}

- (void) layoutSubViews {
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

@end
