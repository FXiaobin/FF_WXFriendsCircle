//
//  WXFriendsCircleCell.h
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFriendsCircleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXFriendsCircleCell : UITableViewCell

@property (nonatomic,strong) UIView *operationView;
@property (nonatomic,assign) BOOL isOperationShow;
@property (nonatomic,strong) UIButton *operationBtn;

@property (nonatomic,strong) WXFriendsCircleModel *model;
@property (nonatomic,copy) void (^openBtnActionBlock) (WXFriendsCircleCell *currentCell,UIButton *sender,WXFriendsCircleModel *aModel,NSInteger tag);

@property (nonatomic,copy) void (^operationBtnActionBlock) (UIButton *sender,WXFriendsCircleModel *aModel,NSInteger tag);

///移除所有可见的评论点赞浮层
+ (void)updateOperationViewShowStatusWithTableView:(UITableView *)tableView currentCell:(WXFriendsCircleCell *)cell;

@end

NS_ASSUME_NONNULL_END
