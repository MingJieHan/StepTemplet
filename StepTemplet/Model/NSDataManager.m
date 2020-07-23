//
//  NSDataManager.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/20.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "NSDataManager.h"
#define ENTITY_NAME_PROJECT @"NSProject"
NSDataManager *share_manager;
@interface NSDataManager(){
    
}
@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSManagedObjectContext *backgroundMOC;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic) NSURL *storeURL;
@end

@implementation NSDataManager
@synthesize managedObjectContext;
@synthesize backgroundMOC;

+(NSDataManager *)shareManager{
    if (nil == share_manager){
        share_manager = [[NSDataManager alloc] init];
        NSString *store_string = [NSHomeDirectory() stringByAppendingString:@"/Library/VideoModel.sqlite"];
        share_manager.storeURL = [NSURL fileURLWithPath:store_string];
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"VideoModel" withExtension:@"momd"];
        share_manager.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        share_manager.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:share_manager.managedObjectModel];
        
        NSError *error = nil;
        NSPersistentStore *persistentStore = nil;
        if (nil == persistentStore){
            persistentStore = [share_manager.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:share_manager.storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error];
            if (nil == persistentStore || error){
                NSLog(@"place store error.");
                return nil;
            }
        }
        share_manager.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [share_manager.managedObjectContext setPersistentStoreCoordinator:share_manager.persistentStoreCoordinator];
        [share_manager.managedObjectContext persistentStoreCoordinator];
        share_manager.backgroundMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        share_manager.backgroundMOC.parentContext = share_manager.managedObjectContext;
        [share_manager.backgroundMOC performBlock:^{
            [share_manager.backgroundMOC save:nil];
            [share_manager.managedObjectContext performBlock:^{
                [share_manager.managedObjectContext save:nil];
            }];
        }];
    }
    return share_manager;
}

-(NSProject *)newProject{
    NSEntityDescription *entity;
    NSProject *project;
    if ([NSThread isMainThread]){
        entity = [NSEntityDescription entityForName:ENTITY_NAME_PROJECT inManagedObjectContext:managedObjectContext];
        project = [[NSProject alloc] initWithEntity:entity
                                insertIntoManagedObjectContext:managedObjectContext];
    }else{
        entity = [NSEntityDescription entityForName:ENTITY_NAME_PROJECT inManagedObjectContext:backgroundMOC];
        project = [[NSProject alloc] initWithEntity:entity
                                insertIntoManagedObjectContext:backgroundMOC];
    }
    if (nil == project){
        NSLog(@"CoreData Error.");
    }
    return project;
}

-(NSArray <NSProject *>*)projects{
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_PROJECT inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];

//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"motified_date" ascending:NO];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
//    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error filtering search: %@", [error description]);
        return nil;
    }
    return fetchedObjects;
}
@end
