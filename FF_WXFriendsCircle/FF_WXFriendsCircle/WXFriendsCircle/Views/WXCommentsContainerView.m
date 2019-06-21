//
//  WXCommentsContainerView.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "WXCommentsContainerView.h"

@implementation WXCommentsContainerView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgIcon];
        [self.bgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
    }
    return self;
}

-(void)updateCommentsContainerViewWithComments:(NSArray *)comments likes:(NSArray *)likes constraintView:(UIView *)constraintView{
    self.hidden = (comments.count == 0 && likes.count == 0);
    
    if (comments.count == 0 && likes.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom);
        }];
        
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom).offset(kSCALE(20.0));
        }];
    }
 
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[UIImageView class]]) { //不要删除了背景图
            [obj removeFromSuperview];
        }
    }];
    
    //    if (comments.count == 0) {
    //        return;
    //    }
    
    if (comments.count == 0  && likes.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.0);
        }];
        return;
    }
    
    CGFloat lsat_origin_y = 0.0;
    if (likes.count || comments.count) {
        lsat_origin_y += kSCALE(20.0);
    }
    
    if (likes.count > 0) {
       
        NSString *text = [likes componentsJoinedByString:@","];
        text = [NSString stringWithFormat:@"❤️ %@",text];
        
        MLLinkLabel *label = [[MLLinkLabel alloc] init];
        label.lineSpacing = kSCALE(5.0);
        label.text = text;
        label.numberOfLines = 0;
        //label.backgroundColor = [UIColor orangeColor];
        label.font = kFont(kSCALE(28.0));
        
        CGFloat height = [label preferredSizeWithMaxWidth:CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(200.0)].height + kSCALE(10.0);
        label.frame = CGRectMake(kSCALE(10.0), lsat_origin_y, CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(200.0), height);
        
        [self addSubview:label];
        
        for (int i = 0; i < likes.count; i++) {
            NSString *name = likes[i];
            [label addLinkWithType:MLLinkTypeUserHandle value:[NSString stringWithFormat:@"%@的ID",name] range:[text rangeOfString:name]];
            
            label.didClickLinkBlock = ^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                NSLog(@"---- linkText = %@,linkValue = %@", linkText,link.linkValue);
            };
        }
        
        if (comments.count) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + kSCALE(5.0), CGRectGetWidth(label.frame) + kSCALE(20.0), 1.0)];
            line.backgroundColor = [UIColor whiteColor];
            [self addSubview:line];
        }
        
        lsat_origin_y += height;
    }
    
    if (comments.count && likes.count) {
        lsat_origin_y += kSCALE(10.0);
    }
    
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
        
        CGFloat height = [label preferredSizeWithMaxWidth:CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(200.0)].height + kSCALE(10.0);
        
        //CGFloat height1 = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(60), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : kFont(kSCALE(28.0))} context:nil].size.height + kSCALE(10.0);
        
        label.frame = CGRectMake(kSCALE(10.0), lsat_origin_y, CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(200.0), height);
        
        lsat_origin_y = CGRectGetMaxY(label.frame);
    }
    
    lsat_origin_y += kSCALE(10.0);
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lsat_origin_y);
    }];
    
}

-(UIImageView *)bgIcon{
    if (_bgIcon == nil) {
        _bgIcon = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"reply_bg_arrow"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width / 2.0 topCapHeight:image.size.height / 2.0];
        _bgIcon.image = image;
    }
    return _bgIcon;
}

//-(void)drawRect:(CGRect)rect{
//
//    [super drawRect:rect];
//
//    UIColor *color = [UIColor lightGrayColor];
//    [color set];
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(kSCALE(30.0), 0.0)];
//    [path addLineToPoint:CGPointMake(kSCALE(40.0), kSCALE(10.0))];
//    [path addLineToPoint:CGPointMake(rect.size.width, kSCALE(10.0))];
//    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
//    [path addLineToPoint:CGPointMake(0.0, rect.size.height)];
//    [path addLineToPoint:CGPointMake(0.0, kSCALE(10.0))];
//    [path addLineToPoint:CGPointMake(kSCALE(20.0), kSCALE(10.0))];
//    [path addLineToPoint:CGPointMake(kSCALE(30.0), 0.0)];
//
//    //[path fill];
//    [path fillWithBlendMode:kCGBlendModeNormal alpha:0.1];
//
//    [path stroke];
//
//}

@end
