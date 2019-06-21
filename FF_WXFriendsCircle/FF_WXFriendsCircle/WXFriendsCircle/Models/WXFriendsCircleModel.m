//
//  WXFriendsCircleModel.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "WXFriendsCircleModel.h"

@implementation WXFriendsCircleModel


-(CGFloat)cellHeight{
    if (_cellHeight == 0.0) {
        
        //用户信息高度
        CGFloat height = kSCALE(90.0);
        
        //内容高度
        if (self.content.length) {
            NSString *content = self.content;
            if (!self.isOpen) {
                if (content.length > 45) {
                    content = [content substringWithRange:NSMakeRange(0, 45)];
                }
            }
            
            NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
            para.lineSpacing = kSCALE(5.0);
            
            CGFloat textH = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(180.0), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName : kFont(kSCALE(30.0)) , NSParagraphStyleAttributeName : para} context:nil].size.height;
            
            textH += kSCALE(10.0);
            height += textH;
        }
        
        ///图片高度
        CGFloat itemWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(300.0) - 2 * kSCALE(5.0)) / 3.0;
        if (self.pics.count) {  //四宫格
            if (self.pics.count == 4) {
                NSInteger row1 = self.pics.count % 2 == 0 ? self.pics.count / 2 : self.pics.count / 2 + 1;
                CGFloat picsContainerViewHeight = row1 * itemWidth + (row1 - 1) * kSCALE(5.0);
                picsContainerViewHeight += kSCALE(20);
                
                height += picsContainerViewHeight;
                
            }else{  //九宫格
                NSInteger row1 = self.pics.count % 3 == 0 ? self.pics.count / 3 : self.pics.count / 3 + 1;
                CGFloat picsContainerViewHeight = row1 * itemWidth + (row1 - 1) * kSCALE(5.0);
                picsContainerViewHeight += kSCALE(20);
                
                height += picsContainerViewHeight;
            }
            
        }
        
        //时间高度
        height += kSCALE(20.0);
        height += kSCALE(30.0);
        
        
        ///评论高度
        CGFloat lsat_origin_y = 0.0;
        if (self.likes.count || self.comments.count) {
            lsat_origin_y += kSCALE(20.0);  //顶部间距
            lsat_origin_y += kSCALE(20.0);  //箭头高度
        }
        
        if (self.likes.count) {
            NSString *text = [self.likes componentsJoinedByString:@","];
            text = [NSString stringWithFormat:@"❤️ %@",text];
            
            NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
            para.lineSpacing = kSCALE(5.0);
            
             CGFloat th = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(200.0), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : kFont(kSCALE(28.0)), NSParagraphStyleAttributeName : para} context:nil].size.height + kSCALE(10.0);
            
            lsat_origin_y += th;
        }
        
        //评论和点赞之间的间距 只存在一个是没有间距的
        if (self.comments.count && self.likes.count) {
            lsat_origin_y += kSCALE(10.0);
        }
        
        for (int i = 0; i < self.comments.count; i++) {
            NSString *content = self.comments[i];
            
            NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
            para.lineSpacing = kSCALE(5.0);
            
            CGFloat commentHeight = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(200.0), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : kFont(kSCALE(28.0)), NSParagraphStyleAttributeName : para} context:nil].size.height + kSCALE(10.0);
            
            lsat_origin_y += commentHeight;
        }
        
        if (self.comments.count > 0 || self.likes.count > 0) {
            lsat_origin_y += kSCALE(10.0);
            height += lsat_origin_y;
        }
        
        //底部按钮高度
        height += kSCALE(20.0);
        
        _cellHeight = height;
    }
    return _cellHeight;
}

-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    //重新计算cell高度
    _cellHeight = 0.0;
    [self cellHeight];
}

@end
