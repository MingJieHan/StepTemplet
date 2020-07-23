//
//  UIImageCollectionViewCell.h
//  StepTemplet
//
//  Created by Han Mingjie on 2020/7/19.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageCollectionViewCell : UICollectionViewCell{
    NSString *name;
}
@property (nonatomic) NSString *name;
- (void)loadWithModel:(NSDictionary *)model;
- (void)beginShake;
- (void)stopShake;
@end

NS_ASSUME_NONNULL_END
