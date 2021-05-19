//
//  LWRuntimePersonTest.m
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import "LWRuntimePersonTest.h"


// 掩码 一般用来按位与（&）运算的
//#define LWTallMask 1
//#define LWRichMask 2
//#define LWHandsomeMask 4

//#define LWTallMask 0b00000001
//#define LWRichMask 0b00000010
//#define LWHandsomeMask 0b00000100

#define LWTallMask (1<<0)
#define LWRichMask (1<<1)
#define LWHandsomeMask (1<<2)

@interface LWRuntimePersonTest ()
{
    char _tallRichHandsome;//0b 0000 0011
}
@end

@implementation LWRuntimePersonTest

- (instancetype)init{
    if (self = [super init]) {
        _tallRichHandsome = 0b00000011;
    }
    return self;
}
- (void)setTall:(BOOL)tall{
    if(tall){
        _tallRichHandsome |= LWTallMask;
    }else{
        _tallRichHandsome &= ~LWTallMask;
    }
 }

- (void)setRich:(BOOL)rich{
    if(rich){
        _tallRichHandsome |= LWRichMask;
    }else{
        _tallRichHandsome &= ~LWRichMask;
    }
}

- (void)setHandsome:(BOOL)handsome{
    if(handsome){
        _tallRichHandsome |= LWHandsomeMask;
    }else{
        _tallRichHandsome &= ~LWHandsomeMask;
    }
}

- (BOOL)isTall{
    return  !!(_tallRichHandsome & LWTallMask) ;
}

- (BOOL)isRich{
    return !!(_tallRichHandsome & LWRichMask);
}

- (BOOL)isHandsome{
    return !!(_tallRichHandsome & LWHandsomeMask);
}

@end
