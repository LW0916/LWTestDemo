//
//  LWMemoryDistributeViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/8/6.
//

#import "LWMemoryDistributeViewController.h"
#import "LWTestObject.h"

int a = 10;
int b;

@interface LWMemoryDistributeViewController ()
{
    NSString *test11;
    LWTestObject *_object;
}

@property(nonatomic,copy)NSString *testCopyString;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)LWTestObject *testObject;


@end

@implementation LWMemoryDistributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testMemoryDistribute];
    [self taggedPointer];
    //testStr 和testStr2有什么区别?  testStr2会崩溃 多线程同时访问set方法释放的时候会出问题 坏内存访问 重复release，解决方法 加锁或串行。  testStr是中的str是taggedPointer 存储在指针中。
    [self testStr];
//    [self testStr2];
    
    [self testCopy];
    
    [self testObjectProperty];
}
- (void)testObjectProperty{

    LWTestObject *object1 = [[LWTestObject alloc]init];
    object1.age = 20;
    _object = object1;
    
    LWTestObject *object2 =  [[LWTestObject alloc]init];
    object2.age = 10;    
    _testObject = object2;
//    self.testObject = object2;
}
- (void)testCopy{
    /*
     可变 copy mutableCopy都是深拷贝
     不可变 copy浅拷贝 mutableCopy深拷贝
     copy 出来的都是不可变的
     p str1
     (__NSCFConstantString *) $0 = 0x000000010b5ff060 @"123"
     (lldb) p str2
     (__NSCFConstantString *) $1 = 0x000000010b5ff060 @"123"
     (lldb) p str3
     (__NSCFString *) $2 =   @"123"
     (lldb) p str4
     (__NSCFString *) $3 = 0x000060c000045a60 @"344"
     (lldb) p str5
     (NSTaggedPointerString *) $4 = 0xa000000003434333 @"344"
     (lldb) p str6
     (__NSCFString *) $5 = 0x000060c000045850 @"344"
     (lldb)
     */
    NSString *str1 = @"123";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];

    NSMutableString *str4 = [NSMutableString stringWithString:@"344"];
    NSMutableString *str5 = [str4 copy];
    NSMutableString *str6 = [str4 mutableCopy];
    
    self.testCopyString = str4;
    
    _testCopyString = str4;
    test11 = str4;
}
- (void)testMemoryDistribute{
    static int c = 20;
    static int d;
    
    int e;
    int f= 20;
    
    NSString *str = @"123";
    
    NSObject *obj = [[NSObject alloc]init];
    /* 打印结果：
     &a=0x10d289ca8     已初始化的全局变量、静态变量。
     &b=0x10d289cc8     未初始化的全局变量、静态变量。
     &c=0x10d289cac     已初始化的全局变量、静态变量。
     &d=0x10d289cd4     已初始化的全局变量、静态变量。
     &e=0x7ffee299cabc  栈
     &f=0x7ffee299cab8  栈
     &str=0x10d27f1e0   字符串常量
     &obj=0x6000006f4420    堆
     内存地址由小到大     str a c b d objc f e
     */
    NSLog(@"%s\n&a=%p\n&b=%p\n&c=%p\n&d=%p\n&e=%p\n&f=%p\n&str=%p\n&obj=%p\n",__func__,&a,&b,&c,&d,&e,&f,str,obj);
}

- (void)taggedPointer{
    NSNumber *number1 = @4;
    NSNumber *number2 = @5;
    NSNumber *number3 = @(0xfffffffffffffff);
    NSLog(@"%s %p %p %p",__func__, number1,number2,number3);//0xb27ba423af092e0e 0xb27ba423af092e1e 0x6000001b20c0
}

- (void)testStr{
    NSString *str1 = [NSString stringWithFormat:@"abc"];
    NSString *str2 = [NSString stringWithFormat:@"abcdefghigkkkk"];
    NSLog(@"%p %p %@ %@",str1,str2,[str1 class],[str2 class]);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i =0; i<1000; i++) {
        dispatch_async(queue, ^{
            NSLog(@"===>%d ==%@",i,[NSThread currentThread]);
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }
}
- (void)testStr2{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i =0; i<1000; i++) {
        dispatch_async(queue, ^{
            NSLog(@"===>%d ==%@",i,[NSThread currentThread]);
            self.name = [NSString stringWithFormat:@"abcdefghigkkkk"];
        });
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"_object.age =%d",_object.age);
    NSLog(@"_testObject.age = %d",_testObject.age);

}
@end
