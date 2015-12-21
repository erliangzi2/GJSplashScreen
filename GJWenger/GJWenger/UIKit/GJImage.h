
/*!
 @header     GJImage.h
 @abstract   UIImage的Category
 @discussion UIImage的Category
 @author     guoxiaoliang850417@163.com
 */

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)

/**
 *  用color生成一个size为{1, 1}的image
 */
+ (UIImage *)gjw_imageWithColor:(UIColor *)aColor;

/**
 *  用color生成一个image，size自己指定
 */
+ (UIImage *)gjw_imageWithColor:(UIColor *)aColor size:(CGSize)aSize;

/**
 *  代码加载启动图：只支持iPhone竖屏和iOS7及其之后的系统
 */
+ (UIImage *)gjw_loadLaunchImage;


@end
