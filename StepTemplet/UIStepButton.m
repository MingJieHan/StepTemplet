//
//  UIStepButton.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/19.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIStepButton.h"

@interface UIStepButton(){
    
}
@end

@implementation UIStepButton
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];

    if (highlighted){
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
    }else{
        self.titleLabel.font = [UIFont systemFontOfSize:20.f];
    }
}

@end
