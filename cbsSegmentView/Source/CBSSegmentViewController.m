//
//  CBSSegmentViewController.m
//  cbsSegmentView
//
//  Created by 陈秉慎 on 5/5/16.
//  Copyright © 2016 cbs. All rights reserved.
//  GitHub:https://github.com/cbsfly/CBSSegmentView
//  please STAR it if you think it is helpful!
//  blog:http://cbsfly.github.io/ios/segmentview
//

#import "CBSSegmentViewController.h"

@interface CBSSegmentViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *segmentBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *backView;
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIScrollView *headerSelectedView;
@property (nonatomic, strong) UIView *headerSelectedSuperView;
@property (nonatomic, strong) NSMutableArray *isFinishedArray;


@end

@implementation CBSSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)initSegment
{
    switch (self.cbs_Type) {
        case 1: {
            self.cbs_buttonWidth = self.width/self.cbs_titleArray.count;
            [self addBackViewWithCount:self.cbs_titleArray.count];
            [self addFixedHeader:self.cbs_titleArray];
            for (NSInteger i = 0; i < self.cbs_viewArray.count; i++) {
                [self.isFinishedArray addObject:@0];
            }
            [self initViewController:0];
            break;
        }
        case 0: {
            [self addBackViewWithCount:self.cbs_titleArray.count];
            [self addScrollHeader:self.cbs_titleArray];
            for (NSInteger i = 0; i < self.cbs_viewArray.count; i++) {
                [self.isFinishedArray addObject:@0];
            }
            [self initViewController:0];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - private
- (void)initViewController:(NSInteger)index
{
    if ([self.isFinishedArray[index] integerValue] == 0) {
        Class className = NSClassFromString(self.cbs_viewArray[index]);
        UIViewController * viewController = [[className alloc] init];
        [viewController.view setFrame:CGRectMake(self.width*index, 0, self.width, self.height - self.cbs_buttonHeight)];
        [self addChildViewController:viewController];
        [self.backView addSubview:viewController.view];
        self.isFinishedArray[index] = @1;
    }
}

- (void)addBackViewWithCount:(NSInteger)count
{
    self.backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.cbs_buttonHeight, self.width, self.height - self.cbs_buttonHeight)];
    self.backView.contentSize = CGSizeMake(self.width*count, self.height - self.cbs_buttonHeight);
    [self.backView setPagingEnabled:YES];
    [self.backView setShowsVerticalScrollIndicator:NO];
    [self.backView setShowsHorizontalScrollIndicator:NO];
    self.backView.backgroundColor = self.cbs_backgroundColor;
    self.backView.bounces = NO;
    
    self.backView.delegate = self;
    [self.view addSubview:self.backView];
}

- (void)addScrollHeader:(NSArray *)titleArray
{
    self.headerView.frame = CGRectMake(0, 0, self.width, self.cbs_buttonHeight);
    self.headerView.contentSize = CGSizeMake(self.cbs_buttonWidth*titleArray.count, self.cbs_buttonHeight);
    [self.view addSubview:self.headerView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.cbs_buttonWidth*index, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
        _titleLabel.textColor = self.cbs_titleColor;
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerView addSubview:_titleLabel];
        
        _segmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.cbs_buttonWidth*index, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
        _segmentBtn.tag = index;
        [_segmentBtn setBackgroundColor:[UIColor clearColor]];
        [_segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:_segmentBtn];
    }
    
    
    self.headerSelectedSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
    [self.headerView addSubview:self.headerSelectedSuperView];
    
    self.headerSelectedView.frame =CGRectMake(0, 0, self.cbs_buttonWidth, self.cbs_buttonHeight);
    self.headerSelectedView.contentSize = CGSizeMake(self.cbs_buttonWidth*titleArray.count, self.cbs_buttonHeight);
    [self.headerSelectedSuperView addSubview:self.headerSelectedView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.cbs_buttonWidth*index, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
        _titleLabel.textColor = self.cbs_titleSelectedColor;
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerSelectedView addSubview:_titleLabel];
        
    }
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.headerSelectedView.contentSize.height - self.cbs_lineHeight, self.headerSelectedView.contentSize.width, self.cbs_lineHeight)];
    bottomLine.backgroundColor = self.cbs_bottomLineColor;
    [self.headerSelectedView addSubview:bottomLine];
}

- (void)addFixedHeader:(NSArray *)titleArray
{
    self.headerView.frame = CGRectMake(0, 0, self.width, self.cbs_buttonHeight);
    self.headerView.contentSize = CGSizeMake(self.width, self.cbs_buttonHeight);
    [self.view addSubview:self.headerView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.cbs_buttonWidth*index, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
        _titleLabel.textColor = self.cbs_titleColor;
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerView addSubview:_titleLabel];
        
        _segmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.cbs_buttonWidth*index, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
        _segmentBtn.tag = index;
        [_segmentBtn setBackgroundColor:[UIColor clearColor]];
        [_segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:_segmentBtn];
    }
    
    self.headerSelectedSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
    [self.headerView addSubview:self.headerSelectedSuperView];
    
    self.headerSelectedView.frame =CGRectMake(0, 0, self.cbs_buttonWidth, self.cbs_buttonHeight);
    self.headerSelectedView.contentSize = CGSizeMake(self.width, self.cbs_buttonHeight);
    [self.headerSelectedSuperView addSubview:self.headerSelectedView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.cbs_buttonWidth*index, 0, self.cbs_buttonWidth, self.cbs_buttonHeight)];
        _titleLabel.textColor = self.cbs_titleSelectedColor;
        _titleLabel.text = titleArray[index];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.headerSelectedView addSubview:_titleLabel];
        
    }
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.headerSelectedView.contentSize.height - self.cbs_lineHeight, self.headerSelectedView.contentSize.width, self.cbs_lineHeight)];
    bottomLine.backgroundColor = self.cbs_bottomLineColor;
    [self.headerSelectedView addSubview:bottomLine];
    
}

- (void)btnClick:(UIButton *)button
{
    [self.backView scrollRectToVisible:CGRectMake(button.tag*self.width, 0, self.backView.frame.size.width, self.backView.frame.size.height) animated:YES];
    [self didSelectSegmentIndex:button.tag];
}

- (void)didSelectSegmentIndex:(NSInteger)index
{

}

- (void)correctHeader:(UIScrollView *)scrollView
{
    if (scrollView == _backView) {
        CGFloat location = _headerSelectedView.contentOffset.x + self.cbs_buttonWidth/2 - self.width/2;
        
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
        self.headerSelectedSuperView.frame = CGRectMake(scrollView.contentOffset.x * (self.cbs_buttonWidth/self.width), self.headerSelectedSuperView.frame.origin.y, self.headerSelectedSuperView.frame.size.width, self.headerSelectedSuperView.frame.size.height);
        self.headerSelectedView.contentOffset = CGPointMake(scrollView.contentOffset.x * (self.cbs_buttonWidth/self.width), 0);
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
    return self.view.frame.size.height;
}

- (CGFloat)width
{
    return self.view.frame.size.width;
}

- (CGFloat)originX
{
    return self.view.frame.origin.x;
}

- (CGFloat)originY
{
    return self.view.frame.origin.y;
}

- (NSMutableArray *)isFinishedArray
{
    if (_isFinishedArray == nil) {
        _isFinishedArray = [[NSMutableArray alloc] init];
    }
    return _isFinishedArray;
}

- (UIScrollView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIScrollView alloc] init];
        [_headerView setShowsVerticalScrollIndicator:NO];
        [_headerView setShowsHorizontalScrollIndicator:NO];
        _headerView.delegate = self;
        _headerView.bounces = NO;
        _headerView.backgroundColor = self.cbs_headerColor;
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
        _headerSelectedView.backgroundColor = self.cbs_headerColor;
        _headerSelectedView.clipsToBounds = YES;
    }
    return _headerSelectedView;
}

- (CGFloat)cbs_buttonHeight
{
    if (_cbs_buttonHeight == 0) {
        _cbs_buttonHeight = 40;
    }
    return _cbs_buttonHeight;
}

- (CGFloat)cbs_buttonWidth
{
    if (_cbs_buttonWidth == 0) {
        _cbs_buttonWidth = self.width/3;
    }
    return _cbs_buttonWidth;
}

- (CGFloat)cbs_lineHeight
{
    if (_cbs_lineHeight == 0) {
        _cbs_lineHeight = 1;
    }
    return _cbs_lineHeight;
}

- (UIColor *)cbs_backgroundColor
{
    if (_cbs_backgroundColor == nil) {
        _cbs_backgroundColor = [UIColor clearColor];
    }
    return _cbs_backgroundColor;
}

- (UIColor *)cbs_headerColor
{
    if (_cbs_headerColor == nil) {
        _cbs_headerColor = [UIColor whiteColor];
    }
    return _cbs_headerColor;
}

- (UIColor *)cbs_titleColor
{
    if (_cbs_titleColor == nil) {
        _cbs_titleColor = [UIColor blackColor];
    }
    return _cbs_titleColor;
}

- (UIColor *)cbs_titleSelectedColor
{
    if (_cbs_titleSelectedColor == nil) {
        _cbs_titleSelectedColor = [UIColor blueColor];
    }
    return _cbs_titleSelectedColor;
}

- (UIColor *)cbs_bottomLineColor
{
    if (_cbs_bottomLineColor == nil) {
        _cbs_bottomLineColor = self.cbs_titleSelectedColor;
    }
    return _cbs_bottomLineColor;
}

@end
