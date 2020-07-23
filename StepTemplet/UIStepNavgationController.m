//
//  UIStepNavgationController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/22.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIStepNavgationController.h"

@interface UIStepNavgationController ()

@end

@implementation UIStepNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(BOOL)shouldAutorotate{
    return [self.viewControllers.firstObject shouldAutorotate];
}

@end
