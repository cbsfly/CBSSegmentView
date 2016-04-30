//
//  CbsSegmentView.m
//  cbsSegmentView
//
//  Created by 陈秉慎 on 4/16/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import "CbsSegmentView.h"
@interface CbsSegmentView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *segmentBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *backView;
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIScrollView *headerSelectedView;
@property (nonatomic, strong) UIView *headerSelectedSuperView;
@property (nonatomic, strong) NSArray *viewControllerArray;
@property (nonatomic, strong) NSMutableArray *isFinishedArray;


@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, assign) CGFloat lineHeight;
@end

@implementation CbsSegmentView
- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray view:(NSArray *)viewArray type:(CbsSegmentHeaderType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        switch (type) {
            case CbsSegmentHeaderTypeFixed: {
                self.buttonWidth = self.width/titleArray.count;
                [self addBackViewWithCount:titleArray.count];
                [self addFixedHeader:titleArray];
                self.viewControllerArray = viewArray;
                for (NSInteger i = 0; i < viewArray.count; i++) {
                    [self.isFinishedArray addObject:@0];
                }
                [self initViewController:0];
                break;
            }
            case CbsSegmentHeaderTypeScroll: {
                [self addBackViewWithCount:titleArray.count];
                [self addScrollHeader:titleArray];
                self.viewControllerArray = viewArray;
                for (NSInteger i = 0; i < viewArray.count; i++) {
                    [self.isFinishedArray addObject:@0];
                }
                [self initViewController:0];
                
                break;
            }
                
            default:
                break;
        }
    }
    return self;
}


#pragma mark - private
- (void)initViewController:(NSInteger)index
{
    if ([self.isFinishedArray[index] integerValue] == 0) {
        Class className = NSClassFromString(self.viewControllerArray[index]);
        UIViewController * viewController = [[className alloc] init];
        [viewController.view setFrame:CGRectMake(self.width*index, 0, self.width, self.height - self.buttonHeight)];
        [self.backView addSubview:viewController.view];
        self.isFinishedArray[index] = @1;
    }
}

- (void)addBackViewWithCount:(NSInteger)count
{
    self.backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.buttonHeight, self.width, self.height - self.buttonHeight)];
    self.backView.contentSize = CGSizeMake(self.width*count, self.height - self.buttonHeight);
    self.backView.backgroundColor = [UIColor clearColor];
    [self.backView setPagingEnabled:YES];
    [self.backView setShowsVerticalScrollIndicator:NO];
    [self.backView setShowsHorizontalScrollIndicator:NO];
    self.backView.bounces = NO;

    self.backView.delegate = self;
    self.backView.tag = 2;
    [self addSubview:self.backView];
}

- (void)addScrollHeader:(NSArray *)titleArray
{
    self.headerView.frame = CGRectMake(0, 0, self.width, self.buttonHeight);
    self.headerView.contentSize = CGSizeMake(self.buttonWidth*titleArray.count, self.buttonHeight);
    [self addSubview:self.headerView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.buttonWidth*index, 0, self.buttonWidth, self.buttonHeight)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerView addSubview:_titleLabel];
        
        _segmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonWidth*index, 0, self.buttonWidth, self.buttonHeight)];
        _segmentBtn.tag = index;
        [_segmentBtn setBackgroundColor:[UIColor clearColor]];
        [_segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:_segmentBtn];
    }
    
    
    self.headerSelectedSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.buttonWidth, self.buttonHeight)];
    [self.headerView addSubview:self.headerSelectedSuperView];
    
    self.headerSelectedView.frame =CGRectMake(0, 0, self.buttonWidth, self.buttonHeight);
    self.headerSelectedView.contentSize = CGSizeMake(self.buttonWidth*titleArray.count, self.buttonHeight);
    [self.headerSelectedSuperView addSubview:self.headerSelectedView];

    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.buttonWidth*index, 0, self.buttonWidth, self.buttonHeight)];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerSelectedView addSubview:_titleLabel];
        
    }

    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.headerSelectedView.contentSize.height - self.lineHeight, self.headerSelectedView.contentSize.width, self.lineHeight)];
    bottomLine.backgroundColor = [UIColor blueColor];
    [self.headerSelectedView addSubview:bottomLine];
}

- (void)addFixedHeader:(NSArray *)titleArray
{
    self.headerView.frame = CGRectMake(0, 0, self.width, self.buttonHeight);
    self.headerView.contentSize = CGSizeMake(self.width, self.buttonHeight);
    [self addSubview:self.headerView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.buttonWidth*index, 0, self.buttonWidth, self.buttonHeight)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerView addSubview:_titleLabel];
        
        _segmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonWidth*index, 0, self.buttonWidth, self.buttonHeight)];
        _segmentBtn.tag = index;
        [_segmentBtn setBackgroundColor:[UIColor clearColor]];
        [_segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:_segmentBtn];
    }
    
    self.headerSelectedSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.buttonWidth, self.buttonHeight)];
    [self.headerView addSubview:self.headerSelectedSuperView];
    
    self.headerSelectedView.frame =CGRectMake(0, 0, self.buttonWidth, self.buttonHeight);
    self.headerSelectedView.contentSize = CGSizeMake(self.width, self.buttonHeight);
    [self.headerSelectedSuperView addSubview:self.headerSelectedView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.buttonWidth*index, 0, self.buttonWidth, self.buttonHeight)];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerSelectedView addSubview:_titleLabel];
        
    }
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.headerSelectedView.contentSize.height - self.lineHeight, self.headerSelectedView.contentSize.width, self.lineHeight)];
    bottomLine.backgroundColor = [UIColor blueColor];
    [self.headerSelectedView addSubview:bottomLine];

}

- (void)btnClick:(UIButton *)button
{
    [self.backView scrollRectToVisible:CGRectMake(button.tag*self.width, 0, self.backView.frame.size.width, self.backView.frame.size.height) animated:YES];
    [self.delegate didSelectSegmentIndex:button.tag];
}

- (void)correctHeader:(UIScrollView *)scrollView
{
    if (scrollView == _backView) {
        CGFloat location = _headerSelectedView.contentOffset.x + self.buttonWidth/2 - self.width/2;
        
        if (location <= 0) {
            [UIView animateWithDuration:.3 animations:^{
                _headerView.contentOffset = CGPointMake(0, _headerSelectedView.contentOffset.y);
            }];
        }else if (location >= _headerView.contentSize.width - self.width) {
            [UIView animateWithDuration:.3 animations:^{
                _headerView.contentOffset = CGPointMake(_headerView.contentSize.width - self.width, _headerSelectedView.contentOffset.y);
            }];
        }else {
            if (_headerView.contentOffset.x != location) {
                [UIView animateWithDuration:.3 animations:^{
                    _headerView.contentOffset = CGPointMake(location, _headerSelectedView.contentOffset.y);
                }];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _backView) {
        self.headerSelectedSuperView.frame = CGRectMake(scrollView.contentOffset.x * (self.buttonWidth/self.width), self.headerSelectedSuperView.frame.origin.y, self.headerSelectedSuperView.frame.size.width, self.headerSelectedSuperView.frame.size.height);
        self.headerSelectedView.contentOffset = CGPointMake(scrollView.contentOffset.x * (self.buttonWidth/self.width), 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _backView) {
        [self correctHeader:scrollView];
        [self initViewController:(scrollView.contentOffset.x/self.width)];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == _backView) {
        [self correctHeader:scrollView];
        [self initViewController:(scrollView.contentOffset.x/self.width)];
    }
}


#pragma mark - getter
- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (UIScrollView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIScrollView alloc] init];
        [_headerView setShowsVerticalScrollIndicator:NO];
        [_headerView setShowsHorizontalScrollIndicator:NO];
        _headerView.delegate = self;
        _headerView.bounces = NO;
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UIScrollView *)headerSelectedView
{
    if (_headerSelectedView == nil) {
        _headerSelectedView = [[UIScrollView alloc] init];
        [_headerSelectedView setShowsVerticalScrollIndicator:NO];
        [_headerSelectedView setShowsHorizontalScrollIndicator:NO];
        _headerSelectedView.userInteractionEnabled = NO;
        _headerSelectedView.delegate = self;
        _headerSelectedView.backgroundColor = [UIColor whiteColor];
        _headerSelectedView.clipsToBounds = YES;
    }
    return _headerSelectedView;
}

- (CGFloat)buttonHeight
{
    if (_buttonHeight == 0) {
        _buttonHeight = 40;
    }
    return _buttonHeight;
}

- (CGFloat)buttonWidth
{
    if (_buttonWidth == 0) {
        _buttonWidth = self.width/3;
    }
    return _buttonWidth;
}

- (CGFloat)lineHeight
{
    if (_lineHeight == 0) {
        _lineHeight = 1;
    }
    return _lineHeight;
}
#pragma mark - API
- (void)setTitleColor:(UIColor *)titleColor
{
    NSArray *subView = self.headerView.subviews;
    for (UILabel *label in subView) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.textColor = titleColor;
        }
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    NSArray *subView = self.headerSelectedView.subviews;
    for (UILabel *label in subView) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.textColor = titleSelectedColor;
        }
    }
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor
{
    NSArray *subView = self.headerSelectedView.subviews;
    for (UIImageView *imgView in subView) {
        if ([imgView isKindOfClass:[UIImageView class]]) {
            imgView.backgroundColor = bottomLineColor;
        }
    }
}

- (void)setHeaderColor:(UIColor *)headerColor
{
    self.headerSelectedView.backgroundColor = headerColor;
    self.headerView.backgroundColor = headerColor;
}
@end
