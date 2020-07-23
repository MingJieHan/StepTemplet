//
//  ViewController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/18.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIStepViewController.h"
#import "UITemplateTableViewController.h"
#import "UIStepButton.h"
#import "UIDataScrollView.h"

#define TOOL_BAR_HEIGHT 50.f
#define MENU_HEIGHT 40.f

UIStepViewController *myStepViewController;
@interface UIStepViewController ()<UIScrollViewDelegate,UITabBarDelegate>{
    NSInteger step_num;
    NSMutableArray <UIStepButton *>* step_buttons_array;
}
@property (nonatomic) UIView *stepview;
@property (nonatomic) UIScrollView *menuView;
@property (nonatomic) UIDataScrollView *dataView;
@property (nonatomic) UITabBar *toolBar;
@end

@implementation UIStepViewController
@synthesize dataSource;
@synthesize delegate;

+(UIStepViewController *)shareStepViewController{
    if (nil == myStepViewController){
        myStepViewController = [[UIStepViewController alloc] init];
    }
    return myStepViewController;
}

-(BOOL)shouldAutorotate{
    [self.menuView setFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.safeAreaInsets.top+MENU_HEIGHT)];
    for (int i=0;i<step_buttons_array.count;i++){
        UIButton *button = [step_buttons_array objectAtIndex:i];
        if (button.highlighted){
            [self.stepview setCenter:CGPointMake(button.center.x, self.stepview.center.y)];
            break;
        }
    }
    
    [self.dataView setFrame:CGRectMake(0.f, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, self.view.frame.size.height-MENU_HEIGHT-TOOL_BAR_HEIGHT-self.view.safeAreaInsets.top-self.view.safeAreaInsets.bottom)];
    [self.toolBar setFrame:CGRectMake(0.f, CGRectGetMaxY(self.dataView.frame), self.view.frame.size.width, TOOL_BAR_HEIGHT+self.view.safeAreaInsets.bottom)];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    step_buttons_array = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    step_num = [dataSource numberOfItems];
    
    [self.view addSubview:self.menuView];
    float button_width = self.menuView.frame.size.width/step_num;
    for (int i=0;i<step_num;i++){
        UIStepButton *button = [[UIStepButton alloc] initWithFrame:CGRectMake(i * button_width, self.menuView.frame.size.height - 34.f, button_width, 20.f)];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [self.menuView addSubview:button];
        [button setTitle:[dataSource stepViewController:self getViewNameFor:i] forState:UIControlStateNormal];
        [step_buttons_array addObject:button];
    }
    
    [self.view addSubview:self.dataView];
    self.dataView.scrollEnabled = YES;
    self.dataView.contentSize = CGSizeMake(4 * self.view.frame.size.width,self.dataView.frame.size.height);
    self.dataView.delegate = self;
    
    for (int i=0;i<[dataSource numberOfItems];i++){
        UIViewController *view = [dataSource stepViewController:self getViewFor:i];
        view.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [view willMoveToParentViewController:self];
        view.view.frame = CGRectMake(self.view.frame.size.width * i, 0.f, self.view.frame.size.width, self.dataView.frame.size.height);
        [self.dataView addSubview:view.view];
        [view didMoveToParentViewController:self];
        [self.dataView.viewControllers_array addObject:view];
    }
    
    [self.menuView addSubview:self.stepview];
    
    [self.view addSubview:self.toolBar];
    
    [step_buttons_array.firstObject setHighlighted:YES];
    [self.stepview setCenter:CGPointMake(step_buttons_array.firstObject.center.x, self.stepview.center.y)];
    self.toolBar.items = [dataSource stepViewController:self getTabBarItemsFor:0];
}

-(UIScrollView *)dataView{
    if (nil == _dataView) {
        _dataView = [[UIDataScrollView alloc] init];
        _dataView.showsVerticalScrollIndicator = NO;
        _dataView.showsHorizontalScrollIndicator = NO;
        _dataView.pagingEnabled = YES;
        _dataView.bounces = NO;
        _dataView.scrollsToTop = NO;
        _dataView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        if (@available(iOS 11.0, *)) {
            _dataView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        float toolbar_height = TOOL_BAR_HEIGHT;
        if (@available(iOS 11.0, *)) {
            toolbar_height += [UIApplication sharedApplication].keyWindow.rootViewController.view.safeAreaInsets.bottom;
        }
        _dataView.frame = CGRectMake(0,CGRectGetMaxY(self.menuView.frame),self.view.bounds.size.width, self.view.frame.size.height-CGRectGetMaxY(self.menuView.frame)-toolbar_height) ;
    }
    return _dataView;
}

-(UIScrollView *)menuView{
    if (nil == _menuView) {
        _menuView = [UIScrollView new];
        _menuView.showsVerticalScrollIndicator = NO;
        _menuView.showsHorizontalScrollIndicator = NO;
        _menuView.backgroundColor = [UIColor colorWithRed:0.08f green:0.68f blue:0.79f alpha:1.f];
        _menuView.pagingEnabled = YES;
        _menuView.bounces = NO;
        _menuView.scrollsToTop = NO;
        _menuView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        float menu_height = MENU_HEIGHT;
        menu_height += UIApplication.sharedApplication.statusBarFrame.size.height;
        if (@available(iOS 11.0, *)) {
            _menuView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            UIEdgeInsets edg = [UIApplication sharedApplication].keyWindow.rootViewController.additionalSafeAreaInsets;
            menu_height += edg.top;
        }
        _menuView.frame = CGRectMake(0, 0, self.view.bounds.size.width, menu_height);
    }
    return _menuView;
}

-(UIView *)stepview{
    if (nil == _stepview){
        _stepview = [[UIView alloc] initWithFrame:CGRectMake(0.f, UIApplication.sharedApplication.statusBarFrame.size.height + 30.f, 20.f, 3.f)];
        _stepview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _stepview.backgroundColor = [UIColor systemPinkColor];
    }
    return _stepview;
}

-(UITabBar *)toolBar{
    if (nil == _toolBar){
        _toolBar = [[UITabBar alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.dataView.frame), self.view.frame.size.width, TOOL_BAR_HEIGHT+self.view.safeAreaInsets.bottom)];
        _toolBar.tintColor = [UIColor redColor];
        _toolBar.unselectedItemTintColor = [UIColor blueColor];
        _toolBar.delegate = self;
        _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    }
    return _toolBar;
}

-(void)refreshToolBar{
    NSInteger newIndex = self.dataView.contentOffset.x/self.dataView.frame.size.width;
    self.toolBar.items = [dataSource stepViewController:self getTabBarItemsFor:newIndex];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    return;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    if (![scrollView isDecelerating] && ![scrollView isDragging]) return;
    if (scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <= self.dataView.contentSize.width ) {
        NSLog(@"draping TODO");
    }
    if (scrollView.contentOffset.y == 0) return;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView != self.dataView) return;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    
    NSInteger newIndex = scrollView.contentOffset.x/self.dataView.frame.size.width;
    UIViewController *view = [self.dataView.viewControllers_array objectAtIndex:newIndex];
    self.toolBar.items = [dataSource stepViewController:self getTabBarItemsFor:newIndex];
    [view beginAppearanceTransition:YES animated:YES];
    [view didMoveToParentViewController:self];
    [view endAppearanceTransition];
    
    UIStepButton *button = [step_buttons_array objectAtIndex:newIndex];
    for (UIStepButton *c_button in step_buttons_array){
        if (c_button == button){
            [c_button setHighlighted:YES];
            [self.stepview setCenter:CGPointMake(button.center.x, self.stepview.center.y)];
        }else{
            [c_button setHighlighted:NO];
        }
    }
}

@end


