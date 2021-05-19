//
//  LWRuntimePersonTest3.m
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import "LWRuntimePersonTest3.h"


#define LWTallMask (1<<0)
#define LWRichMask (1<<1)
#define LWHandsomeMask (1<<2)

@interface LWRuntimePersonTest3 ()
{
    // char _tallRichHandsome;
//    位域 占一位 不是一个字节
    union{
        char bits;
//        struct{
//            char tall:1;
//            char rich:1;
//            char handsome:1;
//        };
    }_tallRichHandsome;// 0b0000 0000
}
@end

@implementation LWRuntimePersonTest3

- (void)setTall:(BOOL)tall{
    if(tall){
        _tallRichHandsome.bits |= LWTallMask;
    }else{
        _tallRichHandsome.bits &= ~LWTallMask;
    }
 }

- (void)setRich:(BOOL)rich{
    if(rich){
        _tallRichHandsome.bits |= LWRichMask;
    }else{
        _tallRichHandsome.bits &= ~LWRichMask;
    }
}

- (void)setHandsome:(BOOL)handsome{
    if(handsome){
        _tallRichHandsome.bits |= LWHandsomeMask;
    }else{
        _tallRichHandsome.bits &= ~LWHandsomeMask;
    }
}

- (BOOL)isTall{
    return  !!(_tallRichHandsome.bits & LWTallMask) ;
}

- (BOOL)isRich{
    return !!(_tallRichHandsome.bits & LWRichMask);
}

- (BOOL)isHandsome{
    return !!(_tallRichHandsome.bits & LWHandsomeMask);
}

@end
