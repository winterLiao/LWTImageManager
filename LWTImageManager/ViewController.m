//
//  ViewController.m
//  LWTImageManager
//
//  Created by liaowentao on 17/9/11.
//  Copyright © 2017年 LWT. All rights reserved.
//

#import "ViewController.h"
#import "ImageManager.h"
#import "ClipImageViewController.h"
#import "SimpleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ClipImageViewController *vc = [[ClipImageViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"baseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"baseBeizerPath";
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"PointBeizerPath";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"SquareBeizerPath";
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"CubeBeizerPath";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"ProgressView";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
