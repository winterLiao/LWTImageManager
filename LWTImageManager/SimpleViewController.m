//
//  SimpleViewController.m
//  LWTImageManager
//
//  Created by liaowentao on 17/10/12.
//  Copyright © 2017年 LWT. All rights reserved.
//

#import "SimpleViewController.h"
#import "ImageManager.h"


@interface SimpleViewController ()

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //颜色转图片
    UIImageView *colorImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2.0, 100, 200, 80)];
    colorImageView.image = [ImageManager createImageWithColor:[UIColor orangeColor]];
    [self.view addSubview:colorImageView];
    
    //拉伸图片
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2.0, CGRectGetMaxY(colorImageView.frame) + 30, 200, 10)];
    label1.textColor = [UIColor blackColor];
    label1.text = @"未拉伸的图片:";
    label1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label1];
    UIImage *stretchImage = [UIImage imageNamed:@"icon_layer"];
    UIImageView *icomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(label1.frame), CGRectGetMaxY(colorImageView.frame) + 50, stretchImage.size.width, stretchImage.size.height)];
    icomImageView.image = stretchImage;
    [self.view addSubview:icomImageView];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2.0, CGRectGetMaxY(icomImageView.frame) + 30, 200, 10)];
    label2.textColor = [UIColor blackColor];
    label2.text = @"未处理使用的图片:";
    label2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label2];
    UIImageView *preImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(label2.frame), CGRectGetMaxY(label2.frame) + 20, 200, stretchImage.size.height)];
    preImageView.image = stretchImage;
    [self.view addSubview:preImageView];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2.0, CGRectGetMaxY(preImageView.frame) + 30, 200, 10)];
    label3.textColor = [UIColor blackColor];
    label3.text = @"使用拉伸处理的图片:";
    label3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label3];
    UIImageView *stretchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(preImageView.frame) + 50, 200, stretchImage.size.height)];
    stretchImageView.image = [ImageManager stretchImage:stretchImage edgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self.view addSubview:stretchImageView];
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
