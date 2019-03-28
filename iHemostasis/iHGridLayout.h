//
//  iHGridLayout.h
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 25/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iHGridLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat itemHeight;

@end
