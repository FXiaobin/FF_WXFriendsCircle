//
//  FriendsCircleCell_02.h
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsCirlceModel.h"

///有评论
NS_ASSUME_NONNULL_BEGIN

@interface FriendsCircleCell_02 : UITableViewCell

@property (nonatomic,copy) void (^openBtnActionBlock) (UIButton *sender,FriendsCirlceModel *aModel);
@property (nonatomic,strong) FriendsCirlceModel *model01;

@end

NS_ASSUME_NONNULL_END
