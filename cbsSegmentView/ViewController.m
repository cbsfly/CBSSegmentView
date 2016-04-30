//
//  ViewController.m
//  cbsSegmentView
//
//  Created by 陈秉慎 on 4/16/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import "ViewController.h"
#import "CbsSegmentView.h"

@interface ViewController ()<CbsSegmentViewDelegate>
@property (nonatomic, strong) CbsSegmentView *segmentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titleArray = @[@"first", @"second", @"third", @"first", @"second", @"third"];
    NSArray *viewArray = @[@"FirstViewController", @"SecondViewController", @"ThirdViewController", @"FirstViewController", @"SecondViewController", @"ThirdViewController"];
    self.segmentView = [[CbsSegmentView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) title:titleArray view:viewArray type:CbsSegmentHeaderTypeScroll];
    self.segmentView.delegate = self;
    [self.view addSubview:self.segmentView];
}

- (void)didSelectSegmentIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
}

@end
