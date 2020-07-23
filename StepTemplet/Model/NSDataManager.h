//
//  NSDataManager.h
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/20.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSProject.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSDataManager : NSObject
+(NSDataManager *)shareManager;

-(NSProject *)newProject;
-(NSArray <NSProject *>*)projects;
@end
NS_ASSUME_NONNULL_END
