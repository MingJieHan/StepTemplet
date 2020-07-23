//
//  UIMyTableViewController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/18.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UITemplateTableViewController.h"
#import "UIProjectDetailTableViewController.h"
#import "NSDataManager.h"
#import "NSProject.h"

@interface UITemplateTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *projects_array;
}

@end

@implementation UITemplateTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    return;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    return;
}

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
        projects_array = [[NSMutableArray alloc] initWithArray:[[NSDataManager shareManager] projects]];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        UIBarButtonItem *setting_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
        self.toolbarItems = @[setting_item];
    }
    return self;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return projects_array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    NSProject *project = [projects_array objectAtIndex:indexPath.row];
    cell.textLabel.text = project.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIProjectDetailTableViewController *view = [[UIProjectDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    view.project = [projects_array objectAtIndex:indexPath.row];
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:view animated:YES];
    return;
}

@end
