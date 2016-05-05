//
//  CBSSegmentViewController.h
//  cbsSegmentView
//
//  Created by 陈秉慎 on 5/5/16.
//  Copyright © 2016 cbs. All rights reserved.
//  GitHub:https://github.com/cbsfly/CBSSegmentView
//  please STAR it if you think it is helpful!
//  blog:http://cbsfly.github.io/ios/segmentview
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CBSSegmentHeaderType) {
    CBSSegmentHeaderTypeScroll,//标签栏可滚动
    CBSSegmentHeaderTypeFixed//标签栏固定
};

@interface CBSSegmentViewController : UIViewController
//required
//必填，标签栏标题字符串数组
@property (nonatomic, strong) NSArray *cbs_titleArray;

//必填，每个标签对应ViewController字符串数组，数量应与cbs_titleArray一样
@property (nonatomic, strong) NSArray *cbs_viewArray;

//初始化方法，设置完cbs_titleArray和cbs_viewArray后调用
- (void)initSegment;

//optional
//标签栏颜色，默认白色
@property (nonatomic, strong) UIColor *cbs_headerColor;

//非选中状态下标签字体颜色，默认黑色
@property (nonatomic, strong) UIColor *cbs_titleColor;

//选中标签字体颜色，默认蓝色
@property (nonatomic, strong) UIColor *cbs_titleSelectedColor;

//选中标签底部划线颜色，默认蓝色
@property (nonatomic, strong) UIColor *cbs_bottomLineColor;

//segmentView背景色，默认透明
@property (nonatomic, strong) UIColor *cbs_backgroundColor;

//标签栏高度
@property (nonatomic, assign) CGFloat cbs_buttonHeight;

//标签栏每个按钮宽度
@property (nonatomic, assign) CGFloat cbs_buttonWidth;

//选中视图下划线高度，置零可取消下划线
@property (nonatomic, assign) CGFloat cbs_lineHeight;

//标签栏类型，默认为滚动标签栏
@property (nonatomic, assign) CBSSegmentHeaderType cbs_Type;

//点击标签栏按钮调用方法，可选
- (void)didSelectSegmentIndex:(NSInteger)index;
@end
