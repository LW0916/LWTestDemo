//
//  LWKVCViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/2.
//

#import "LWKVCViewController.h"
#import "LWKVCPerson.h"
#import "LWKVCDog.h"

@interface LWKVCViewController ()

@end
/*
 - (nullableid)valueForKey:(NSString*)key;//直接通过Key来取值
 
 - (void)setValue:(nullableid)value forKey:(NSString*)key;//通过Key来设值
 
 - (nullableid)valueForKeyPath:(NSString*)keyPath;//通过KeyPath来取值
 
 - (void)setValue:(nullableid)value forKeyPath:(NSString*)keyPath;//通过KeyPath来设值
 
 + (BOOL)accessInstanceVariablesDirectly; //默认返回YES，表示如果没有找到Set方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员，设置成NO就不这样搜索
    //如果你重写了该方法让其返回NO的话，那么在这一步KVC会执行setValue：forUndefinedKey：方法
 
 - (BOOL)validateValue:(inout id __nullable * __nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError;//KVC提供属性值正确性验证的API，它可以用来检查set的值是否正确、为不正确的值做一个替换值或者拒绝设置新值并返回错误原因。
 
 - (nullable id)valueForUndefinedKey:(NSString *)key;//如果Key不存在，且没有KVC无法搜索到任何和Key有关的字段或者属性，则会调用这个方法，默认是抛出异常。
 
 - (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key;//和上一个方法一样，但这个方法是设值。
 
 - (void)setNilValueForKey:(NSString *)key;//如果你在SetValue方法时面给Value传nil，则会调用这个方法
 
 - (NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys;//输入一组key,返回该组key对应的Value，再转成字典返回，用于将Model转到字典。
 
 
 
 设值的实现步骤：
 
 1.首先搜索是否有setKey:的方法（key是成员变量名，首字母大写）,没有则会搜索是否有setIsKey:的方法。
 
 2.如果没有找到setKey:的方法,此时看+ (BOOL)accessInstanceVariablesDirectly; （是否直接访问成员变量）方法。
 
 若返回NO，则直接调用 - (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key;(默认是抛出异常)。
 
 若返回YES，按 _key、_iskey、key、isKey的顺序搜索成员名。
 
 3.在第二步还没搜到的话就会调用 - (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key方法。
 
 由以上实验得出结论：
 
 KVC的赋值本质上只是调用了属性的setter方法，setter方法会按照setKey、_setKey、setIsKey的优先级进行调用，还没有，则按_key、_isKey、key、isKey查找成员变量。
 
 
 KVC取值的实现：
 1.按先后顺序搜索getKey:、key、isKey _key四个个方法，若某一个方法被实现，取到的即是方法返回的值，后面的方法不再运行。如果是BOOL或者Int等值类型， 会将其包装成一个NSNumber对象。
 
 2.若这三个方法都没有找到，则会调用+ (BOOL)accessInstanceVariablesDirectly方法判断是否允许取成员变量的值。
 
 若返回NO，直接调用- (nullable id)valueForUndefinedKey:(NSString *)key方法，默认是奔溃。
 
 若返回YES,会按先后顺序取_key、_isKey、 key、isKey的值。
 
 3.返回YES时，_key、_isKey、 key、isKey的值都没取到，调用- (nullable id)valueForUndefinedKey:(NSString *)key方法。
 
 验证后得出结论：
 
 在取值过程中通过getKey、key、isKey _key:取到的值为直接返回的值，所以本质上是按先后顺序调用了这三个setter方法，如果没有，则会询问+ (BOOL)accessInstanceVariablesDirectly方法能否直接取成员变量，若返回YES，则会按顺序取_key、_isKey、 key、isKey的值。
 */
@implementation LWKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LWKVCPerson *p = [[LWKVCPerson alloc]init];
    p->_key = @"_key";
    p->key  = @"key";
    p->_isKey = @"_isKey";
    p->isKey = @"isKey";
    /*
        查找方法 先查找key 1.set get方法
     + (BOOL)accessInstanceVariablesDirectly; //默认返回YES，表示如果没有找到Set方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员，设置成NO就不这样搜索
     2.iskey的set get方法 3._key 4._isKey 5.key 6.isKey
     */
    [p setValue:@"kvcValue" forKey:@"key"];
//    [p setValue:nil forKey:@"key1"];//*** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Person 0x127e409d0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key key1.'
//    [p valueForKey:@"key2"];//*** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Person 0x1009b0d90> valueForUndefinedKey:]: this class is not key value coding-compliant for the key key2.'
    NSString *key = [p valueForKey:@"key"];
    NSLog(@"%@",key);
    
    
    LWKVCDog *d = [[LWKVCDog alloc]init];
    [d setValue:nil forKey:@"key1"];
    [d setValue:@"2222" forKey:@"key2"];
    NSString *value3 =  [d valueForKey:@"key3"];
    NSString *value2 =  [d valueForKey:@"key2"];
    NSString *value1 = [d valueForKey:@"key1"];
    NSLog(@"value1==>%@ value2===>%@  value3===%@",value1,value2,value3);
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:nil forKey:@"key1"];// 会奔溃** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: key1)'
    [dict setValue:nil forKey:@"key1"];
    NSString *str = [dict valueForKey:@"key2"];
    NSString *str1 = [dict objectForKey:@"key3"];
    NSString *str2 = dict[@"key4"];
    NSLog(@"%@ %@ %@ %@",str,str1,str2,dict[@"key1"]);

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
