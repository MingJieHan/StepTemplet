//
//  AppDelegate.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/18.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "AppDelegate.h"
#import "UIStepViewController.h"
#import "UITemplateTableViewController.h"
#import "UIImagesViewController.h"
#import "UIPreViewController.h"
#import "UIShareViewController.h"
#import "UIStepNavgationController.h"
#import "NSDataManager.h"
@interface AppDelegate ()<UIStepViewControllerDataSource,UIStepViewControllerDelegate>{
    NSBundle *my_bundle;
}

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    my_bundle = [[NSBundle alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"UIStepTemplate" ofType:@"bundle"]];
    
    if (0 == [[NSDataManager shareManager] projects].count){
        [[NSDataManager shareManager] newProject];
    }
    
    UIStepViewController *view = [UIStepViewController shareStepViewController];
    view.dataSource = self;
    view.delegate = self;
    UIStepNavgationController *nav = [[UIStepNavgationController alloc] initWithRootViewController:view];
    self.window.rootViewController = nav;
    return YES;
}

#pragma mark - UIStepViewControllerDelegate
-(void)tabbarAction:(UITabBarItem *)item{
    return;
}

#pragma mark - UIStepViewControllerDataSource
-(NSInteger)numberOfItems{
    return 4;
}

-(UIViewController *)stepViewController:(UIStepViewController *)stepViewController getViewFor:(NSInteger)index{
    UITableViewController *view = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    switch (index) {
        case 0:{
            UITemplateTableViewController *my_view = [[UITemplateTableViewController alloc] initWithStyle:UITableViewStylePlain];
            return my_view;
            break;}
        case 1:{
            UIImagesViewController *view = [[UIImagesViewController alloc] init];
            return view;
            break;}
        case 2:{
            UIPreViewController *view = [[UIPreViewController alloc] init];
            return view;
            break;}
        case 3:{
            UIShareViewController *view = [[UIShareViewController alloc] init];
            return view;
            break;}
        default:
            break;
    }
    return view;
}

-(NSString *)stepViewController:(UIStepViewController *)stepViewController getViewNameFor:(NSInteger)index{
    switch (index) {
        case 0:{
            return @"Template";
            break;}
        case 1:
            return @"Images";
            break;
        case 2:
            return @"Preview";
            break;
        case 3:
            return @"Share";
            break;
        default:
            break;
    }
    return @"";
}

-(NSArray <UITabBarItem *>*)stepViewController:(UIStepViewController *)stepViewController getTabBarItemsFor:(NSInteger)index{
    UITabBarItem *sort_item = [[UITabBarItem alloc] initWithTitle:@"Sort" image:nil tag:1];
    sort_item.enabled = YES;
    
    UITabBarItem *add_item = [[UITabBarItem alloc] initWithTitle:@"Add" image:[UIImage imageWithContentsOfFile:[my_bundle pathForResource:@"add" ofType:@"png"]] tag:4];
    
    UITabBarItem *top_item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:0];
    top_item.enabled = YES;
    
    switch (index) {
        case 1:
            return @[add_item];
            break;
        default:
            break;
    }
    return @[sort_item,add_item,top_item];
}
@end


