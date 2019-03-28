//
//  iHClinicalCaseCell.m
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 25/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

#import "iHClinicalCaseCell.h"

@implementation iHClinicalCaseCell

@synthesize descriptionTextView = descriptionTextView_, titleLabel = titleLabel_;

#pragma mark -
#pragma mark  Override
- (void)prepareForReuse {
  [super prepareForReuse];
  
  descriptionTextView_.text = @"";
  titleLabel_.text = @"";
}

@end
