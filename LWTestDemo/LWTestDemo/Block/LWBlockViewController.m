//
//  LWBlockViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/8.
//

#import "LWBlockViewController.h"
#import "LWBlockType.h"

@interface LWBlockViewController (){
    
    int _weight;
}

@end

@implementation LWBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     struct __LWBlockViewController__viewDidLoad_block_impl_0 {
       struct __block_impl impl;
       struct __LWBlockViewController__viewDidLoad_block_desc_0* Desc;
       int age;
     
       __LWBlockViewController__viewDidLoad_block_impl_0(void *  , struct __LWBlockViewController__viewDidLoad_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     
     struct __block_impl {
       void *isa;
       int Flags;
       int Reserved;
       void *FuncPtr;
     };
     
    struct __LWBlockViewController__viewDidLoad_block_desc_0 {
       size_t reserved;
       size_t Block_size;
     }
     
     */
    int age= 10;
    void (^block)(int,int) = ^(int a,int b){
        NSLog(@"this is block --%d",age);
    };
    block(10,20);
    [self test];
    [self test2];
    [self test3];
    [self test4];
    
    LWBlockType *blockType = [[LWBlockType alloc]init];
    [blockType testType];
}

- (void)test{
    /*
     //block
     struct __LWBlockViewController__test_block_impl_0 {
         struct __block_impl impl;
        
         struct __LWBlockViewController__test_block_desc_0* Desc;
        //构造函数
         __LWBlockViewController__test_block_impl_0(void *fp, struct __LWBlockViewController__test_block_desc_0 *desc, int flags=0) {
           impl.isa = &_NSConcreteStackBlock;
           impl.Flags = flags;
           impl.FuncPtr = fp;
           Desc = desc;
         }
     };
     */
    /*
         //封装了block执行逻辑函数
         static void __LWBlockViewController__test_block_func_0(struct __LWBlockViewController__test_block_impl_0 *__cself) {

                 NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_2fc0ab_mi_1);
             }
         //计算block占用的内存空间
         static struct __LWBlockViewController__test_block_desc_0 {
           size_t reserved;
           size_t Block_size;
         } __LWBlockViewController__test_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__test_block_impl_0)};
     */
    /*
         //定义block变量
         void _I_LWBlockViewController_test(LWBlockViewController * self, SEL _cmd) {
             void (*block)(void) = ((void (*)())&__LWBlockViewController__test_block_impl_0((void *)__LWBlockViewController__test_block_func_0, &__LWBlockViewController__test_block_desc_0_DATA));
         // 执行block内部代码
        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
         }
     */
    void (^block)(void) = ^(){
        NSLog(@"this is block ");
    };
    block();
}

- (void)test2{
    /*
         _I_LWBlockViewController_test2(LWBlockViewController * self, SEL _cmd) {
             void (*block)(int,int) = ((void (*)(int, int))&__LWBlockViewController__test2_block_impl_0((void *)__LWBlockViewController__test2_block_func_0, &__LWBlockViewController__test2_block_desc_0_DATA));
             ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 10, 20);
         }
     */
    void (^block)(int,int) = ^(int a,int b){
        NSLog(@"this is block --%d ==%d",a,b);
    };
    block(10,20);
}

- (void)test3{
    /*
     
     void _I_LWBlockViewController_test3(LWBlockViewController * self, SEL _cmd) {
         int age = 10;

         void (*block)(int,int) = ((void (*)(int, int))&__LWBlockViewController__test3_block_impl_0((void *)__LWBlockViewController__test3_block_func_0, &__LWBlockViewController__test3_block_desc_0_DATA, age));
     
         age = 20;
         ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 30, 320);
     }
     
     struct __LWBlockViewController__test3_block_impl_0 {
       struct __block_impl impl;
       struct __LWBlockViewController__test3_block_desc_0* Desc;
       int age;
       __LWBlockViewController__test3_block_impl_0(void *fp, struct __LWBlockViewController__test3_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     }
     
     static void __LWBlockViewController__test3_block_func_0(struct __LWBlockViewController__test3_block_impl_0 *__cself, int a, int b) {
       int age = __cself->age; // bound by copy

             NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_2fc0ab_mi_3,age);
         }
     */
    int age = 10;
    void (^block)(int,int) = ^(int a,int b){
        //age的值捕获进来（capture）
        NSLog(@"this is block --%d",age);//打印10
    };
    age = 20;
    block(30,320);
}

- (void)test4{
    /*
     block 值捕获：
        局部变量：能捕获到block内部
            auto: 自动变量，离开作用域就销毁  访问方式：值传递
            static：静态变量。    访问方式：指针传递
            如果有self会捕获self self是一个局部变量 self是函数的隐藏参数。

        全局变量：
            不能捕获到block内部 访问方式：直接访问
        
     */
    /*
     _I_LWBlockViewController_test4(LWBlockViewController * self, SEL _cmd) {
        int age = 10;
        static int height = 100;
        (*(int *)((char *)self + OBJC_IVAR_$_LWBlockViewController$_weight)) = 20;
        void (*block)(int,int) = ((void (*)(int, int))&__LWBlockViewController__test4_block_impl_0((void *)__LWBlockViewController__test4_block_func_0, &__LWBlockViewController__test4_block_desc_0_DATA, age, &height, self, 570425344));
        (*(int *)((char *)self + OBJC_IVAR_$_LWBlockViewController$_weight)) = 30;
        age = 20;
        height = 200;
        ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 30, 320);

    }

     __LWBlockViewController__test4_block_impl_0 {
      struct __block_impl impl;
      struct __LWBlockViewController__test4_block_desc_0* Desc;
      int age;
      int *height;
      LWBlockViewController *self;
      __LWBlockViewController__test4_block_impl_0(void *fp, struct __LWBlockViewController__test4_block_desc_0 *desc, int _age, int *_height, LWBlockViewController *_self, int flags=0) : age(_age), height(_height), self(_self) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
      }
    };
    static void __LWBlockViewController__test4_block_func_0(struct __LWBlockViewController__test4_block_impl_0 *__cself, int a, int b) {
      int age = __cself->age; // bound by copy
      int *height = __cself->height; // bound by copy
      LWBlockViewController *self = __cself->self; // bound by copy


            NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_2fc0ab_mi_4,age,(*height),(*(int *)((char *)self + OBJC_IVAR_$_LWBlockViewController$_weight)));
        }
     */
    int age = 10;
    static int height = 100;
    _weight = 20;
    void (^block)(int,int) = ^(int a,int b){
        //age的值捕获进来（capture）
        NSLog(@"this is block --age=%d  height=%d  weight=%d",age,height,self->_weight);//this is block --age=10  height=200  weight=30
    };
    _weight = 30;
    age = 20;
    height = 200;
    block(30,320);
    
}

@end
