/*!
 @header     GJView.h
 @abstract   UIView的Category
 @discussion UIView的Category
 @author     guoxiaoliang850417@163.com
 */

#import <UIKit/UIKit.h>

@interface UIView (GJOriginAndSize)

@property (nonatomic, assign) CGFloat gjw_top;
@property (nonatomic, assign) CGFloat gjw_left;
@property (nonatomic, assign) CGFloat gjw_bottom;
@property (nonatomic, assign) CGFloat gjw_right;
@property (nonatomic, assign) CGFloat gjw_centerX;
@property (nonatomic, assign) CGFloat gjw_centerY;
@property (nonatomic, assign) CGFloat gjw_width;
@property (nonatomic, assign) CGFloat gjw_height;

@end

//=====================================================

@interface UIView (GJRendered)

/**
 *  将View渲染成图片
 */
- (UIImage *)gjw_renderImage;

/**
 *  将View的某个区域渲染成图片
 */
- (UIImage *)gjw_renderImageInRect:(CGRect)aRect;

/**
 *  将View渲染成图片并写入文件
 */
- (BOOL)gjw_renderImageAndSaveToFileWithFilePath:(NSString *)aFilePath;

@end