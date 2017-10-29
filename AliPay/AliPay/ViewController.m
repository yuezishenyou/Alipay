//
//  ViewController.m
//  AliPay
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "ViewController.h"
#import "HHMainController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(50, 100, 100, 40);
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    
}

- (void)btnAction
{
    
    HHMainController *vc = [[HHMainController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
