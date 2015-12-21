/*!
 @header     GJDevice.h
 @abstract   UIDevice的Category
 @discussion UIDevice的Category
 @author     guoxiaoliang850417@163.com
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//=====================================================

@interface UIDevice (Hardware)

/**
 * 设备代号,eg:iPhone5,3
 */
+ (NSString *)gjw_deviceCode;

/**
 * 设备名称,eg:iPhone 5C (GSM)
 */
+ (NSString *)gjw_deviceName;

/**
 *  设备尺寸
 *  @return @"3.5"、@"4.0"、@"4.7"、@"5.5"
 */
+ (NSString *)gjw_screenSize;

@end

//=====================================================

@interface UIDevice (Software)

/**
 *  广告唯一标识
 */
+ (NSString *)gjw_uuidForAD;

/**
 *  Vendor唯一标识
 */
+ (NSString *)gjw_uuidForVendor;

/**
 *  version:targets->General->Identity->Version里的值,eg:1.0
 */
+ (NSString *)gjw_appVersion;

/**
 *  build:targets->General->Identity->Build里的值,eg:1
 */
+ (NSString *)gjw_appBuild;

/**
 *  version.build eg:version:1.0  build:1 =>  1.0.1
 */
+ (NSString *)gjw_appVersion_Build;

/**
 *  工程名
 */
+ (NSString *)gjw_appProjectName;

/**
 *  iOS版本号
 */
+ (NSString *)gjw_iOSVersion;

@end

//=====================================================

@interface UIDevice (Judgement)

+ (BOOL)gjw_isIphone;
+ (BOOL)gjw_isIpad;

+ (BOOL)gjw_is3_5_iPhone;
+ (BOOL)gjw_is4_0_iPhone;
+ (BOOL)gjw_is4_7_iPhone;
+ (BOOL)gjw_is5_5_iPhone;

+ (BOOL)gjw_isIOS7;
+ (BOOL)gjw_isIOS8;
+ (BOOL)gjw_isIOS9;

+ (BOOL)gjw_isIOS7OrLater;
+ (BOOL)gjw_isIOS8OrLater;
+ (BOOL)gjw_isIOS9OrLater;

@end


