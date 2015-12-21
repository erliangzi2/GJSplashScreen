/*!
 @header     GJString.h
 @abstract   NSString的Category
 @discussion NSString的Category
 @author     guoxiaoliang850417@163.com
 */



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (GJFilePath)

//路径相关
+ (NSString *)gjw_documentPath;
+ (NSString *)gjw_libraryPath;
+ (NSString *)gjw_cachesPath;

@end

@interface NSString (GJEncrypt)

//编码、加密相关
- (NSString *)gjw_md5String;

@end




@interface NSString (GJOthers)

/**
 *  用s连接a和b
 */
+ (NSString *)gjw_stringByJoinA:(NSString *)a and:(NSString *)b with:(NSString *)s;

/**
 *  根据字体算字符占用空间的大小
 */
- (CGSize)gjw_calculateSize:(CGSize)size font:(UIFont *)font;

/**
 *  判断字符是否为中文字符
 */
+ (BOOL)gjw_isChineseCharacter:(unichar)character;

/**
 *  判断字符串是否为中文字符串
 */
- (BOOL)gjw_isChineseString;

@end

@interface NSString (GJTrim)

/**
 *  去掉空格和换行
 */
- (NSString *)gjw_trimWhitespaceAndNewline;

@end


@interface NSString (GJNSDecimalCalculation)

/**
 * 乘法计算
 */
- (NSString *)gjw_multipliedByString:(NSString *)number;

@end

@interface NSString (GJAmountAttribute)

/**
 * 对字符进行2位小数处理，以及小数整数部分颜色区分，外加单位
 */

- (NSMutableAttributedString *)gjw_amountAttributeIntSize:(NSUInteger)intSize
                                                 intColor:(UIColor *)intColor
                                                floatSize:(NSUInteger)floatSize
                                               floatColor:(UIColor *)floatColor;

- (NSMutableAttributedString *)gjw_amountAttributeIntFont:(UIFont *)intFont
                                                 intColor:(UIColor *)intColor
                                                floatFont:(UIFont *)floatFont
                                               floatColor:(UIColor *)floatColor;

- (NSMutableAttributedString *)gjw_amountAttributeIntSize:(NSUInteger)intSize
                                                 intColor:(UIColor *)intColor
                                                floatSize:(NSUInteger)floatSize
                                               floatColor:(UIColor *)floatColor
                                             suffixString:(NSString *)suffixStr
                                               suffixSize:(NSUInteger)suffixSize
                                              suffixColor:(UIColor *)suffixColor;

- (NSMutableAttributedString *)gjw_amountAttributeIntFont:(UIFont *)intFont
                                                 intColor:(UIColor *)intColor
                                                floatFont:(UIFont *)floatFont
                                               floatColor:(UIColor *)floatColor
                                             suffixString:(NSString *)suffixStr
                                               suffixFont:(UIFont *)suffixFont
                                              suffixColor:(UIColor *)suffixColor;

@end