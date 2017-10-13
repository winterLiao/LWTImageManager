//
//  ImageManager.h
//  LWTImageManager
//
//  Created by liaowentao on 17/9/11.
//  Copyright © 2017年 LWT. All rights reserved.
//
//  图片处理工具

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageManager : NSObject


/**
 颜色转换成图片

 @param color 颜色
 @return 颜色转换成的图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


/**
 拉伸图片（类似安卓的点9图实现）

 @param image 未拉伸的图片
 @param insets 图片的边缘受保护不拉伸的范围
 @return 处理后图片
 */
+ (UIImage *)stretchImage:(UIImage *)image edgeInsets:(UIEdgeInsets)insets;


/**
 按比例压缩图片 不变形
 
 @param image 原图片
 @param targetSize 压缩的尺寸
 @return 处理后图片
 */
+ (UIImage*)compressimage:(UIImage*)image fortargetSize:(CGSize)targetSize;

/**
 使用矩形剪裁图片

 @param image 原图片
 @param rect 需截取的图片区域
 @return 处理后图片
 */
+ (UIImage *)cropImage:(UIImage *)image cropRect:(CGRect)rect;
@end
