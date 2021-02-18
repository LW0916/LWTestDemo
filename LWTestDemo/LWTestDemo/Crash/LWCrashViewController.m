//
//  LWCrashViewController.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/13.
//

#import "LWCrashViewController.h"

@interface LWCrashViewController ()

@end

@implementation LWCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"exception" forState:(UIControlStateNormal)];
    [btn  setFrame:CGRectMake(100, 100, 100, 100)];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setBackgroundColor: [UIColor blueColor]];
    [self.view addSubview: btn];
    // Do any additional setup after loading the view.
}
- (void)clickBtn:(UIButton *)btn{
    NSArray *arr = @[@"1",@"2"];
    NSString *str = arr[4];
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
