

#ifndef GJSplashScreenConfig_h
#define GJSplashScreenConfig_h


typedef NS_OPTIONS(NSInteger, GJSplashScreenOpt) {
    /**
     *  闪屏图是一个张图  default
     */
    GJSplashScreenWhole = 1 << 0,
    
    /**
     *  闪屏图分两部分，有个背景层，和展示层，一般背景层和启动图是一样的，像网易新闻那样
     */
    GJSplashScreenPart = 1 << 1,
    
    
    /**
     *  正常渐隐消失  default
     */
    GJSplashScreenDismissNormalFade = 1 << 2,
    
    /**
     *  放大渐隐消失
     */
    GJSplashScreenDismissZoomFade = 1 << 3,
    
    
    /**
     *  闪屏图不可点击交互  default
     */
    GJSplashScreenInteractiveDisabled = 1 << 4,
    
    /**
     *  闪屏图可以点击交互
     */
    GJSplashScreenInteractiveEnabled = 1 << 5,
    
    
    /**
     *  倒计时隐藏  default
     */
    GJSplashScreenHiddenCountdown = 1 << 6,
    
    /**
     *  倒计时显示
     */
    GJSplashScreenShowCountdown = 1 << 7,
    
    
    /**
     *  显示跳过按钮  default
     */
    GJSplashScreenShowSkip = 1 << 8,
    
    /**
     *  隐藏跳过按钮
     */
    GJSplashScreenHiddenSkip = 1 << 9,
    
    /**
     *  闪屏图显示的时候是否有动画，如果AppDelegate中有[self.window makeKeyAndVisible], 那么是可以正常显示动画，如果AppDelegate加载的是SB文件，并没有代码[self.window makeKeyAndVisible]，就不能设置动画，因为，SB的方式如果以动画的方式显示，就会在显示动画的时间间隔内短暂的显示rootController.view, 这时要选择GJSplashScreenShowWithoutAnimation
     *  default
     */
    GJSplashScreenShowWithAnimation = 1 << 10,
    
    /**
     *  如果是用SB加载的，没有手动调用[self.window makeKeyAndVisible]，那么必须选择这个
     */
    GJSplashScreenShowWithoutAnimation = 1 << 11
};

/**
 *  闪屏图出现、消失时的动画时间
 */
static NSTimeInterval const GJSAnimationDuring = .8f;

/**
 *  闪屏图默认显示时长
 */
static NSTimeInterval const GJSDefaultDuring = 2.0f;

/**
 *  如果是GJSplashScreenPart则展示层占整个背景层的比例（0，1]之间取值
 */
static CGFloat const GJSPartRate = .75;

/**
 *  闪屏图的urlStringKey
 */
static NSString *const GJSSplashURLKey = @"gjSplashKey";

/**
 *  点击闪屏图后跳转的页面的urlStringKey
 */
static NSString *const GJSContentURLKey = @"gjContentKey";

#endif
