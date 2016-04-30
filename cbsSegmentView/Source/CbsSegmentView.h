//
//  CbsSegmentView.h
//  cbsSegmentView
//
//  Created by 陈秉慎 on 4/16/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CbsSegmentHeaderType) {
    CbsSegmentHeaderTypeFixed,
    CbsSegmentHeaderTypeScroll
};
@protocol CbsSegmentViewDelegate <NSObject>

- (void)didSelectSegmentIndex:(NSInteger)index;

@end

@interface CbsSegmentView : UIView
@property (nonatomic, strong) UIColor *headerColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *bottomLineColor;

@property (nonatomic, weak) id<CbsSegmentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray view:(NSArray *)viewArray type:(CbsSegmentHeaderType)type;

@end
