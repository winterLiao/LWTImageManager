//
//  ClipImageViewController.m
//  LWTImageManager
//
//  Created by liaowentao on 17/10/10.
//  Copyright © 2017年 LWT. All rights reserved.
//

#import "ClipImageViewController.h"
#import "ImageManager.h"


@interface ClipImageViewController ()

@end

@implementation ClipImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"lwt"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - image.size.width) / 2.0, 100, image.size.width, image.size.height)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //截取图片
    UIImageView *clipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2.0, CGRectGetMaxY(imageView.frame) + 10, 100, 100)];
    clipImageView.backgroundColor = [UIColor blackColor];
    UIImage *clipImage = [ImageManager cropImage:image cropRect:CGRectMake(50, 50, 100, 100)];
    clipImageView.image = clipImage;
    [self.view addSubview:clipImageView];
    
    //压缩图片
    UIImageView *compressImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 90) / 2.0, CGRectGetMaxY(clipImageView.frame) + 10, 90, 100)];
    compressImageView.backgroundColor = [UIColor blackColor];
    UIImage *compressImage = [ImageManager compressimage:image fortargetSize:CGSizeMake(90, 100)];
    compressImageView.image = compressImage;
    [self.view addSubview:compressImageView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
