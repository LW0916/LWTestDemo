//
//  LWLifeCycleViewController.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/12.
//

#import "LWLifeCycleViewController.h"
#import "LWSettingLog.h"

@interface LWLifeCycleViewController ()

@end

@implementation LWLifeCycleViewController

+(void)load{
    NSLog(@"");
}

+ (void)initialize{
    NSLog(@"");
}
+(id)allocWithZone:(NSZone *)zone{
    return [super allocWithZone:zone];
    NSLog(@"");
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    NSLog(@"非 StoryBoard 创建 UIViewController 会调用这个方法。不要在这里做 View 相关操作，View 在 loadView 方法中才初始化。");
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    NSLog(@"使用 StoryBoard 进行视图管理，StoryBoard 会自动初始化 UIViewController，方法 initWithNibName:bundle 不会被调用，initWithCoder 会被调用。");
    if (self) {
        NSLog(@"self==%@",self);
    }
    return self;
}

- (void)loadView{
    [super loadView];
    NSLog(@"loadView 方法在 UIViewController 对象的 view 被访问且为空的时候调用。这是它与 awakeFromNib 方法的一个区别。在重写 loadView 方法的时候，不要调用父类的方法。self.view 是在 loadView 方法中创建并建立联系的，不要调用 [super loadView]，要将自定义的 view 赋值给 self.view。如果该控制器没有 xib 文件，重写了 loadView 但没有做任何事情(也就是 self.view为空)，在 viewDidLoad 中还使用了 self.view(self.view 为空时会调用 loadView)，这样会造成死循环。");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"视图加载");
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"将要进入页面");
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"视图将要布局");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"视图已经布局");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"视图已经出现");
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"视图将要消失");
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"视图已经消失");
}
- (void)dealloc{
    NSLog(@"视图销毁");
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"内存警告");
}


@end
