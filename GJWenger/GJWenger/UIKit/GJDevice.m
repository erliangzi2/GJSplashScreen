

#import "GJDevice.h"
#import <AdSupport/ASIdentifierManager.h>
#include <sys/sysctl.h>
#import "GJString.h"
#import "GJDefine.h"

static NSString *const KSimulatorDevice = @"Simulator";
static NSDateFormatter * openUDIDFormatter;

//=====================================================

@implementation UIDevice (Hardware)

+ (NSString *)gjw_deviceCode
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *)gjw_deviceName
{
    NSString *platform = [self gjw_deviceCode];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev A)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi/Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi/Cellular)";
    if ([platform isEqualToString:@"i386"])         return KSimulatorDevice;
    if ([platform isEqualToString:@"x86_64"])       return KSimulatorDevice;
    return platform;
}

+ (NSString *)gjw_screenSize
{
    NSString *screenSize = @"3.5";
    if ([self gjw_is4_0_iPhone]) {
        screenSize = @"4.0";
    } else if ([self gjw_is4_7_iPhone]) {
        screenSize = @"4.7";
    } else if ([self gjw_is5_5_iPhone]) {
        screenSize = @"5.5";
    }
    return screenSize;
}

@end

//=====================================================

@implementation UIDevice (Software)

+ (NSString *)gjw_uuidForAD
{
    static NSString *uuidStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uuidStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    });
    return uuidStr;
}

+ (NSString *)gjw_uuidForVendor
{
    static NSString *uuidStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uuidStr = [[__CurrentDevice identifierForVendor] UUIDString];
    });
    return uuidStr;
}

+ (NSString *)gjw_appVersion
{
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[[__MainBundle infoDictionary] objectForKey:@"CFBundleShortVersionString"] copy];
    });
    return appVersion;
}

+ (NSString *)gjw_appBuild
{
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [__MainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    });
    return appVersion;
}

+ (NSString *)gjw_appVersion_Build
{
    static NSString *appVersion_Build;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion_Build = [[NSString stringWithFormat:@"%@.%@", [self gjw_appVersion], [self gjw_appBuild]] copy];
    });
    return appVersion_Build;
}

+ (NSString *)gjw_appProjectName
{
    static NSString *appProjectName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appProjectName = [[__MainBundle infoDictionary] objectForKey:@"CFBundleName"];
    });
    return appProjectName;
}

+ (NSString *)gjw_iOSVersion
{
    static NSString *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [__CurrentDevice systemVersion];
    });
    return systemVersion;
}

@end

//=====================================================

@implementation UIDevice (Judgement)

+ (BOOL)gjw_isIphone
{
    static BOOL isIphone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    });
    return isIphone;
}

+ (BOOL)gjw_isIpad
{
    static BOOL isIpad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIpad = [__CurrentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    });
    return isIpad;
}

//-----------------------------------------------

+ (BOOL)gjw_is3_5_iPhone
{
    static BOOL is;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        is = ([self gjw_isIphone] && (__Screen_W == __Width_3_5 && __Screen_H == __Height_3_5));
    });
    return is;
}

+ (BOOL)gjw_is4_0_iPhone
{
    static BOOL is;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        is = ([self gjw_isIphone] && (__Screen_W == __Width_4_0 && __Screen_H == __Height_4_0));
    });
    return is;
}

+ (BOOL)gjw_is4_7_iPhone
{
    static BOOL is;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        is = ([self gjw_isIphone] && (__Screen_W == __Width_4_7 && __Screen_H == __Height_4_7));
    });
    return is;
}

+ (BOOL)gjw_is5_5_iPhone
{
    static BOOL is;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        is = ([self gjw_isIphone] && (__Screen_W == __Width_5_5 && __Screen_H == __Height_5_5));
    });
    return is;
}

//-----------------------------------------------

+ (BOOL)gjw_isIOS7
{
    static BOOL isIOS7;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS7 = ([[self gjw_iOSVersion] floatValue] >= 7.0 && [[self gjw_iOSVersion] floatValue] < 8.0);
    });
    return isIOS7;
}

+ (BOOL)gjw_isIOS8
{
    static BOOL isIOS8;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS8 = ([[self gjw_iOSVersion] floatValue] >= 8.0 && [[self gjw_iOSVersion] floatValue] < 9.0);
    });
    return isIOS8;
}

+ (BOOL)gjw_isIOS9
{
    static BOOL isIOS9;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS9 = ([[self gjw_iOSVersion] floatValue] >= 9.0 && [[self gjw_iOSVersion] floatValue] < 10.0);
    });
    return isIOS9;
}

//-----------------------------------------------

+ (BOOL)gjw_isIOS7OrLater
{
    static BOOL isIOS7OrLater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS7OrLater = ([[self gjw_iOSVersion] floatValue] >= 7.0);
    });
    return isIOS7OrLater;
}

+ (BOOL)gjw_isIOS8OrLater
{
    static BOOL isIOS8OrLater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS8OrLater = ([[self gjw_iOSVersion] floatValue] >= 8.0);
    });
    return isIOS8OrLater;
}

+ (BOOL)gjw_isIOS9OrLater
{
    static BOOL isIOS9OrLater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS9OrLater = ([[self gjw_iOSVersion] floatValue] >= 9.0);
    });
    return isIOS9OrLater;
}

@end


