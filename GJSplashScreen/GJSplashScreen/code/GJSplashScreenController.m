
#import "GJSplashScreenController.h"
#import "GJContentController.h"
#import "GJSplashScreenWindow.h"
#import "GJView.h"
#import "GJImage.h"
#import "GJString.h"
#import "GJDefine.h"
#import "GJColor.h"

@interface GJSplashScreenController ()

@property (nonatomic, assign) GJSplashScreenOpt splashScreenOpt;

@end

@implementation GJSplashScreenController
{
    BOOL _showWhole; //默认整体显示，否则为分两部分显示
    BOOL _normalFade; //默认正常渐隐消失，否则放大渐隐消失
    BOOL _disabled; //默认不可交互的，否则是可交互的
    BOOL _hiddenCountdown;  //默认不显示倒计时，否则显示
    BOOL _showSkip;  //默认显示跳过按钮，否则不显示
    UIImageView *_contentPartView; //如果闪屏图显示是上线分两部分显示的话，这个是上面显示内容的View
    UILabel *_countdownLabel; //显示倒计时的label
    NSTimeInterval _showDuring; //显示时长
}

#pragma mark - life cycle
- (instancetype)initWithTimeInterval:(NSTimeInterval)aTimeInterval opt:(GJSplashScreenOpt)aSplashScreenOpt
{
    if (self = [super init]) {
        self.splashScreenOpt = aSplashScreenOpt;
        _showDuring = (aTimeInterval > 0) ? floor(aTimeInterval) : GJSDefaultDuring;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *splashPath = [[NSString gjw_documentPath] stringByAppendingPathComponent:@"splash"];
    NSString *fileName = [NSString stringWithFormat:@"%@%@", @"splash@", [NSString stringWithFormat:@"%@x.png", [NSNumber numberWithInt:__MainScreen.scale]]];
    NSString *splashFilePath = [splashPath stringByAppendingPathComponent:fileName];
    
    if (_showWhole) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[[UIImage alloc] initWithContentsOfFile:splashFilePath]];
    } else {
        _contentPartView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _contentPartView.gjw_height = self.view.gjw_height * GJSPartRate;
        _contentPartView.backgroundColor = [UIColor redColor];
        _contentPartView.image = [[UIImage alloc] initWithContentsOfFile:splashFilePath];
        [self.view addSubview:_contentPartView];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage gjw_loadLaunchImage]];
    }
    
    if (!_hiddenCountdown) {
        _countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _countdownLabel.backgroundColor = [UIColor gjw_colorWithR:255 G:255 B:255 A:.5];
        _countdownLabel.layer.cornerRadius = 8;
        _countdownLabel.layer.masksToBounds = YES;
        _countdownLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:30];
        _countdownLabel.textColor = [UIColor blackColor];
        _countdownLabel.text = [NSString stringWithFormat:@"%@", @(_showDuring)];
        _countdownLabel.textAlignment = NSTextAlignmentCenter;
        _countdownLabel.gjw_right = __Screen_W - 30;
        _countdownLabel.gjw_top = 30;
        [self.view addSubview:_countdownLabel];
    }
    
    if (_showSkip) {
        UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [skipBtn setFrame:CGRectMake(0, 0, 80, 44)];
        [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [skipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        skipBtn.backgroundColor = [UIColor gjw_colorWithR:255 G:255 B:255 A:.5];
        skipBtn.layer.cornerRadius = 8;
        skipBtn.layer.masksToBounds = YES;
        skipBtn.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22];
        [skipBtn addTarget:self action:@selector(makeDismissAnimation) forControlEvents:UIControlEventTouchUpInside];
        skipBtn.gjw_right = _countdownLabel.gjw_right;
        skipBtn.gjw_bottom = __Screen_H - 30;
        [self.view addSubview:skipBtn];
    }
    
    [self performSelector:@selector(makeDismissAnimation) withObject:nil afterDelay:_showDuring];
    [self performSelector:@selector(changeCountdownLabelText) withObject:nil afterDelay:1];
}

#pragma mark - private methods
- (void)makeDismissAnimation
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

- (void)changeCountdownLabelText
{
    NSTimeInterval tempInterval = [_countdownLabel.text doubleValue] - 1;
    if (tempInterval >= 0) {
        _countdownLabel.text = [NSString stringWithFormat:@"%@", @(tempInterval)];
        [self performSelector:@selector(changeCountdownLabelText) withObject:nil afterDelay:1];
    }
}

#pragma mark - property methods
- (void)setSplashScreenOpt:(GJSplashScreenOpt)splashScreenOpt
{
    _showWhole = YES;
    _normalFade = YES;
    _disabled = YES;
    _hiddenCountdown = YES;
    _showSkip = YES;
    if (splashScreenOpt & (1 << 1)) {
        _showWhole = NO;
    }
    if (splashScreenOpt & (1 << 3)) {
        _normalFade = NO;
    }
    if (splashScreenOpt & (1 << 5)) {
        _disabled = NO;
    }
    if (splashScreenOpt & (1 << 7)) {
        _hiddenCountdown = NO;
    }
    if (splashScreenOpt & (1 << 9)) {
        _showSkip = NO;
    }
}

#pragma mark - others
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_disabled) {
        GJContentController *contentVC = [[GJContentController alloc] initWithNormalFade:_normalFade];
        [self.navigationController pushViewController:contentVC animated:YES];
    }
}

@end
