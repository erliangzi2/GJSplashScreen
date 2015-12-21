//
//  AppDelegate.m
//  GJSplashScreenDemo
//
//  Created by GuoXiaoLiang on 15/12/18.
//  Copyright © 2015年 erliangzi. All rights reserved.
//

#import "AppDelegate.h"
#import "GJSplashScreenWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //... 如果通过服务器拿到了闪屏图地址和跳转地址后，调用此方法
    [GJSplashScreenWindow gjs_cacheSplashScreenWithResourceURL:@"http://img5.pcpop.com/bizhi/big/10/033/753/10033753.jpg" contentUrl:@"http://baidu.com"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //如果是SB方式加载显示闪屏图就要放在这里，因为在这个函数中window.keyWindow才是真，而且GJSplashScreenShowWithoutAnimation是必须的选项
    GJSplashScreenOpt opt = GJSplashScreenPart |
              GJSplashScreenInteractiveEnabled |
               GJSplashScreenDismissNormalFade |
                   GJSplashScreenShowCountdown |
            GJSplashScreenShowWithoutAnimation ;
    
    [GJSplashScreenWindow gjs_showSplashScreenWithTimeInterval:5 option:opt];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
