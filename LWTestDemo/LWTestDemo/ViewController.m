//
//  ViewController.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/12.
//
/*
    *ViewController生命周期
 initWithCoder:
 awakeFromNib
 loadView
 viewDidLoad
 viewWillAppear:
 viewWillLayoutSubviews
 viewDidLayoutSubviews
 viewDidAppear:
 viewWillDisappear:
 viewDidDisappear:
 dealloc
 
 */

#import "ViewController.h"
#import "LWSettingLog.h"
#import "LWLifeCycleView.h"
#import "LWLifeCycleViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)LWLifeCycleView *lifeCycleView;

@end

@implementation ViewController

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height- 60) style:(UITableViewStylePlain)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor lightGrayColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
- (LWLifeCycleView *)lifeCycleView{
    if (_lifeCycleView == nil) {
        _lifeCycleView = [[LWLifeCycleView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height- 50, 40, 40)];
        _lifeCycleView.backgroundColor = [UIColor redColor];
    }
    return _lifeCycleView;
}
- (NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = @[@"LWLifeCycleViewController",@"LWLoadInitializeViewController",@"LWCrashViewController",@"LWGCDViewController",@"LWCategoryViewController",@"LWNatureViewController",@"LWKVOViewController",@"LWKVCViewController",@"LWBlockViewController",@"LWRuntimeViewController",@"LWSuperViewController",@"LWRunLoopViewController",@"LWBluetoothViewController",@"LWMemoryManagerViewController"];
    }
    return _dataSource;
}

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
    /*
     1、指定收索路径名称NSSearchPathDirectory
     常用的有：NSDocumentDirectory、NSLibraryDirectory、NSCachesDirectory
     2、限定文件检索范围​NSSearchPathDomainMask
     NSUserDomainMask = 1,       // 用户主目录  user's home directory --- place to install user's personal items (~)
     NSLocalDomainMask = 2,      // 当前机器  local to the current machine --- place to install items available to everyone on this machine (/Library)
     NSNetworkDomainMask = 4,    // 网络中可见的主机  publically available location in the local area network --- place to install items available on the network (/Network)
     NSSystemDomainMask = 8,     // 系统目录,不可修改 provided by Apple, unmodifiable (/System)
     NSAllDomainsMask = 0x0ffff  // 所有 all domains: all of the above and future items
     3、是否显示完整路径
     YES为展开后完整路径，NO为 ~/文件目录(例~/Documents)
     
     iOS开发是在沙盒中开发的，对一些部分的文件的读写进行了限制， 只能在几个目录下读写文件：
     （1）Documents：应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
     （2） tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
     （3） Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
     */
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;

    NSLog(@"path===>%@",path);
    NSLog(@"cachesPath===>%@",cachesPath);
    NSLog(@"libraryPath===>%@",libraryPath);

    NSLog(@"loadView 方法在 UIViewController 对象的 view 被访问且为空的时候调用。这是它与 awakeFromNib 方法的一个区别。在重写 loadView 方法的时候，不要调用父类的方法。self.view 是在 loadView 方法中创建并建立联系的，不要调用 [super loadView]，要将自定义的 view 赋值给 self.view。如果该控制器没有 xib 文件，重写了 loadView 但没有做任何事情(也就是 self.view为空)，在 viewDidLoad 中还使用了 self.view(self.view 为空时会调用 loadView)，这样会造成死循环。");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *image = [UIImage imageNamed:@"block"];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    
    if (@available(iOS 15.0, *)){
            UIView *barBackgroundView = self.navigationController.navigationBar.subviews.firstObject;
            UIColor *naviBarTintColor = [UIColor redColor];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, barBackgroundView.frame.size.width, barBackgroundView.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height)];
            [view setBackgroundColor:naviBarTintColor];
            [barBackgroundView addSubview:view];
        }
    NSLog(@"super class ==>%@ super superclass ==>%@   ",[super class],[super superclass]);
    NSLog(@"视图加载 --- 加载子视图之前");
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.lifeCycleView];
    NSLog(@"视图加载--- 加载子视图之后");
    [self testIsMemberOfClassAndIsKindOfClass];
    
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

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifierCell = @"cell";
    UITableViewCell *cell = [_myTableView dequeueReusableCellWithIdentifier:identifierCell];
    NSString *title = self.dataSource[indexPath.row];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = title;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *classStr = _dataSource[indexPath.row];
    Class className = NSClassFromString(classStr);
    UIViewController *vc = [[className alloc]init];
    NSLog(@"pushViewController 之前");
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"pushViewController 之后");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"");
    if (_lifeCycleView == nil) {
        [self.view addSubview:self.lifeCycleView];
    }else{
        [self.lifeCycleView removeFromSuperview];
        self.lifeCycleView = nil;
    }
}

/*
     + (BOOL)isMemberOfClass:(Class)cls {
     return object_getClass((id)self) == cls;
    }

    - (BOOL)isMemberOfClass:(Class)cls {
     return [self class] == cls;
    }

    + (BOOL)isKindOfClass:(Class)cls {
     for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->super_class) {
         if(tcls == cls) return YES;
     }
     return NO；
    }
    -（BOOL)isKindOfClass:(Class)cls {
     for(Class tcls = [self class]; tcls; tcls = tcls->super_class) {
         if(tcls == cls) return YES;
     }
     return NO;
    }
 
    根元类的isa指针指向自己 根源类的superClass指针指向根类(NSObject) NSObject
 **/
#pragma mark -- testIsMemberOfClassAndIsKindOfClass
- (void)testIsMemberOfClassAndIsKindOfClass{
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[ViewController class] isKindOfClass:[ViewController class]];
    BOOL res4 = [(id)[ViewController class] isMemberOfClass:[ViewController class]];
    NSLog(@"res=>%d%d%d%d",res1,res2,res3,res4);
}
@end
