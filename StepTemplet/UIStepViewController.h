//
//  ViewController.h
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/18.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIStepViewControllerDataSource;
@protocol UIStepViewControllerDelegate;
@interface UIStepViewController : UIViewController{
    id <UIStepViewControllerDataSource> dataSource;
    id <UIStepViewControllerDelegate> delegate;
}
@property (nonatomic) id <UIStepViewControllerDataSource> dataSource;
@property (nonatomic) id <UIStepViewControllerDelegate> delegate;
+(UIStepViewController *)shareStepViewController;

-(void)refreshToolBar;
@end


@protocol UIStepViewControllerDataSource <NSObject>
@required
-(NSInteger)numberOfItems;
-(UIViewController *)stepViewController:(UIStepViewController *)stepViewController getViewFor:(NSInteger)index;
-(NSString *)stepViewController:(UIStepViewController *)stepViewController getViewNameFor:(NSInteger)index;
-(NSArray <UITabBarItem *>*)stepViewController:(UIStepViewController *)stepViewController getTabBarItemsFor:(NSInteger)index;
@optional
@end


@protocol UIStepViewControllerDelegate <NSObject>
@required
-(void)tabbarAction:(UITabBarItem *)item;
@end
