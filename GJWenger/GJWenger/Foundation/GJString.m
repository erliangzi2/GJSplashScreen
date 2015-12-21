

#import "GJString.h"
#import <CommonCrypto/CommonDigest.h>   //md5函数需要

@implementation NSString (GJFilePath)

+ (NSString *)gjw_documentPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)gjw_libraryPath
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)gjw_cachesPath
{
    return [[self gjw_libraryPath] stringByAppendingPathComponent:@"Caches"];
}

@end


@implementation NSString (GJEncrypt)

- (NSString *)gjw_md5String
{
    if (self == nil || [self length] == 0) return nil;
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end


@implementation NSString (GJOthers)

+ (NSString *)gjw_stringByJoinA:(NSString *)a and:(NSString *)b with:(NSString *)s
{
    return [NSString stringWithFormat:@"%@%@%@",
            ([a length] ? a: @""),
            ([s length] && [a length] ? s: @""),
            ([b length] ? b: @"")];
}

- (CGSize)gjw_calculateSize:(CGSize)size font:(UIFont *)font {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 20)];
    label.font = font;
    label.text = self;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    return CGSizeMake(ceil([label sizeThatFits:size].width), ceil([label sizeThatFits:size].height));
}

+ (BOOL)gjw_isChineseCharacter:(unichar)character;
{
    return (character >= 0x4e00 && character <= 0x9fff);
}

- (BOOL)gjw_isChineseString;
{
    BOOL isChinese = YES;
    for(NSUInteger i=0; i< [self length];i++){
        unichar a = [self characterAtIndex:i];
        if([NSString gjw_isChineseCharacter:a]) {
            continue;
        } else {
            isChinese = NO;
            break;
        }
    }
    return isChinese;
}

@end

@implementation NSString (GJTrim)

- (NSString *)gjw_trimWhitespaceAndNewline{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end


@implementation NSString (GJNSDecimalCalculation)

- (NSString *)gjw_multipliedByString:(NSString *)number{
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *multiply = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [decimal decimalNumberByMultiplyingBy:multiply];
    return result.stringValue;
}

@end

@implementation NSString (GJAmountAttribute)

- (NSMutableAttributedString *)gjw_amountAttributeIntSize:(NSUInteger)intSize
                                             intColor:(UIColor *)intColor
                                            floatSize:(NSUInteger)floatSize
                                           floatColor:(UIColor *)floatColor {
    return [self gjw_amountAttributeIntFont:[UIFont systemFontOfSize:intSize]
                               intColor:intColor
                              floatFont:[UIFont systemFontOfSize:floatSize]
                             floatColor:floatColor];
}

- (NSMutableAttributedString *)gjw_amountAttributeIntFont:(UIFont *)intFont
                                             intColor:(UIColor *)intColor
                                            floatFont:(UIFont *)floatFont
                                           floatColor:(UIColor *)floatColor {
    NSString *numberStr = [NSString stringWithFormat:@"%.2f",self.doubleValue];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:numberStr];
    NSRange range = [numberStr rangeOfString:@"."];
    NSRange intRange = NSMakeRange(0, range.location + 1);
    NSRange floatRange = NSMakeRange(range.location+1,numberStr.length-range.location-1);
    NSDictionary *attrDic = @{NSFontAttributeName:intFont,
                              NSForegroundColorAttributeName:intColor};
    [attributeStr addAttributes:attrDic range:intRange];
    attrDic = @{NSFontAttributeName:floatFont
                ,NSForegroundColorAttributeName:floatColor};
    [attributeStr addAttributes:attrDic range:floatRange];
    return attributeStr;
}

- (NSMutableAttributedString *)gjw_amountAttributeIntSize:(NSUInteger)intSize
                                             intColor:(UIColor *)intColor
                                            floatSize:(NSUInteger)floatSize
                                           floatColor:(UIColor *)floatColor
                                         suffixString:(NSString *)suffixStr
                                           suffixSize:(NSUInteger)suffixSize
                                          suffixColor:(UIColor *)suffixColor{
    return [self gjw_amountAttributeIntFont:[UIFont systemFontOfSize:intSize]
                               intColor:intColor
                              floatFont:[UIFont systemFontOfSize:floatSize]
                             floatColor:floatColor
                           suffixString:suffixStr
                             suffixFont:[UIFont systemFontOfSize:suffixSize]
                            suffixColor:suffixColor];
}

- (NSMutableAttributedString *)gjw_amountAttributeIntFont:(UIFont *)intFont
                                             intColor:(UIColor *)intColor
                                            floatFont:(UIFont *)floatFont
                                           floatColor:(UIColor *)floatColor
                                         suffixString:(NSString *)suffixStr
                                           suffixFont:(UIFont *)suffixFont
                                          suffixColor:(UIColor *)suffixColor {
    NSMutableAttributedString *attributeStr = [self gjw_amountAttributeIntFont:intFont
                                                                  intColor:intColor
                                                                 floatFont:floatFont
                                                                floatColor:floatColor];
    NSMutableAttributedString *suffixAttriStr = [[NSMutableAttributedString alloc]initWithString:suffixStr];
    NSDictionary *attrDic = @{NSFontAttributeName:suffixFont,
                              NSForegroundColorAttributeName:suffixColor};
    [suffixAttriStr addAttributes:attrDic range:NSMakeRange(0, suffixStr.length)];
    [attributeStr appendAttributedString:suffixAttriStr];
    return attributeStr;
}

@end




