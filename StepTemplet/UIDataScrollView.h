//
//  UIDataScrollView.h
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/22.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDataScrollView : UIScrollView{
    NSMutableArray <UIViewController *>* viewControllers_array;
}
@property (nonatomic) NSMutableArray <UIViewController *>* viewControllers_array;
@end


NS_ASSUME_NONNULL_END
