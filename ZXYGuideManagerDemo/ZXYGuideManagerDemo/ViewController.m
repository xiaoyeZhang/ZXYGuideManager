//
//  ViewController.m
//  ZXYGuideManagerDemo
//
//  Created by zhangxiaoye on 2019/9/12.
//  Copyright © 2019 zhangxiaoye. All rights reserved.
//

#import "ViewController.h"
#import <ZXYGuideManager/GuideManager.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
    
    label.text = @"测试";
    
    label.backgroundColor = [UIColor redColor];
    
    [[GuideManager shareManager] showGuidePageWithType:GuidePageTypeHome ViewFrame:CGRectMake(100, 200, 100, 40) TipView:label cornerRadius:5 completion:^{
       
        
    }];
    
}


@end
