

#import "GJImage.h"
#import "GJDevice.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)gjw_imageWithColor:(UIColor *)aColor
{    
    return [self gjw_imageWithColor:aColor size:CGSizeMake(1, 1)];
}

+ (UIImage *)gjw_imageWithColor:(UIColor *)aColor size:(CGSize)aSize
{
    UIGraphicsBeginImageContext(aSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, aSize.width, aSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  代码加载启动图：
 iOS5,6	3.5inch	LaunchImage
 iOS5,6	3.5inch Retina	LaunchImage@2x
 iOS5,6	4.0inch Retina	LaunchImage-568h@2x
 iOS7,8	3.5inch Retina	LaunchImage-700@2x
 iOS7,8	4.0inch Retina	LaunchImage-700-568h@2x
 iOS8	4.7inch Retina	LaunchImage-800-667h@2x
 iOS8	5.5inch Retina Portrait	LaunchImage-800-Portrait-736h@3x
 iOS8	5.5inch Retina Landscape	LaunchImage-800-Landscape-736h@3x
 */

+ (UIImage *)gjw_loadLaunchImage
{
    if ([UIDevice gjw_is3_5_iPhone]) {
        return [UIImage imageNamed:@"LaunchImage-700@2x"];
    } else if ([UIDevice gjw_is4_0_iPhone]) {
        return [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    } else if ([UIDevice gjw_is4_7_iPhone]) {
        return [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    } else if ([UIDevice gjw_is5_5_iPhone]) {
        return [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else return nil;
}

@end
