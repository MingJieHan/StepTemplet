//
//  UIPreViewController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/19.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIPreViewController.h"

@interface UIPreViewController (){
    UIBarButtonItem *next_item;
    UIBarButtonItem *space_item;
}

@end

@implementation UIPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    next_item = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.toolbarItems = @[space_item,next_item];
}
@end
