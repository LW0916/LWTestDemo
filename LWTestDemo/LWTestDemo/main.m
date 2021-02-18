//
//  main.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/12.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LWSettingLog.h"

/* 生成c++文件
    xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp
 */
int main(int argc, char * argv[]) {
    NSLog(@"autoreleasepool start argc=%d,argv=%p",argc,argv);
    
    @autoreleasepool {
        NSLog(@"autoreleasepool middle argc=%d,argv=%p",argc,argv);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    NSLog(@"start end autoreleasepool argc=%d,argv=%p",argc,argv);
}
