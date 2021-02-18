//
//  LWUncaughtExceptionHandler.h
//  LWTestDemo
//
//  Created by linwei on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LWUncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}
+ (void)installUncaughtSingalExceptionHandler;
+ (NSArray *)backtrace;
@end

NS_ASSUME_NONNULL_END
