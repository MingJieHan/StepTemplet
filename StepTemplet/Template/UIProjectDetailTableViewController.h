//
//  UIProjectDetailTableViewController.h
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/20.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSProject.h"


NS_ASSUME_NONNULL_BEGIN
@interface UIProjectDetailTableViewController : UITableViewController{
    NSProject *project;
}
@property (nonatomic) NSProject *project;
@end
NS_ASSUME_NONNULL_END
