//
//  LWKVOViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/2/26.
//

#import "LWKVOViewController.h"
#import "LWKOVPerson.h"
#import <objc/runtime.h>

@interface LWKVOViewController ()

@property(nonatomic,strong)LWKOVPerson *person;
@property(nonatomic,strong)LWKOVPerson *person2;

@end

@implementation LWKVOViewController
/*
    KVO的全称 Key-Value Observing 键值监听，用于监听某个对象属性值的变化
    未使用KVO监听的对象 instance对象的isa 指向类对象。
    使用了KVO监听的对象 instance对象的isa 指向NSKVONotify_LWKOVPerson 是LWKOVPerson的子类(程序运行过程中动态创建的一个类)
 
 */
- (void)printMethodNameOfClass:(Class)cls{
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    for (int i =0 ; i<count ; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    NSLog(@"%@ =methodNames= %@",cls,methodNames);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[LWKOVPerson alloc]init];
    self.person.age = 10;
    self.person.height = 120;
    
    self.person2 = [[LWKOVPerson alloc]init];
    self.person2.age = 2;
    self.person2.height = 22;
    
    NSLog(@"person添加kvo监听之前 - %@ %@",object_getClass(self.person),object_getClass(self.person2));
    NSLog(@"添加kvo监听之前%p %p",[self.person methodForSelector:@selector(setAge:)],[self.person2 methodForSelector:@selector(setAge:)]);
    
    NSKeyValueObservingOptions Options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:Options context:@"123"];
    [self.person addObserver:self forKeyPath:@"height" options:Options context:nil];
    [self.person addObserver:self forKeyPath:@"_weight" options:Options context:nil];

    NSLog(@"person添加kvo监听之后 - %@ %@",object_getClass(self.person),object_getClass(self.person2));
    NSLog(@"添加kvo监听之前%p %p",[self.person methodForSelector:@selector(setAge:)],[self.person2 methodForSelector:@selector(setAge:)]);
    NSLog(@"类对象 - %@ %@",object_getClass(self.person),object_getClass(self.person2));
    NSLog(@"元类对象 - %@ %@",object_getClass(object_getClass(self.person)),object_getClass(object_getClass(self.person2)));
    [self printMethodNameOfClass:object_getClass(self.person)];
    [self printMethodNameOfClass:object_getClass(self.person2)];


/*
 2021-03-01 15:02:26.071706+0800 LWTestDemo[30469:314364] person添加kvo监听之前 - LWKOVPerson LWKOVPerson
 2021-03-01 15:02:26.071829+0800 LWTestDemo[30469:314364] 添加kvo监听之前0x106714940 0x106714940
 2021-03-01 15:02:26.072408+0800 LWTestDemo[30469:314364] person添加kvo监听之后 - NSKVONotifying_LWKOVPerson LWKOVPerson
 2021-03-01 15:02:26.072539+0800 LWTestDemo[30469:314364] 添加kvo监听之前0x106ae29e4 0x106714940
 */
/*    p (IMP)0x106ae29e4
    (IMP) $1 = 0x0000000106ae29e4 (Foundation`_NSSetIntValueAndNotify)
    p (IMP)0x106714940
    (IMP) $2 = 0x0000000106714940 (LWTestDemo`-[LWKOVPerson setAge:] at LWKOVPerson.m:11)
  */
    /*
        p self.person.isa 输出：
        (__unsafe_unretained Class) $1 = NSKVONotifying_LWKOVPerson
        Fix-it applied, fixed expression was:
        self.person->isa
     
        p self.person2.isa 输出：
        (__unsafe_unretained Class) $3 = LWKOVPerson
        Fix-it applied, fixed expression was:
        self.person2->isa
     */
   
    // Do any additional setup after loading the view.
    
}
- (void)dealloc{
    [self.person removeObserver:self forKeyPath:@"age"];
    [self.person removeObserver:self forKeyPath:@"height"];
    [self.person removeObserver:self forKeyPath:@"_weight"];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.person.age = 20;
    self.person.height = 170;
    [self.person setValue:@600 forKey:@"_weight"];
    self.person->_weight = 60;
    
    self.person2.age = 12;
    self.person2.height = 122;
    [self.person2 setValue:@800 forKey:@"_weight"];
    self.person2->_weight = 80;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到 %@的%@属性的值改变了 - %@ context=%@",object,keyPath,change,context);
}
@end
