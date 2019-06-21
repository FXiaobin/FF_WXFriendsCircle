//
//  WXPicsContainerView.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "WXPicsContainerView.h"

@interface WXPicsContainerView ()<YBImageBrowserDelegate,YBImageBrowserDataSource>


@property (nonatomic,strong) NSArray *pics;


@end

@implementation WXPicsContainerView


-(instancetype)init{
    if (self = [super init]) {
        //self.backgroundColor = [UIColor cyanColor];
        
        
        
    }
    return self;
}

-(void)updatePicsContainerImagesWithPics:(NSArray *)pics constraintView:(nonnull UIView *)constraintView{
    self.pics = pics;
    //先做好约束 再做其他处理
    self.hidden = (pics.count == 0);
    if (pics.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom);
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom).offset(kSCALE(20.0));
        }];
    }
  
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    ///不能直接return，由于cell复用的原因 如果这里return了 那这个cell就会复用之前的约束 但是当前想要的约束可能跟之前的约束是不一样的，所以不管有没有数据都要根据数据的内容来更新当前cell的正确显示,但是可以先更新了当前cell的高度再return
    //    if (pics.count == 0) {
    //        return;
    //    }
    
    if (pics.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.0);
        }];
        return;
    }
    
    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(300.0) - 2 * kSCALE(5.0)) / 3.0;
    
    if (pics.count == 4) {
        for (int i = 0; i < pics.count; i++) {
            NSInteger row = i / 2, cloumn = i % 2;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width + kSCALE(5.0)) * cloumn, (width + kSCALE(5.0)) * row, width, width)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:pics[i]]];
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageView:)];
            imageView.tag = 3000 + i;
            [imageView addGestureRecognizer:ges];
            
            [self addSubview:imageView];
        }
        
    }else{
        for (int i = 0; i < pics.count; i++) {
            NSInteger row = i / 3, cloumn = i % 3;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width + kSCALE(5.0)) * cloumn, (width + kSCALE(5.0)) * row, width, width)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:pics[i]]];
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageView:)];
            imageView.tag = 3000 + i;
            [imageView addGestureRecognizer:ges];
            
            [self addSubview:imageView];
        }
    }
    
    ///更新图片承载视图的高度
    CGFloat itemWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - kSCALE(300.0) - 2 * kSCALE(5.0)) / 3.0;
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

-(void)showImageView:(UITapGestureRecognizer *)ges{
    NSInteger tag = ges.view.tag - 3000;
    UIImageView *imageV = (UIImageView *)ges.view;
    if (self.showImageViewBlock) {
        self.showImageViewBlock(self, tag, imageV);
    }
    
    // 设置数据源数组并展示
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.pics enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:urlStr];
        UIImageView *currentImageView = (UIImageView *)[self viewWithTag:3000 + idx];
        data.sourceObject = currentImageView;
        [browserDataArr addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = tag;
    [browser show];
}



@end
