
#import "GJSplashScreenWindow.h"
#import "GJSplashScreenController.h"
#import "GJDefine.h"
#import "GJString.h"

static GJSplashScreenWindow *aSplashWindow;

@implementation GJSplashScreenWindow
{
    BOOL _showWithAnimation;
}

#pragma mark - public methods
+ (void)gjs_showSplashScreenWithTimeInterval:(NSTimeInterval)aTimeInterval option:(GJSplashScreenOpt)aOpt
{
    static dispatch_once_t onceToken;
    NSString *splashPath = [[NSString gjw_documentPath] stringByAppendingPathComponent:@"splash"];
    NSString *fileName = [NSString stringWithFormat:@"%@%@", @"splash@", [NSString stringWithFormat:@"%@x.png", [NSNumber numberWithInt:__MainScreen.scale]]];
    NSString *splashFilePath = [splashPath stringByAppendingPathComponent:fileName];
    dispatch_once(&onceToken, ^{
        aSplashWindow = [[GJSplashScreenWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        aSplashWindow->_showWithAnimation = YES;
        if (aOpt & (1 << 11)) {
            aSplashWindow->_showWithAnimation = NO;
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[GJSplashScreenController alloc] initWithTimeInterval:aTimeInterval opt:aOpt]];
        nav.navigationBarHidden = YES;
        aSplashWindow.rootViewController = nav;
        //在doucuments下创建装闪屏图的文件夹
        if (![__DefaultFileManager fileExistsAtPath:splashPath]) {
            [__DefaultFileManager createDirectoryAtPath:splashPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    });
    
    //如果有闪屏图，显示闪屏图，否则不显示
    if ([__DefaultFileManager fileExistsAtPath:splashFilePath]) {
        aSplashWindow.alpha = .0f;
        [aSplashWindow makeKeyAndVisible];
        [aSplashWindow p_makeShowAnimation];
    }
}

+ (void)gjs_cacheSplashScreenWithResourceURL:(NSString *)aUrlStr contentUrl:(NSString *)aContentUrl
{
    if (aUrlStr.length > 0) {
        NSString *splashPath = [[NSString gjw_documentPath] stringByAppendingPathComponent:@"splash"];
        NSString *fileName = [NSString stringWithFormat:@"%@%@", @"splash@", [NSString stringWithFormat:@"%@x.png", [NSNumber numberWithInt:__MainScreen.scale]]];
        NSString *splashFilePath = [splashPath stringByAppendingPathComponent:fileName];
        NSString *urlStr = [__StandardUserDefaults stringForKey:GJSSplashURLKey];
        if ((!urlStr && aUrlStr) || (urlStr && aUrlStr && ![urlStr isEqualToString:aUrlStr])) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithURL:[NSURL URLWithString:aUrlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error) {
                    if ([data writeToFile:splashFilePath atomically:YES]) {
                        [__StandardUserDefaults setObject:aUrlStr forKey:GJSSplashURLKey];
                    }
                }
            }] resume];
        }
    }
    
    if (aContentUrl.length > 0) {
        NSString *contentUrlStr = [__StandardUserDefaults stringForKey:GJSContentURLKey];
        if ((!contentUrlStr && aContentUrl) || (contentUrlStr && aContentUrl && ![contentUrlStr isEqualToString:aContentUrl])) {
            [__StandardUserDefaults setObject:aContentUrl forKey:GJSContentURLKey];
        }
    }
}

+ (void)gjs_cleanWindow
{
    if (aSplashWindow) {
        aSplashWindow.rootViewController = nil;
        aSplashWindow = nil;
    }
}

#pragma mark - private methods
- (void)p_makeShowAnimation
{
    if (self->_showWithAnimation) {
        [UIView animateWithDuration:GJSAnimationDuring animations:^{
            aSplashWindow.alpha = 1.0f;
        }];
    } else {
        aSplashWindow.alpha = 1.0f;
    }
}

@end
