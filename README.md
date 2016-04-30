# CBSSegmentView

## 支持CocoaPods

`pod 'CBSSegmentView'`

安装成功需导入头文件`#import "CbsSegmentView.h"`

## 使用

### Init

	//设置各个标签名字
    NSArray *titleArray = @[@"first", @"second", @"third", @"first", @"second", @"third"];
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    NSArray *viewArray = @[@"FirstViewController", @"SecondViewController", @"ThirdViewController", @"FirstViewController", @"SecondViewController", @"ThirdViewController"];
    self.segmentView = [[CbsSegmentView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) title:titleArray view:viewArray type:CbsSegmentHeaderTypeScroll];
    self.segmentView.delegate = self;
    [self.view addSubview:self.segmentView];
    
type有两种

	typedef NS_ENUM(NSInteger, CbsSegmentHeaderType) {
    	CbsSegmentHeaderTypeFixed,//标签栏固定
    	CbsSegmentHeaderTypeScroll//标签栏可滚动
	};


### Setting

    self.segmentView.headerColor = [UIColor purpleColor];
    self.segmentView.titleSelectedColor = [UIColor blackColor];
    self.segmentView.titleColor = [UIColor whiteColor];
    self.segmentView.bottomLineColor = [UIColor grayColor];
    
### Button Click Delegate

	- (void)didSelectSegmentIndex:(NSInteger)index;


### 自己写的部分源码解析点[这里](http://cbsfly.github.io/ios/segmentview)

有帮助的话希望可以star一下，有什么意见也希望留言告诉我，我会改正。

