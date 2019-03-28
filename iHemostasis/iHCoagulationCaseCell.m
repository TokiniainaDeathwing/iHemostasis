//
//  iHCoagulationCaseCell.m
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 25/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

#import "iHCoagulationCaseCell.h"

@implementation iHCoagulationCaseCell

@synthesize imageView = imageView_, titleLabel = titleLabel_;

#pragma mark -
#pragma mark  Override
- (void)prepareForReuse {
  [super prepareForReuse];
  
  imageView_.image = nil;
  titleLabel_.text = @"";
}

@end
