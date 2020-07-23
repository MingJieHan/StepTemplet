//
//  UIShareViewController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/19.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIShareViewController.h"

@interface UIShareViewController (){
    UIBarButtonItem *space_item;
    UIBarButtonItem *about_item;
}
@end

@implementation UIShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    about_item = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.toolbarItems = @[space_item,about_item];
}


@end
