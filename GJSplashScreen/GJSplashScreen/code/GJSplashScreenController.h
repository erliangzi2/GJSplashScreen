/*!
 @header     GJSplashScreenController.h
 @abstract   显示闪屏图的VC
 @discussion 显示闪屏图的VC
 @author     guoxiaoliang850417@163.com
 */

#import <UIKit/UIKit.h>
#import "GJSplashScreenConfig.h"

@interface GJSplashScreenController : UIViewController

- (instancetype)initWithTimeInterval:(NSTimeInterval)aTimeInterval opt:(GJSplashScreenOpt)aSplashScreenOpt;

@end
