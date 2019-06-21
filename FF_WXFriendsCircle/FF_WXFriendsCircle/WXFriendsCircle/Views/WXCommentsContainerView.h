//
//  WXCommentsContainerView.h
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXCommentsContainerView : UIView


@property (nonatomic,strong) UIImageView *bgIcon;


-(void)updateCommentsContainerViewWithComments:(NSArray *)comments likes:(NSArray *)likes constraintView:(UIView *)constraintView;


@end

NS_ASSUME_NONNULL_END
