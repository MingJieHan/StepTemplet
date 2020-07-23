//
//  NSProject.h
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/20.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class NSStep;
NS_ASSUME_NONNULL_BEGIN
@interface NSProject : NSManagedObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSData *preview;

//Relation
@property (nonatomic) NSSet <NSStep *>*steps;



@end
NS_ASSUME_NONNULL_END
