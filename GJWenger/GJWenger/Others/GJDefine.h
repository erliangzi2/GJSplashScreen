/*!
 @header     GJDefine.h
 @abstract   公共的define声明
 @discussion 公共的define声明
 @author     guoxiaoliang850417@163.com
 */

#ifndef GJLib_GJDefine_h
#define GJLib_GJDefine_h

//UI
#define __Width_3_5                   320
#define __Height_3_5                  480
#define __Width_4_0                   320
#define __Height_4_0                  568
#define __Width_4_7                   375
#define __Height_4_7                  667
#define __Width_5_5                   414
#define __Height_5_5                  736
#define __Nav_H                       44
#define __Tab_H                       49
#define __StatusBar_H                 20
#define __StatusNav_H                 (__StatusBar_H + __Nav_H)
#define __Screen_W                    (__MainScreen.bounds.size.width)
#define __Screen_H                    (__MainScreen.bounds.size.height)

/*!
 5.5寸设备有两种显示模式：
 1.标准(高736) 2.放大(高667)
 */
#define _POINT_HEIGHT_5_5_STANDARD    736
#define _POINT_HEIGHT_5_5_ZOOMED      667


//系统单例
#define __SharedApplication                ([UIApplication sharedApplication])
#define __AppDelegate                      ([__SharedApplication delegate])
#define __AppDelegateWindow                (__AppDelegate.window)
#define __AppDelegateWindowRootController  __AppDelegate.window.rootViewController
#define __MainScreen                       [UIScreen mainScreen]
#define __CurrentDevice                    [UIDevice currentDevice]
#define __StandardUserDefaults             [NSUserDefaults standardUserDefaults]
#define __MainBundle                       [NSBundle mainBundle]
#define __DefaultCenter                    [NSNotificationCenter defaultCenter]
#define __CurrentDevice                    [UIDevice currentDevice]
#define __KeyWindow                        [__SharedApplication keyWindow]
#define __AppFrame                         [__MainScreen applicationFrame]  //{{0, 20}, {320, 460}}
#define __ScreenBounds                     [__MainScreen bounds]            //{{0, 0}, {320, 480}}
#define __DefaultFileManager               [NSFileManager defaultManager]
#define __CurrentCalendar                  [NSCalendar currentCalendar]


//Convert
#define __I2S(i)                      [NSString stringWithFormat:@"%d", i]
#define __F2S(f)                      [NSString stringWithFormat:@"%f", f]

#define __I2N(i)                      [NSNumber numberWithInt:i]
#define __F2N(f)                      [NSNumber numberWithFloat:f]
#define __D2N(d)                      [NSNumber numberWithDouble:d]
#define __B2N(b)                      [NSNumber numberWithBool:b]

#define __P2V(p)                      [NSValue valueWithCGPoint:p]
#define __S2V(s)                      [NSValue valueWithCGSize:s]
#define __R2V(r)                      [NSValue valueWithCGRect:r]
#define __RA2V(r)                     [NSValue valueWithRange:r]
#define __AT2V(t)                     [NSValue valueWithCGAffineTransform:t]
#define __CT2V(t)                     [NSValue valueWithCATransform3D:t]

#define __D2R(d)                      (d * M_PI / 180.0)
#define __R2D(r)                      (r * 180 / M_PI)

#define __LS(s)                        NSLocalizedString(s, nil)
#define __URL(s)                      [NSURL URLWithString:s]
#define __Null                        [NSNull null]

#define __RectMinPoint(r)             CGPointMake(CGRectGetMinX(r), CGRectGetMinY(r))
#define __RectMidPoint(r)             CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r))
#define __RectMaxPoint(r)             CGPointMake(CGRectGetMaxX(r), CGRectGetMaxY(r))

#define __Distance(p1, p2)            sqrtf((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y))
#define __PointAdd(p, ox, oy)         CGPointMake(p.x + ox, p.y + oy)


//GCD
#define __MainGCDQueue                dispatch_get_main_queue()
#define __DefaultGCDQueue             dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


//Utilities
#define __ResourcePath(name, type)    [__MainBundle pathForResource:name ofType:type]
#define __LoadNibNamed(name)          [[__MainBundle loadNibNamed:name owner:nil options:nil] lastObject]
#define __InfoValueForKey(k)          [__MainBundle objectForInfoDictionaryKey:k]
#define __IndexPath(r, s)             [NSIndexPath indexPathForRow:r inSection:s]
#define __Image(name)                 [UIImage imageNamed:@"name"]
#define __ParamsAssert(condition)      NSAssert(condition, [NSString stringWithUTF8String:__FUNCTION__])


//网络状态判断
#define __IsWifiConnected     \
([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi)
#define __IsWWANConnected     \
([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN)
#define __IsNetWorkConnected  \
(__IsWifiConnected || __IsWWANConnected)

typedef void(^GJSimpleBlock)();
typedef void(^GJBoolBlock)(BOOL flag);
typedef void(^GJIntegerBlock)(NSInteger index);
typedef void(^GJFloatBlock)(float value);
typedef void(^GJDoubleBlock)(double value);
typedef void(^GJStringBlock)(NSString *title);
typedef void(^GJArrBlock)(NSArray *arr);
typedef void(^GJDicBlock)(NSDictionary *dic);
typedef void(^GJIDBlock)(id obj);

typedef void(^GJBoolIDBlock)(BOOL flag, id obj);
typedef void(^GJBoolDicBlick)(BOOL flag, NSDictionary *dic);
typedef void(^GJBoolStringBlock)(BOOL flag, NSString *tipString);

/**
 *  定义一个常用的判断字符串不为nil也不是空的判断
 */

#define __stringIsUseful(string)   (string && ![string isEqualToString:@""])

#endif
