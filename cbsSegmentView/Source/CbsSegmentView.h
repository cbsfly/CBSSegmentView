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
//点击标签栏按钮代理方法
- (void)didSelectSegmentIndex:(NSInteger)index;

@end

@interface CbsSegmentView : UIView
@property (nonatomic, weak) id<CbsSegmentViewDelegate> delegate;
//标签栏颜色
@property (nonatomic, strong) UIColor *headerColor;
//非选中状态下标签字体颜色
@property (nonatomic, strong) UIColor *titleColor;
//选中标签字体颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
//选中标签底部划线颜色
@property (nonatomic, strong) UIColor *bottomLineColor;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray view:(NSArray *)viewArray type:(CbsSegmentHeaderType)type;

@end
