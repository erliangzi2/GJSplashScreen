/*!
 @header     GJSplashScreenWindow.h
 @abstract   显示闪屏图的Window
 @discussion 显示后台可配置的图片,内部有图片下载缓存的策略
 @author     guoxiaoliang850417@163.com
 */

#import <UIKit/UIKit.h>
#import "GJSplashScreenConfig.h"

@interface GJSplashScreenWindow : UIWindow

/**
 *  闪屏图显示的调用方法，这个函数一定要在[self.window makeKeyAndVisible]后调
    
 *  在application: didFinishLaunchingWithOptions:方法中调用了[self.window makeKeyAndVisible]后调用该函数，如果是用SB加载的没有手动调用[self.window makeKeyAndVisible]函数的话，可以在applicationDidBecomeActive:函数中调用，此时opt中一定要选择GJSplashScreenShowWithoutAnimation这个选项
 *  @param aTimeInterval 闪屏图显示时长
 *  @param aOpt          闪屏图可配置选项，具体看GJSplashScreenOpt定义
 */
+ (void)gjs_showSplashScreenWithTimeInterval:(NSTimeInterval)aTimeInterval option:(GJSplashScreenOpt)aOpt;

/**
 *  缓存闪屏图数据
 *  @param aUrlStr     闪屏图图片对应的url的字符串
 *  @param aContentUrl 闪屏图点击后显示内容的url的字符串
 */
+ (void)gjs_cacheSplashScreenWithResourceURL:(NSString *)aUrlStr contentUrl:(NSString *)aContentUrl;

/**
 *  使用的时无需调用此函数
 */
+ (void)gjs_cleanWindow;

@end
