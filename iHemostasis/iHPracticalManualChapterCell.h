//
//  iHPracticalManualChapterCell.h
//  iHemostasis
//
//  Created by zoraj on 15/09/2016.
//  Copyright © 2016 com.stago. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iHPracticalManualChapterCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UITextView *authorTextView;
@property (nonatomic, retain) IBOutlet UITextView *entityTextView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIView *titleView;

@end
