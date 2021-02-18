//
//  AppDelegate.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/12.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LWSettingLog.h"
#import "LWUncaughtExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
+(void)load{
    NSLog(@"");
}

+ (void)initialize{
    NSLog(@"");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [LWUncaughtExceptionHandler installUncaughtSingalExceptionHandler];
    NSLog(@"程序完成加载");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"程序取消激活状态");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@" 程序进入后台");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"程序进入前台");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"程序被激活");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
