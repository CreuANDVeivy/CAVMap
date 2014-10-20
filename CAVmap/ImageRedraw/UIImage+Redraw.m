

#import "UIImage+Redraw.h"
@implementation UIImage (Redraw)
+(UIImage*)redraw:(UIImage *)newImage Frame:(CGRect)frame{
    UIImage*image=newImage;
    UIGraphicsBeginImageContext(frame.size);
    [image drawInRect:frame];
    image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation UIButton(addtion)

+(UIButton*)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame image:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton*button=[UIButton buttonWithType:buttonType];
    button.frame=frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(0, 0, 20, 20)];
    imageV.image = image;
    [button addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:kFrame(20, 0, 40,20)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:12];
    [button addSubview:label];
    
    return button;
}

@end
