//
//  CommentsContainerView.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "CommentsContainerView.h"

@implementation CommentsContainerView

-(instancetype)init{
    if (self = [super init]) {
        //self.backgroundColor = [UIColor orangeColor];
        
        
        
    }
    return self;
}

-(void)updateCommentsContainerViewWithComments:(NSArray *)comments constraintView:(UIView *)constraintView{
    
    if (comments.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom);
        }];
        return;
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat lsat_origin_y = kSCALE(5.0);
    
    for (int i = 0; i < comments.count; i++) {
        NSString *content = comments[i];
        
        MLLinkLabel *label = [[MLLinkLabel alloc] init];
        label.lineSpacing = kSCALE(5.0);
        label.text = content;
        label.numberOfLines = 0;
        label.font = kFont(kSCALE(28.0));
        [self addSubview:label];
        
        [label addLinkWithType:MLLinkTypeUserHandle value:@"小红的ID" range:NSMakeRange(0, @"小红".length)];
        [label addLinkWithType:MLLinkTypeUserHandle value:@"小胡的ID" range:NSMakeRange(@"小红 回复 ".length, @"小胡".length)];
        
        label.didClickLinkBlock = ^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
            NSLog(@"---- linkText = %@,linkValue = %@", linkText,link.linkValue);
        };
        
        CGFloat height = [label preferredSizeWithMaxWidth:CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(60.0)].height + kSCALE(10.0);
        
        //CGFloat height1 = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(60), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : kFont(kSCALE(28.0))} context:nil].size.height + kSCALE(10.0);
        
        label.frame = CGRectMake(0, lsat_origin_y, CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(60.0), height);

        lsat_origin_y = CGRectGetMaxY(label.frame);
    }
    
    lsat_origin_y += kSCALE(5.0);
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lsat_origin_y);
    }];
    
}

@end
