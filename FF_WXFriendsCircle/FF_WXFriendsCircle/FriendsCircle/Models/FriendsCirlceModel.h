//
//  FriendsCirlceModel.h
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendsCirlceModel : NSObject

@property (nonatomic,copy) NSString *avator;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSArray *pics;
@property (nonatomic,copy) NSArray *comments;
@property (nonatomic,copy) NSString *commentNum;
@property (nonatomic,copy) NSString *likeNum;
@property (nonatomic,copy) NSString *collectionNum;

@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
