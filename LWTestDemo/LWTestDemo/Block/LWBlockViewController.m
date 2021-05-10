//
//  LWBlockViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/8.
//

#import "LWBlockViewController.h"
#import "LWBlockType.h"
#import "LWBlockPerson.h"

int gTest; //全局变量
typedef void(^LWBlock)(void);
@interface LWBlockViewController (){
    
    int _weight;//成员变量 通过self访问
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
    
    [self testBlockPerson1];
    [self testBlockPerson2];
    
    [self test__block1];
    [self circularReferenceTest];
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
            如果有self会捕获self self是一个局部变量 self是函数的隐藏参数。 成员变量通过self访问。
            
        全局变量：
            不能捕获到block内部 访问方式：直接访问
        
     */
    /*
    
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
     };
     static void __LWBlockViewController__test3_block_func_0(struct __LWBlockViewController__test3_block_impl_0 *__cself, int a, int b) {
       int age = __cself->age; // bound by copy


             NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_e48887_mi_3,age);
         }

     static struct __LWBlockViewController__test3_block_desc_0 {
       size_t reserved;
       size_t Block_size;
     } __LWBlockViewController__test3_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__test3_block_impl_0)};

     static void _I_LWBlockViewController_test3(LWBlockViewController * self, SEL _cmd) {
         int age = 10;
         void (*block)(int,int) = ((void (*)(int, int))&__LWBlockViewController__test3_block_impl_0((void *)__LWBlockViewController__test3_block_func_0, &__LWBlockViewController__test3_block_desc_0_DATA, age));
         age = 20;
         ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 30, 320);
     }


     struct __LWBlockViewController__test4_block_impl_0 {
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


             NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_e48887_mi_4,age,(*height),(*(int *)((char *)self + OBJC_IVAR_$_LWBlockViewController$_weight)),gTest);
         }
     static void __LWBlockViewController__test4_block_copy_0(struct __LWBlockViewController__test4_block_impl_0*dst, struct __LWBlockViewController__test4_block_impl_0*src) {_Block_object_assign((void*)&dst->self, (void*)src->self, 3 BLOCK_FIELD_IS_OBJECT);}

     static void __LWBlockViewController__test4_block_dispose_0(struct __LWBlockViewController__test4_block_impl_0*src) {_Block_object_dispose((void*)src->self, 3BLOCK_FIELD_IS_OBJECT);}

     static struct __LWBlockViewController__test4_block_desc_0 {
       size_t reserved;
       size_t Block_size;
       void (*copy)(struct __LWBlockViewController__test4_block_impl_0*, struct __LWBlockViewController__test4_block_impl_0*);
       void (*dispose)(struct __LWBlockViewController__test4_block_impl_0*);
     } __LWBlockViewController__test4_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__test4_block_impl_0), __LWBlockViewController__test4_block_copy_0, __LWBlockViewController__test4_block_dispose_0};

     static void _I_LWBlockViewController_test4(LWBlockViewController * self, SEL _cmd) {
         int age = 10;
         static int height = 100;
         (*(int *)((char *)self + OBJC_IVAR_$_LWBlockViewController$_weight)) = 20;
         gTest = 50;
         void (*block)(int,int) = ((void (*)(int, int))&__LWBlockViewController__test4_block_impl_0((void *)__LWBlockViewController__test4_block_func_0, &__LWBlockViewController__test4_block_desc_0_DATA, age, &height, self, 570425344));
         (*(int *)((char *)self + OBJC_IVAR_$_LWBlockViewController$_weight)) = 30;
         age = 20;
         height = 200;
         gTest = 500;
         ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 30, 320);

     }
     */
    int age = 10;
    static int height = 100;
    _weight = 20;
    gTest = 50;
    void (^block)(int,int) = ^(int a,int b){
        //age的值捕获进来（capture）
        NSLog(@"this is block --age=%d  height=%d  weight=%d gTest=%d",age,height,self->_weight,gTest);//this is block --age=10  height=200  weight=30
    };
    _weight = 30;
    age = 20;
    height = 200;
    gTest = 500;
    block(30,320);
    
}

#pragma mark ------ block内部访问对象的auto变量   栈空间不会持有外部对象person 堆空间会持有外部对象person ------
//__LWBlockViewController__testBlockPerson_block_desc_0  __LWBlockViewController__testBlockPerson_block_impl_0 _Block_object_assign
/*
 访问对象类型
 void (*copy)(struct __LWBlockViewController__testBlockPerson_block_impl_0*, struct __LWBlockViewController__testBlockPerson_block_impl_0*);
 void (*dispose)(struct __LWBlockViewController__testBlockPerson_block_impl_0*);
 
 */
- (void)testBlockPerson1{
    /*
     struct __LWBlockViewController__testBlockPerson_block_impl_0 {
       struct __block_impl impl;
       struct __LWBlockViewController__testBlockPerson_block_desc_0* Desc;
       LWBlockPerson *person;
       __LWBlockViewController__testBlockPerson_block_impl_0(void *fp, struct __LWBlockViewController__testBlockPerson_block_desc_0 *desc, LWBlockPerson *_person, int flags=0) : person(_person) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     static void __LWBlockViewController__testBlockPerson_block_func_0(struct __LWBlockViewController__testBlockPerson_block_impl_0 *__cself) {
       LWBlockPerson *person = __cself->person; // bound by copy

                 NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_55e4dc_mi_5,((int (*)(id, SEL))(void *)objc_msgSend)((id)person, sel_registerName("age")));
             }
     static void __LWBlockViewController__testBlockPerson_block_copy_0(struct __LWBlockViewController__testBlockPerson_block_impl_0*dst, struct __LWBlockViewController__testBlockPerson_block_impl_0*src) {_Block_object_assign((void*)&dst->person, (void*)src->person, 3BLOCK_FIELD_IS_OBJECT);}

     static void __LWBlockViewController__testBlockPerson_block_dispose_0(struct __LWBlockViewController__testBlockPerson_block_impl_0*src) {_Block_object_dispose((void*)src->person, 3BLOCK_FIELD_IS_OBJECT);}

     static struct __LWBlockViewController__testBlockPerson_block_desc_0 {
       size_t reserved;
       size_t Block_size;
       void (*copy)(struct __LWBlockViewController__testBlockPerson_block_impl_0*, struct __LWBlockViewController__testBlockPerson_block_impl_0*);
       void (*dispose)(struct __LWBlockViewController__testBlockPerson_block_impl_0*);
     } __LWBlockViewController__testBlockPerson_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__testBlockPerson_block_impl_0), __LWBlockViewController__testBlockPerson_block_copy_0, __LWBlockViewController__testBlockPerson_block_dispose_0};

     static void _I_LWBlockViewController_testBlockPerson(LWBlockViewController * self, SEL _cmd) {
         LWBlock block;
         {
             LWBlockPerson *person = ((LWBlockPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((LWBlockPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("LWBlockPerson"), sel_registerName("alloc")), sel_registerName("init"));
             ((void (*)(id, SEL, int))(void *)objc_msgSend)((id)person, sel_registerName("setAge:"), 10);
             block = ((void (*)())&__LWBlockViewController__testBlockPerson_block_impl_0((void *)__LWBlockViewController__testBlockPerson_block_func_0, &__LWBlockViewController__testBlockPerson_block_desc_0_DATA, person, 570425344));
         }
         NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_55e4dc_mi_6);
         ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
         NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_55e4dc_mi_7,((Class (*)(id, SEL))(void *)objc_msgSend)((id)block, sel_registerName("class")));
     }
     */
    LWBlock block;
    {
        LWBlockPerson *person = [[LWBlockPerson alloc]init];
        person.age = 10;
        //栈空间不会持有外部对象person 堆空间会持有外部对象person
        block = ^{
            NSLog(@"-------------%d",person.age);
        };
    }
    NSLog(@"-----------");
    block();
    NSLog(@"LWBlockPerson====%@",[block class]);//LWBlockPerson====__NSMallocBlock__
}

- (void)testBlockPerson2{
  /*
   struct __LWBlockViewController__testBlockPerson2_block_impl_0 {
     struct __block_impl impl;
     struct __LWBlockViewController__testBlockPerson2_block_desc_0* Desc;
     LWBlockPerson *__weak weakPerson;
     __LWBlockViewController__testBlockPerson2_block_impl_0(void *fp, struct __LWBlockViewController__testBlockPerson2_block_desc_0 *desc, LWBlockPerson *__weak _weakPerson, int flags=0) : weakPerson(_weakPerson) {
       impl.isa = &_NSConcreteStackBlock;
       impl.Flags = flags;
       impl.FuncPtr = fp;
       Desc = desc;
     }
   };
   static void __LWBlockViewController__testBlockPerson2_block_func_0(struct __LWBlockViewController__testBlockPerson2_block_impl_0 *__cself) {
     LWBlockPerson *__weak weakPerson = __cself->weakPerson; // bound by copy

               NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_1f0a8c_mi_8,((int (*)(id, SEL))(void *)objc_msgSend)((id)weakPerson, sel_registerName("age")));
           }
   static void __LWBlockViewController__testBlockPerson2_block_copy_0(struct __LWBlockViewController__testBlockPerson2_block_impl_0*dst, struct __LWBlockViewController__testBlockPerson2_block_impl_0*src) {_Block_object_assign((void*)&dst->weakPerson, (void*)src->weakPerson, 3/BLOCK_FIELD_IS_OBJECT/);}

   static void __LWBlockViewController__testBlockPerson2_block_dispose_0(struct __LWBlockViewController__testBlockPerson2_block_impl_0*src) {_Block_object_dispose((void*)src->weakPerson, 3/BLOCK_FIELD_IS_OBJECT/);}

   static struct __LWBlockViewController__testBlockPerson2_block_desc_0 {
     size_t reserved;
     size_t Block_size;
     void (*copy)(struct __LWBlockViewController__testBlockPerson2_block_impl_0*, struct __LWBlockViewController__testBlockPerson2_block_impl_0*);
     void (*dispose)(struct __LWBlockViewController__testBlockPerson2_block_impl_0*);
   } __LWBlockViewController__testBlockPerson2_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__testBlockPerson2_block_impl_0), __LWBlockViewController__testBlockPerson2_block_copy_0, __LWBlockViewController__testBlockPerson2_block_dispose_0};

   static void _I_LWBlockViewController_testBlockPerson2(LWBlockViewController * self, SEL _cmd) {

       LWBlock block;
       {
           LWBlockPerson *person = ((LWBlockPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((LWBlockPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("LWBlockPerson"), sel_registerName("alloc")), sel_registerName("init"));
           ((void (*)(id, SEL, int))(void *)objc_msgSend)((id)person, sel_registerName("setAge:"), 10);
           __attribute__((objc_ownership(weak))) LWBlockPerson *weakPerson = person;
           block = ((void (*)())&__LWBlockViewController__testBlockPerson2_block_impl_0((void *)__LWBlockViewController__testBlockPerson2_block_func_0, &__LWBlockViewController__testBlockPerson2_block_desc_0_DATA, weakPerson, 570425344));
       }
       NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_1f0a8c_mi_9);
       ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
       NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_1f0a8c_mi_10,((Class (*)(id, SEL))(void *)objc_msgSend)((id)block, sel_registerName("class")));
   }
   **/
    LWBlock block;
    {
        LWBlockPerson *person = [[LWBlockPerson alloc]init];
        person.age = 10;
        __weak LWBlockPerson *weakPerson = person;
        block = ^{
            NSLog(@"-------------2%d",weakPerson.age);
        };
    }
    NSLog(@"-----------2");
    block();
    NSLog(@"LWBlockPerson====%@",[block class]);//LWBlockPerson====__NSMallocBlock__
}
#pragma mark --__block--
- (void)test__block1{
    /*      __block 修饰符
        __block可以用于解决block内部无法修改auto变量值的问题。
        __block不能修饰全局变量，静态变量
        编辑器会将__block包装成一个对象(__Block_byref_age_0)
     */
    /*
                __block的内存管理
        当block在栈上时，并不会对__block变量产生强引用。
        当block拷贝到堆上时
            1.会调用block内部的copy函数
            2.copy函数内部会调用_Block_object_assign函数
            3._Block_object_assign函数会对__block变量形成强引用。类似于retain
        当block从堆上移除。
         1.会调用block内部的dispose函数
         2.dispose函数会调用内部的_Block_object_dispose函数
         3._Block_object_dispose函数会自动调用释放引用的__block变量，类似于release
     */
    /*
     struct __Block_byref_age_0 {
       void *__isa;
     __Block_byref_age_0 *__forwarding;
      int __flags;
      int __size;
      int age;
     };

     struct __LWBlockViewController__test__block1_block_impl_0 {
       struct __block_impl impl;
       struct __LWBlockViewController__test__block1_block_desc_0* Desc;
       __Block_byref_age_0 *age; // by ref
       __LWBlockViewController__test__block1_block_impl_0(void *fp, struct __LWBlockViewController__test__block1_block_desc_0 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     
     
     static void __LWBlockViewController__test__block1_block_func_0(struct __LWBlockViewController__test__block1_block_impl_0 *__cself) {
       __Block_byref_age_0 *age = __cself->age; // bound by ref

             (age->__forwarding->age) = 20;
             NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_6981ce_mi_11,(age->__forwarding->age));
         }
     
     static void __LWBlockViewController__test__block1_block_copy_0(struct __LWBlockViewController__test__block1_block_impl_0*dst, struct __LWBlockViewController__test__block1_block_impl_0*src) {_Block_object_assign((void*)&dst->age, (void*)src->age, 8/BLOCK_FIELD_IS_BYREF/);}

     static void __LWBlockViewController__test__block1_block_dispose_0(struct __LWBlockViewController__test__block1_block_impl_0*src) {_Block_object_dispose((void*)src->age, 8/BLOCK_FIELD_IS_BYREF/);}

     static struct __LWBlockViewController__test__block1_block_desc_0 {
       size_t reserved;
       size_t Block_size;
       void (*copy)(struct __LWBlockViewController__test__block1_block_impl_0*, struct __LWBlockViewController__test__block1_block_impl_0*);
       void (*dispose)(struct __LWBlockViewController__test__block1_block_impl_0*);
     } __LWBlockViewController__test__block1_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__test__block1_block_impl_0), __LWBlockViewController__test__block1_block_copy_0, __LWBlockViewController__test__block1_block_dispose_0};

     static void _I_LWBlockViewController_test__block1(LWBlockViewController * self, SEL _cmd) {
         __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};
         LWBlock block = ((void (*)())&__LWBlockViewController__test__block1_block_impl_0((void *)__LWBlockViewController__test__block1_block_func_0, &__LWBlockViewController__test__block1_block_desc_0_DATA, (__Block_byref_age_0 *)&age, 570425344));
         ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
     }

     */
    __block int age = 10;
    LWBlock block = ^(){
        age  = 20;
        NSLog(@"age is %d",age);
    };
    block();
    NSLog(@"age -- %p",&age);//外面的age地址是 block结构体里面的__Block_byref_age_0 *age的里面的age 。不是__Block_byref_age_0 *age地址

}
- (void)test__block2{
    /*
     struct __Block_byref_person_1 {
       void *__isa;
     __Block_byref_person_1 *__forwarding;
      int __flags;
      int __size;
      void (*__Block_byref_id_object_copy)(void*, void*);
      void (*__Block_byref_id_object_dispose)(void*);
      LWBlockPerson *__strong person;
     };

     struct __LWBlockViewController__test__block2_block_impl_0 {
       struct __block_impl impl;
       struct __LWBlockViewController__test__block2_block_desc_0* Desc;
       __Block_byref_person_1 *person; // by ref
       __LWBlockViewController__test__block2_block_impl_0(void *fp, struct __LWBlockViewController__test__block2_block_desc_0 *desc, __Block_byref_person_1 *_person, int flags=0) : person(_person->__forwarding) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     static void __LWBlockViewController__test__block2_block_func_0(struct __LWBlockViewController__test__block2_block_impl_0 *__cself) {
       __Block_byref_person_1 *person = __cself->person; // bound by ref

             NSLog((NSString *)&__NSConstantStringImpl__var_folders_8g_b0y7jr490q303x4hgr33q6_40000gn_T_LWBlockViewController_a2e437_mi_13,(person->__forwarding->person));
         }
     static void __LWBlockViewController__test__block2_block_copy_0(struct __LWBlockViewController__test__block2_block_impl_0*dst, struct __LWBlockViewController__test__block2_block_impl_0*src) {_Block_object_assign((void*)&dst->person, (void*)src->person, 8/BLOCK_FIELD_IS_BYREF/);}

     static void __LWBlockViewController__test__block2_block_dispose_0(struct __LWBlockViewController__test__block2_block_impl_0*src) {_Block_object_dispose((void*)src->person, 8/BLOCK_FIELD_IS_BYREF/);}

     static struct __LWBlockViewController__test__block2_block_desc_0 {
       size_t reserved;
       size_t Block_size;
       void (*copy)(struct __LWBlockViewController__test__block2_block_impl_0*, struct __LWBlockViewController__test__block2_block_impl_0*);
       void (*dispose)(struct __LWBlockViewController__test__block2_block_impl_0*);
     } __LWBlockViewController__test__block2_block_desc_0_DATA = { 0, sizeof(struct __LWBlockViewController__test__block2_block_impl_0), __LWBlockViewController__test__block2_block_copy_0, __LWBlockViewController__test__block2_block_dispose_0};

     static void _I_LWBlockViewController_test__block2(LWBlockViewController * self, SEL _cmd) {
         __attribute__((__blocks__(byref))) __Block_byref_person_1 person = {(void*)0,(__Block_byref_person_1 *)&person, 33554432, sizeof(__Block_byref_person_1), __Block_byref_id_object_copy_131, __Block_byref_id_object_dispose_131, ((LWBlockPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((LWBlockPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("LWBlockPerson"), sel_registerName("alloc")), sel_registerName("init"))};
         LWBlock block = ((void (*)())&__LWBlockViewController__test__block2_block_impl_0((void *)__LWBlockViewController__test__block2_block_func_0, &__LWBlockViewController__test__block2_block_desc_0_DATA, (__Block_byref_person_1 *)&person, 570425344));
         ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);

     }
     */
    __block  LWBlockPerson *person = [[LWBlockPerson alloc]init];
    LWBlock block = ^(){
        NSLog(@"LWBlockPerson is %@",person);
    };
    block();
    
}

- (void)circularReferenceTest{
    LWBlockPerson *person = [[LWBlockPerson alloc]init];
    person.age = 10;
    person.block = ^(){
        NSLog(@"LWBlockPerson is %d",person.age);
    };
    
    NSLog(@"=============end");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LWBlockPerson *p = [[LWBlockPerson alloc]init];
//    __weak LWBlockPerson *weakP = p;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)) , dispatch_get_main_queue(), ^{
        NSLog(@"--------%@",p);
//        NSLog(@"--------%@",weakP);
    });
    
}

@end
