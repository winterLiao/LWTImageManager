//
//  ImageManager.m
//  LWTImageManager
//
//  Created by liaowentao on 17/9/11.
//  Copyright © 2017年 LWT. All rights reserved.
//

#import "ImageManager.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@implementation ImageManager


/**颜色转换成图片*/
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

/**设置图片不会变形拉伸*/
+ (UIImage *)stretchImage:(UIImage *)image edgeInsets:(UIEdgeInsets)insets
{
    //CGFloat top; // 顶端盖高度
    //CGFloat bottom; // 底端盖高度
    //CGFloat left; // 左端盖宽度
    //CGFloat right; // 右端盖宽度
    //UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}


/**使用矩形剪裁图片*/
+ (UIImage *)cropImage:(UIImage *)image cropRect:(CGRect)rect
{
    if (image)
    {
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, rect, subImageRef);
        UIImage *cropImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        return cropImage;
    }
    return nil;
}

/**图片压缩不变形*/
+ (UIImage*)compressimage:(UIImage*)image fortargetSize:(CGSize)targetSize
{
    if(!image){
        return nil;
    }
    
    //原图片宽高
    UIImage *sourceImage = image;
    CGSize imageSize = sourceImage.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    NSInteger judge;//声明一个判断属性
    
    //目标宽高
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor ;//先声明拉伸的系数
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);//这个是图片剪切的起点位置
    
    //图片大小宽跟高都小于目标尺寸
    if(imageHeight < targetHeight && imageWidth < targetWidth) {
        return image;
    }
    
    if (!CGSizeEqualToSize(imageSize, targetSize))
    {
        //获取压缩比例
        CGFloat widthFactor = targetWidth / imageWidth;
        CGFloat heightFactor = targetHeight / imageHeight;

        //分四种情况,
        if(widthFactor < 1 && heightFactor < 1){
                //第一种,需要判断要缩小哪一个尺寸,这里看拉伸尺度,我们的scale在小于1的情况下,谁越小,等下就用原图的宽度高度
            if(widthFactor > heightFactor){
                judge = 1;//右部分空白
                scaleFactor = heightFactor; //修改最后的拉伸系数是高度系数(也就是最后要*这个值)
            }else{
                judge = 2;//下部分空白
                scaleFactor = widthFactor;
            }
        }else if(widthFactor > 1 && heightFactor < 1){
            //第二种,宽度不够比例,高度缩小一点点(widthFactor大于一,说明目标宽度比原图片宽度大,此时只要拉伸高度系数)
            judge =3;//下部分空白
            //采用高度拉伸比例
            scaleFactor = imageWidth / targetWidth;// 计算高度缩小系数
        }else if(heightFactor > 1 && widthFactor < 1){
            //第三种,高度不够比例,宽度缩小一点点(heightFactor大于一,说明目标高度比原图片高度大,此时只要拉伸宽度系数)
            judge =4;//下边空白
            //采用高度拉伸比例
            scaleFactor = imageHeight / targetWidth;
        }else{
            //第四种,此时宽度高度都小于目标尺寸,不必要处理放大(如果有处理放大的,在这里写).
        }

        scaledWidth = imageWidth * scaleFactor;
        scaledHeight = imageHeight * scaleFactor;
    }
    
    if(judge == 1){
        targetWidth = scaledWidth;
    }else if(judge == 2){
        targetHeight = scaledHeight;
    }else if(judge == 3){
        targetWidth = scaledWidth;
    }else{
        targetHeight= scaledHeight;
    }
    
    UIGraphicsBeginImageContext(targetSize);//开始剪切
    CGRect thumbnailRect = CGRectZero;//剪切起点(0,0)
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//截图拿到图片
    return newImage;
}

/**图片马赛克*/
+ (UIImage *)changePicColorPartial:(UIImage *)image{
    //1.get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger imageW = CGImageGetWidth(imageRef);
    NSUInteger imageH = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;//一个像素四个分量，即ARGB
    NSUInteger bytesPerRow = bytesPerPixel * imageW;
    unsigned char *rawData = (unsigned char *)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char));
    NSUInteger bitsPerComponent = 8;//每个分量8个字节
    CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
    
    //2.Now your rawData contains the image data int the RGBA8888 pixel format
    for (int y = 0; y < imageH; y++) {
        for (int x = 0; x < imageW; x++) {
            NSUInteger byteIndex = bytesPerRow*y + bytesPerPixel*x;
            //rawData一维数组存储方式RGBA(第一个像素)RGBA(第二个像素)
            NSUInteger red = rawData[byteIndex];
            NSUInteger green = rawData[byteIndex+1];
            NSUInteger blue = rawData[byteIndex+2];
            NSUInteger alpha = rawData[byteIndex+3];
            if (red+green+blue == 0 && (alpha/255.0 >= 0.5)) {//黑色部分
                rawData[byteIndex] = 180;
                rawData[byteIndex+1] = 180;
                rawData[byteIndex+2] = 180;
                rawData[byteIndex+3] = 255;
            }else if(red+green+blue == 0 && (alpha/255.0 < 0.5)){//透明部分
                rawData[byteIndex] = 255;
                rawData[byteIndex+1] = 0;
                rawData[byteIndex+2] = 0;
                rawData[byteIndex+3] = 150;
            }else if(red+green+blue == 255*3 && (alpha/255.0 >= 0.5)){//白色部分
                rawData[byteIndex] = 140;
                rawData[byteIndex+1] = 128;
                rawData[byteIndex+2] = 214;
                rawData[byteIndex+3] = 255;
            }
        }
    }
    imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(rawData);
    return [UIImage imageWithCGImage:imageRef];
    
}




@end
