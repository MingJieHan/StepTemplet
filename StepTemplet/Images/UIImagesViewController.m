//
//  UIImagesViewController.m
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/19.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "UIImagesViewController.h"
#import "UIStepViewController.h"
#import "UIImageCollectionViewCell.h"
@interface UIImagesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSBundle *my_bundle;
    NSMutableArray <NSString *>*sources_array;
    NSMutableArray *colorArray;
    UILongPressGestureRecognizer *gesture;
    UIBarButtonItem *space_item;
    UIBarButtonItem *action_item;
    UIBarButtonItem *add_item;
    UIBarButtonItem *rotate_item;
    UIBarButtonItem *delete_item;
    UIBarButtonItem *next_item;
}

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) BOOL isItemShake;
@end

@implementation UIImagesViewController
-(void)start_drag{
    _isItemShake = YES;
    [self.collectionView reloadData];
    action_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(end_drag)];
    self.toolbarItems = @[action_item,space_item,add_item,space_item,rotate_item,space_item,delete_item,space_item,next_item];
    if (nil == gesture){
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        gesture.minimumPressDuration = 0;
    }
    [self.collectionView addGestureRecognizer:gesture];
    [[UIStepViewController shareStepViewController] refreshToolBar];
    return;
}

-(void)end_drag{
    [self.collectionView endInteractiveMovement];
    [self.collectionView removeGestureRecognizer:gesture];
    
    action_item = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(start_drag)];
    self.toolbarItems = @[action_item,space_item,add_item,space_item,rotate_item,space_item,delete_item,space_item,next_item];
    _isItemShake = NO;
    [[UIStepViewController shareStepViewController] refreshToolBar];
    [self.collectionView reloadData];
    return;
}

-(void)add_image_action:(id)sender{
    return;
}


-(void)rotate_action:(id)sender{
    return;
}

-(void)remove_action:(id)sender{
    return;
}

-(void)next_action:(id)sender{
    return;
}


#pragma mark - System
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UICollectionView Moving Demo";
    my_bundle = [[NSBundle alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"UIImagesViewController" ofType:@"bundle"]];
    space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    add_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add_image_action:)];
    
    rotate_item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithContentsOfFile:[my_bundle pathForResource:@"rotate" ofType:@"png"]] style:UIBarButtonItemStylePlain target:self action:@selector(rotate_action:)];
    rotate_item.enabled = NO;
    
    delete_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(remove_action:)];
    delete_item.enabled = NO;
    
    next_item = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(next_action:)];
    
    colorArray = [[NSMutableArray alloc] init];
    sources_array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i ++) {
        int R = (arc4random() % 256);
        int G = (arc4random() % 256);
        int B = (arc4random() % 256) ;
        NSDictionary *dic = @{@"color":[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1]};
        [colorArray addObject:dic];
        [sources_array addObject:[NSString stringWithFormat:@"Block %d\nRed:%d\nGreen:%d\nBlue:%d",i,R,G,B]];
    }
    
    UICollectionViewFlowLayout *collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) collectionViewLayout:collectionFlowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UIImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.collectionView];
    
    [self end_drag];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView setFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark -
// 拖动手势事件
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            // 通过手势获取点，通过点获取点击的indexPath， 移动该cell
            NSIndexPath *aIndexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:aIndexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView endInteractiveMovement];
            break;
    }
}


#pragma mark -- UICollectionView / DataSource Delegate
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    id objc = [colorArray objectAtIndex:sourceIndexPath.item];
    [colorArray removeObject:objc];
    [colorArray insertObject:objc atIndex:destinationIndexPath.item];
    
    objc = [sources_array objectAtIndex:sourceIndexPath.item];
    [sources_array removeObject:objc];
    [sources_array insertObject:objc atIndex:destinationIndexPath.item];
}

//配置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(167, 167);
}

//配置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

//配置每组上下左右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 13, 15, 13);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//配置每个组里面有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return colorArray.count;
}
//配置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadWithModel:colorArray[indexPath.row]];
    if (_isItemShake) {
        [cell beginShake];
    }else{
        [cell stopShake];
    }
    cell.name = [sources_array objectAtIndex:indexPath.row];
    return cell;
}

@end
