//
//  ExampleViewController.m
//  cbsSegmentView
//
//  Created by 陈秉慎 on 5/5/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置各个标签名字
    self.cbs_titleArray = @[@"first", @"second", @"third", @"first", @"second", @"third"];
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    self.cbs_viewArray = @[@"FirstViewController", @"SecondViewController", @"ThirdViewController", @"FirstViewController", @"SecondViewController", @"ThirdViewController"];
    self.cbs_Type = CBSSegmentHeaderTypeScroll;
    self.cbs_headerColor = [UIColor grayColor];
    self.cbs_buttonHeight = 50;
    //先设置cbs_titleArray和cbs_viewArray再调用initSegment
    [self initSegment];
    
}

- (void)didSelectSegmentIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
}

@end
