#GJSplashScreen

这是一个显示闪屏图的类库，很多app在启动页之后会显示一个闪屏图，介绍自己app的相关情况，有些是显示广告，我把当前主流闪屏图的功能做成了这个库，希望大家可以使用，有什么问题欢迎大家和我交流：QQ：996993655  email：guoxiaoliang850417@163.com

提供的功能：

- 在一定时间内显示闪屏图，时间可配置。
- 可以选择显示一整张闪屏图，也可以选择显示上面显示内容下面显示logo的闪屏图，如果显示一整张闪屏图，闪屏图是自己服务器配置的；如果显示上面显示内容，上面的内容是服务器配置的，下面的地图是启动图。
- 可以选择闪屏图显示的时候是否有动画（动画形式是渐现）
- 可以选择闪屏图消失的时候动画师渐隐消失，还是渐隐放大消失
- 可以选择闪屏图是否可交互，即点击后显示一个新的介绍页面
- 可以选择是否有数秒倒计时
- 可以选择是否出现跳过按钮
- 如果闪屏图可交互点击后默认以webView加载HTML页面，之前配置urlString即可
- 闪屏图及其url、跳转的url提供缓存策略

闪屏图缓存策略：

- 显示闪屏图与缓存闪屏图的策略是分开的。
- 显示闪屏图只看本地有没有闪屏图文件，有则显示，没有就不显示
- 缓存闪屏图及其url、跳转url的时候是判断服务器传过来的url与我当前保存的是否一致，如果一致则不会替换这些资源，如果不一致则替换资源
- 这一策略会导致显示闪屏图会在缓存闪屏图发生变化的后一次生效

使用方法：

- 如果代码中有调用


 ```
 [self.window makeKeyAndVisible]
 ```

则在此句代码之后调用：


```C
GJSplashScreenOpt opt = GJSplashScreenPart | GJSplashScreenInteractiveEnabled | GJSplashScreenDismissNormalFade | GJSplashScreenShowCountdown | GJSplashScreenShowWithoutAnimation;

[GJSplashScreenWindow gjs_showSplashScreenWithTimeInterval:5 option:opt];
```

注意：显示闪屏图的方法一定要在makeKeyAndVisible之后调用

- 如果代码中没有调用

```
 [self.window makeKeyAndVisible]
 ```
 
 而是通过SB加载的，应该这样写：
 

```
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //如果是SB方式加载显示闪屏图就要放在这里，因为在这个函数中window.keyWindow才是真，而且GJSplashScreenShowWithoutAnimation是必须的选项
    GJSplashScreenOpt opt = GJSplashScreenPart |
              GJSplashScreenInteractiveEnabled |
               GJSplashScreenDismissNormalFade |      
                   GJSplashScreenShowCountdown |
            GJSplashScreenShowWithoutAnimation ;
    
    [GJSplashScreenWindow gjs_showSplashScreenWithTimeInterval:5 option:opt];
}
```
在这里调用也是为了在makeKeyAndVisible之后
 
 
到收到服务器闪屏图相关数据的时候调用：


```
//... 如果通过服务器拿到了闪屏图地址和跳转地址后，调用此方法
[GJSplashScreenWindow gjs_cacheSplashScreenWithResourceURL:@"http://img5.duitang.com/uploads/item/201501/05/20150105184318_w8HPK.jpeg" contentUrl:@"http://baidu.com"];
```
