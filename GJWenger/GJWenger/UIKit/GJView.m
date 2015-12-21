

#import "GJView.h"

@implementation UIView (GJOriginAndSize)


- (CGFloat)gjw_top
{
    return self.frame.origin.y;
}

- (void)setGjw_top:(CGFloat)gjw_top
{
    CGRect tmpRect = self.frame;
    tmpRect.origin.y = gjw_top;
    self.frame = tmpRect;
}

- (CGFloat)gjw_left
{
    return self.frame.origin.x;
}

- (void)setGjw_left:(CGFloat)gjw_left
{
    CGRect tmpRect = self.frame;
    tmpRect.origin.x = gjw_left;
    self.frame = tmpRect;
}

- (CGFloat)gjw_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setGjw_bottom:(CGFloat)gjw_bottom
{
    CGRect tmpRect = self.frame;
    tmpRect.origin.y = gjw_bottom - self.frame.size.height;
    self.frame = tmpRect;
}

- (CGFloat)gjw_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setGjw_right:(CGFloat)gjw_right
{
    CGRect tmpRect = self.frame;
    tmpRect.origin.x = gjw_right - self.frame.size.width;
    self.frame = tmpRect;
}

- (CGFloat)gjw_centerX
{
    return self.center.x;
}

- (void)setGjw_centerX:(CGFloat)gjw_centerX
{
    CGPoint tmpPoint = self.center;
    tmpPoint.x = gjw_centerX;
    self.center = tmpPoint;
}


- (CGFloat)gjw_centerY
{
    return self.center.y;
}

- (void)setGjw_centerY:(CGFloat)gjw_centerY
{
    CGPoint tmpPoint = self.center;
    tmpPoint.y = gjw_centerY;
    self.center = tmpPoint;
}

- (CGFloat)gjw_width
{
    return self.frame.size.width;
}

- (void)setGjw_width:(CGFloat)gjw_width
{
    CGRect tempRect = self.frame;
    tempRect.size.width = gjw_width;
    self.frame = tempRect;
}


- (CGFloat)gjw_height
{
    return self.frame.size.height;
}

- (void)setGjw_height:(CGFloat)gjw_height
{
    CGRect tempRect = self.frame;
    tempRect.size.height = gjw_height;
    self.frame = tempRect;
}

@end



@implementation UIView (GJRendered)

- (UIImage *)gjw_renderImage {
    return [self gjw_renderImageInRect:self.bounds];
}

- (UIImage *)gjw_renderImageInRect:(CGRect)aRect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:aRect];
    CGRect rect = path.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [path addClip];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)gjw_renderImageAndSaveToFileWithFilePath:(NSString *)aFilePath
{
    return [UIImagePNGRepresentation([self gjw_renderImage]) writeToFile:aFilePath atomically:YES];
}

@end
