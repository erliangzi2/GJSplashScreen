/*!
 @header     GJContentController.h
 @abstract   点击闪屏图后显示具体内容的VC
 @discussion 默认是加载WebView进行显示
 @author     guoxiaoliang850417@163.com
 */

#import <UIKit/UIKit.h>

@interface GJContentController : UIViewController

- (instancetype)initWithNormalFade:(BOOL)aFlag;

@end
