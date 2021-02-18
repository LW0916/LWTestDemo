//
//  LWLoadInitializeViewController.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/13.
//

/*
    在main函数之前 系统会在线程上首先发送call_load_method，这会使系统向所有的类发送load方法调用，
    接着每个类都会收到[XXXClass load]
    按照  compile sources加载的文件顺序调用load方法 但是注意 最后加载分类
 */

#import "LWLoadInitializeViewController.h"
#import "Student.h"
#import "Teacher.h"

@interface LWLoadInitializeViewController ()

@end

@implementation LWLoadInitializeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     load、initialize方法的区别

     1.调用方式
     (1).load是根据函数地址直接调用。
     (2).initialize是通过objc_msgSend调用。
     2.调用时刻(什么时候会调用)
     (1).load是runtime加载类、分类的时候调用(只会调用一次)
     (2).initialize是类第一次接收到消息的时候调用，每一个类只会initialize一次(父类的initialize方法可能会被调用多次)。

     2. load、initialize的调用顺序？
     2-1、load:
     (1).先调用类的load
         (a).先编译的类优先调用load。
         (b).调用子类的load之前，会先调用父类的load。
     (2).再调用分类的load
         (a).先编译的分类，优先调用load。
     2-2、Initialize:
     (1).先初始化父类。
     (2).再初始化子类(可能最终调用的是父类的Initialize的方法(原因：如果子类没有实现Initialize方法时，会通过superclass调用父类的Initialize的方法)))。

     (3).如果在分类中也实现了Initialize方法，则会先调用父类的中的方法，再调用分类中的方法,不会调用本类中的方法，(原因:在运行时(runtime)系统会把分类中的方法插入到原有类的方法数组之前(系统会先创建一个数组将原有类中的方法加入到数组中，在运行时,系统会把分类中的方法插入到数组中(是插入不是添加哦！)))。
     
     如果Student本 分类和Teacher都不实现initialize 打印结果如果
     2020-12-13 14:08:00.495183+0800 LWTestDemo[1737:50717] person+test initialize方法
     2020-12-13 14:08:00.495296+0800 LWTestDemo[1737:50717] person+test initialize方法
     2020-12-13 14:08:02.496585+0800 LWTestDemo[1737:50717] person+test initialize方法     
     */
    Student *s = [[Student alloc]init];
    sleep(2);
    Teacher *t = [[Teacher alloc]init];
    sleep(2);
    Person *p = [[Person alloc]init];
    sleep(2);
    Student *s1 = [[Student alloc]init];
    sleep(1);
    Teacher *t1 = [[Teacher alloc]init];
    sleep(1);
    Person *p1 = [[Person alloc]init];

    // Do any additional setup after loading the view.
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
