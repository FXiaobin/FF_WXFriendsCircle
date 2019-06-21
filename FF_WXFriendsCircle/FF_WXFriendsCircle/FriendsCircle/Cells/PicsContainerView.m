//
//  PicsContainerView.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "PicsContainerView.h"

@implementation PicsContainerView

-(instancetype)init{
    if (self = [super init]) {
        //self.backgroundColor = [UIColor cyanColor];
        
      
        
    }
    return self;
}

-(void)updatePicsContainerImagesWithPics:(NSArray *)pics constraintView:(nonnull UIView *)constraintView{
    if (pics.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom);
        }];
        return;
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(60.0) - 2 * kSCALE(5.0)) / 3.0;
   
    if (pics.count == 4) {
        for (int i = 0; i < pics.count; i++) {
            NSInteger row = i / 2, cloumn = i % 2;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width + kSCALE(5.0)) * cloumn, (width + kSCALE(5.0)) * row, width, width)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:pics[i]]];
            [self addSubview:imageView];
        }
        
    }else{
        for (int i = 0; i < pics.count; i++) {
            NSInteger row = i / 3, cloumn = i % 3;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width + kSCALE(5.0)) * cloumn, (width + kSCALE(5.0)) * row, width, width)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:pics[i]]];
            [self addSubview:imageView];
        }
    }
    
    ///更新图片承载视图的高度
    CGFloat itemWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(60.0) - 2 * kSCALE(5.0)) / 3.0;
    CGFloat height = 0.0;
    if (pics.count) {  //四宫格
        if (pics.count == 4) {
            NSInteger row1 = pics.count % 2 == 0 ? pics.count / 2 : pics.count / 2 + 1;
            CGFloat picsContainerViewHeight = row1 * itemWidth + (row1 - 1) * kSCALE(5.0);
            height += picsContainerViewHeight;
            
        }else{  //九宫格
            NSInteger row1 = pics.count % 3 == 0 ? pics.count / 3 : pics.count / 3 + 1;
            CGFloat picsContainerViewHeight = row1 * itemWidth + (row1 - 1) * kSCALE(5.0);
            height += picsContainerViewHeight;
        }
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
}


@end
