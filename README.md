# CBSSegmentView

## 效果

![wait](https://github.com/cbsfly/cbsfly.github.io/raw/master/images/gallery1/segment1.gif)

![wait](https://github.com/cbsfly/cbsfly.github.io/raw/master/images/gallery1/segment2.gif)

## 支持CocoaPods

`pod 'CBSSegmentView'`

安装成功后，请将所需添加标签栏视图控制器继承于CBSSegmentViewController

`@interface ExampleViewController : CBSSegmentViewController
`

## 使用

### Init

	- (void)viewDidLoad {
	    [super viewDidLoad];
	    //设置各个标签名字
	    self.cbs_titleArray = @[@"first", @"second", @"third", @"first", @"second", @"third"];
	    //设置各个标签对应的ViewController，如果数量不对会崩溃
	    self.cbs_viewArray = @[@"FirstViewController", @"SecondViewController", @"ThirdViewController", @"FirstViewController", @"SecondViewController", @"ThirdViewController"];
	    self.cbs_Type = CBSSegmentHeaderTypeScroll;
	    //先设置cbs_titleArray和cbs_viewArray再调用initSegment
	    [self initSegment];
	}
    
type有两种

	typedef NS_ENUM(NSInteger, CBSSegmentHeaderType) {
	    CBSSegmentHeaderTypeScroll,//标签栏可滚动
	    CBSSegmentHeaderTypeFixed//标签栏固定
	};


### Setting (set it before init)

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

    
### Button Click Action

	- (void)didSelectSegmentIndex:(NSInteger)index;


### 自己写的部分源码解析点[这里](http://cbsfly.github.io/ios/segmentview)

有帮助的话希望可以star一下，有什么意见也希望留言告诉我，我会改正。

