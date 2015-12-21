
#import "GJContentController.h"
#import "GJSplashScreenConfig.h"
#import "GJSplashScreenWindow.h"
#import "GJDefine.h"

@interface GJContentController ()<UIWebViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation GJContentController
{
    BOOL _normalFade;
    __unsafe_unretained IBOutlet UIActivityIndicatorView *_webViewIndicator;
}

#pragma mark - life cycle
- (instancetype)initWithNormalFade:(BOOL)aFlag
{
    if (self = [super init]) {
        _normalFade = aFlag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *loadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[__StandardUserDefaults objectForKey:GJSContentURLKey]]];
    [self.contentWebView loadRequest:loadRequest];
}

#pragma mark - IBAction methods
- (IBAction)dismissHandle:(id)sender
{
    if ([__KeyWindow isKindOfClass:[GJSplashScreenWindow class]]) {
        [UIView animateWithDuration:GJSAnimationDuring animations:^{
            __KeyWindow.alpha = .0f;
            if (!_normalFade) {
                __KeyWindow.transform = CGAffineTransformMakeScale(1.5, 1.5);
            }
        } completion:^(BOOL finished) {
            [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
            [GJSplashScreenWindow gjs_cleanWindow];
        }];
    }
}

#pragma mark - webView delegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_webViewIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_webViewIndicator stopAnimating];
}

@end
