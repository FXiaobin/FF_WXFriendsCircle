//
//  WXPicsContainerView.h
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXPicsContainerView : UIView

@property (nonatomic,copy) void (^showImageViewBlock) (WXPicsContainerView *containerView, NSInteger tag, UIImageView *imageView);

-(void)updatePicsContainerImagesWithPics:(NSArray *)pics constraintView:(UIView *)constraintView;

@end

NS_ASSUME_NONNULL_END
