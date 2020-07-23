//
//  UIDataScrollView.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/22.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIDataScrollView.h"

@interface UIDataScrollView(){
    
}
@end



@implementation UIDataScrollView
@synthesize viewControllers_array;

-(id)init{
    self = [super init];
    if (self){
        viewControllers_array = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)setFrame:(CGRect)frame{
    NSInteger current_index = self.contentOffset.x/self.frame.size.width;
    [super setFrame:frame];
    [self setContentSize:CGSizeMake(frame.size.width * viewControllers_array.count, frame.size.height)];
    if (viewControllers_array){
        for (int i=0;i<viewControllers_array.count;i++){
            UIViewController *view = [viewControllers_array objectAtIndex:i];
            [view.view setFrame:CGRectMake(i * frame.size.width, 0.f, frame.size.width, frame.size.height)];
            
            [view beginAppearanceTransition:YES animated:YES];
            [view didMoveToParentViewController:nil];
            [view endAppearanceTransition];
        }
    }
    [self setContentOffset:CGPointMake(self.frame.size.width * current_index, 0.f) animated:YES];
    return;
}

@end
