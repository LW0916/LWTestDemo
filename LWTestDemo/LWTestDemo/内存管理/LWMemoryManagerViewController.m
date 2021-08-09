//
//  LWMemoryManagerViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/8/3.
//

#import "LWMemoryManagerViewController.h"

@interface LWMemoryManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation LWMemoryManagerViewController
- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor lightGrayColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = @[@"LWTimerViewController",@"LWMemoryDistributeViewController"];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
