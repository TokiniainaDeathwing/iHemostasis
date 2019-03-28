//
//  iHGridLayout.m
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 25/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

#import "iHGridLayout.h"

@implementation iHGridLayout

@synthesize numberOfColumns = numberOfColumns_, itemHeight = itemHeight_;

#pragma mark -
#pragma mark Override
- (CGSize)itemSize {
  CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - ((numberOfColumns_ + 1) * self.minimumInteritemSpacing)) / numberOfColumns_;
  return CGSizeMake(itemWidth, itemHeight_);
}

@end
