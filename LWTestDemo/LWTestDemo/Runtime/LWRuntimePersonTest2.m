//
//  LWRuntimePersonTest2.m
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import "LWRuntimePersonTest2.h"


@interface LWRuntimePersonTest2 ()
{
    // char _tallRichHandsome;
//    位域 占一位 不是一个字节
    struct{
        char tall:1;
        char rich:1;
        char handsome:1;
        
    }_tallRichHandsome;// 0b0000 0000
}
@end

@implementation LWRuntimePersonTest2


- (void)setTall:(BOOL)tall{
    _tallRichHandsome.tall = tall;
 }

- (void)setRich:(BOOL)rich{
    _tallRichHandsome.rich = rich;
}

- (void)setHandsome:(BOOL)handsome{
    _tallRichHandsome.handsome = handsome;
}

- (BOOL)isTall{
    return  !!_tallRichHandsome.tall;
}

- (BOOL)isRich{
    return !!_tallRichHandsome.rich;
}

- (BOOL)isHandsome{
    return !!_tallRichHandsome.handsome;
}

@end
