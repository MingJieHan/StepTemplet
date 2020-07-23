//
//  UIProjectDetailTableViewController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/20.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIProjectDetailTableViewController.h"
#define Project_Name @"Project_Name"


@interface UIProjectDetailTableViewController ()

@end

@implementation UIProjectDetailTableViewController
@synthesize project;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
}

-(NSString *)cellIdentifierFor:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return @"";
        case 1:
            return @"";
            break;
        default:
            break;
    }
    return @"";
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cell_id = [self cellIdentifierFor:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_id];
    if ([cell_id isEqualToString:Project_Name]){
        cell.textLabel.text = @"Project Name";
    }
    return cell;
}


@end
