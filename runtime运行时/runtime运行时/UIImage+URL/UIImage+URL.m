//
//  UIImage+URL.m
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "UIImage+URL.h"
#import <objc/runtime.h>

@implementation UIImage (URL)
+ (void)load{
//    获取image的系统方法imageWithName
    Method imageWithName = class_getClassMethod([UIImage class], @selector(imageNamed:));
//    获取自定义的In_ImageName方法
    Method In_imageName = class_getClassMethod([UIImage class], @selector(In_imageName:));
//    交换两个方法的指针地址，相当于交换两个方法的实现
    method_exchangeImplementations(In_imageName, imageWithName);
}

/**
 *这个方法内部实现并不会产生循环引用，因为在load方法中，imageName:的方法和In_imageName:的实现进行了交换，调用In_imageName:其实是调用imageName:方法
 */
+(UIImage *)In_imageName:(NSString *)name{
    UIImage * image = [UIImage In_imageName:name];
    if (image == nil) {
        NSLog(@"image加载错误");
    }
    return image;
}
@end
