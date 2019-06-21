//
//  WXFriendsCircleCell.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "WXFriendsCircleCell.h"

#import "WXPicsContainerView.h"
#import "WXCommentsContainerView.h"

@interface WXFriendsCircleCell ()


@property (nonatomic,strong) UIImageView *avatorIcon;

@property (nonatomic,strong) UILabel *nameLabel;


@property (nonatomic,strong) UILabel *timeLabel;


@property (nonatomic,strong) MLLinkLabel *contentLabel;

@property (nonatomic,strong) UIButton *openBtn;

@property (nonatomic,strong) WXPicsContainerView *picsContainerView;


@property (nonatomic,strong) WXCommentsContainerView *commentsContainterView;










@end

@implementation WXFriendsCircleCell

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.avatorIcon];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.openBtn];
        [self.contentView addSubview:self.picsContainerView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.operationView];
        [self.contentView addSubview:self.operationBtn];
        
        [self.contentView addSubview:self.commentsContainterView];
        
        [self.avatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self.contentView).offset(kSCALE(30.0));
            make.width.and.height.mas_equalTo(kSCALE(100.0));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatorIcon.mas_right).offset(kSCALE(20.0));
            make.top.equalTo(self.avatorIcon.mas_top).offset(kSCALE(5.0));
            make.width.mas_lessThanOrEqualTo(kSCALE(300.0));
            make.height.mas_equalTo(kSCALE(45.0));
        }];
       
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(kSCALE(10.0));
            make.right.equalTo(self.contentView.mas_right).offset(kSCALE(-30.0));
        }];
        
        [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentLabel.mas_right).offset(kSCALE(10.0));
            make.bottom.equalTo(self.contentLabel.mas_bottom).offset(kSCALE(5.0));
            make.width.mas_equalTo(kSCALE(80.0));
            make.height.mas_equalTo(kSCALE(40.0));
        }];
        
        [self.picsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.right.equalTo(self.contentView.mas_right).offset(kSCALE(-150.0));
            make.top.equalTo(self.contentLabel.mas_bottom).offset(kSCALE(20.0));
            make.height.mas_equalTo(0.01);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picsContainerView);
            make.top.equalTo(self.picsContainerView.mas_bottom).offset(kSCALE(20.0));
            make.height.mas_equalTo(kSCALE(30.0));
        }];
        
        [self.operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.timeLabel);
            make.width.mas_equalTo(kSCALE(120.0));
            make.height.mas_equalTo(kSCALE(70.0));
        }];
        
        [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.operationBtn);
            make.centerY.equalTo(self.operationBtn);
            make.width.mas_equalTo(kSCALE(260.0));
            make.height.mas_equalTo(kSCALE(70.0));
        }];
        
        [self.commentsContainterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.right.equalTo(self.contentLabel.mas_right);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(kSCALE(20.0));
            make.height.mas_equalTo(0.01);
        }];
    
    }
    return self;
}

-(void)setModel:(WXFriendsCircleModel *)model{
    _model = model;
    
    [self.avatorIcon sd_setImageWithURL:[NSURL URLWithString:model.avator]];
    self.nameLabel.text = model.name ?: @"未知";
    self.timeLabel.text = model.createTime;
    
    self.isOperationShow = NO;
    self.operationView.hidden = YES;
    [self.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.operationBtn.mas_left);
    }];
    
    ///1.根据发表文本的有无首先要更新contenLabel的顶部约束 再显示文本内容
    [self updateContentLabelShow];
    
    ///2.根据图片的有无首先要更新图片承载视图顶部约束 再创建图片
    [self.picsContainerView updatePicsContainerImagesWithPics:model.pics constraintView:self.contentLabel];
    
    ///3.根据评论内容的有无首先要更新评论承载视图顶部约束 再创建评论显示
    [self.commentsContainterView updateCommentsContainerViewWithComments:model.comments likes:model.likes constraintView:self.timeLabel];
    
    //这一句的目的就是让评论视图每次都重新绘制背景边框
    //[self.commentsContainterView setNeedsDisplay];
    
}

-(void)updateContentLabelShow{
    
    NSString *content = self.model.content ?: @"";
    if (content.length == 0) {  //如果没有内容 约束上移
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(0.0);
        }];
    }else{
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(kSCALE(10.0));
        }];
    }
    
    self.openBtn.hidden = !(content.length > 45);
    self.openBtn.selected = self.model.isOpen;
    if (content.length > 45 && !self.model.isOpen) {
        content = [content substringWithRange:NSMakeRange(0, 45)];
        content = [content stringByAppendingString:@"..."];
    }
    self.contentLabel.text = content;
}


-(void)openBtnAction:(UIButton *)sender{
    NSInteger tag = sender.tag - 2000;
    if (self.openBtnActionBlock) {
        self.openBtnActionBlock(self,sender,self.model,tag);
    }
    
    if (tag == 1) {
        
        self.isOperationShow = !self.isOperationShow;
        
        if (self.isOperationShow) {
            
            self.operationView.hidden = NO;
            
            [self.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.operationBtn.mas_left).offset(kSCALE(-260.0));
            }];
            
            [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.contentView layoutIfNeeded];
              
            } completion:^(BOOL finished) {
                
            }];
            
        }else{
            
            [self.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.operationBtn.mas_left);
            }];
            
            [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{

                [self.contentView layoutIfNeeded];
        
            } completion:^(BOOL finished) {
                 self.operationView.hidden = YES;
            }];
        }
    }
    
}

+ (void)updateOperationViewShowStatusWithTableView:(UITableView *)tableView currentCell:(WXFriendsCircleCell *)cell{
    
    if (cell == nil) {  //滚动时所有的都清除
        for (WXFriendsCircleCell *aCell in tableView.visibleCells) {
//            aCell.operationView.hidden = YES;
            aCell.isOperationShow = NO;
            [aCell.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(aCell.operationBtn.mas_left);
            }];
            
            [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [aCell.contentView layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                aCell.operationView.hidden = YES;
            }];
        }
        return ;
    }
    
    for (WXFriendsCircleCell *aCell in tableView.visibleCells) {
        if (aCell.isOperationShow && aCell != cell) {
            aCell.operationView.hidden = YES;
            aCell.isOperationShow = NO;
            [aCell.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(aCell.operationBtn.mas_left);
            }];
        }
    }
}

-(UIImageView *)avatorIcon{
    if (_avatorIcon == nil) {
        _avatorIcon = [UIImageView new];
        _avatorIcon.backgroundColor = [UIColor orangeColor];
        _avatorIcon.clipsToBounds = YES;
        _avatorIcon.layer.cornerRadius = kSCALE(50.0);
    }
    return  _avatorIcon;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFontBlod(kSCALE(32.0));
    }
    return _nameLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kFont(kSCALE(26.0));
        _timeLabel.text = @"刚刚";
       // _timeLabel.backgroundColor = [UIColor orangeColor];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}

-(MLLinkLabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[MLLinkLabel alloc] init];
        _contentLabel.font = kFont(kSCALE(30));
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineSpacing = kSCALE(5.0);
        //_contentLabel.adjustsFontForContentSizeCategory = YES;
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _contentLabel;
}

-(UIButton *)openBtn{
    if (_openBtn == nil) {
        _openBtn = [[UIButton alloc] init];
        _openBtn.backgroundColor = [UIColor whiteColor];
        [_openBtn setTitle:@"全文" forState:UIControlStateNormal];
        [_openBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_openBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _openBtn.titleLabel.font = kFont(kSCALE(28.0));
        _openBtn.tag = 2000;
    }
    return _openBtn;
}

-(WXPicsContainerView *)picsContainerView{
    if (_picsContainerView == nil) {
        _picsContainerView = [WXPicsContainerView new];
    }
    return _picsContainerView;
}

-(WXCommentsContainerView *)commentsContainterView{
    if (_commentsContainterView == nil) {
        _commentsContainterView = [WXCommentsContainerView new];
    }
    return _commentsContainterView;
}

-(UIButton *)operationBtn{
    if (_operationBtn == nil) {
        _operationBtn = [[UIButton alloc] init];
        _operationBtn.backgroundColor = [UIColor whiteColor];
        [_operationBtn setImage:[UIImage imageNamed:@"more_gray"] forState:UIControlStateNormal];
        _operationBtn.titleLabel.font = kFont(kSCALE(28.0));
        [_operationBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _operationBtn.tag = 2001;
    }
    return _operationBtn;
}

-(UIView *)operationView{
    if (_operationView == nil) {
        _operationView = [UIView new];
        _operationView.backgroundColor = [UIColor blackColor];
        _operationBtn.clipsToBounds = YES;
        _operationBtn.layer.cornerRadius = kSCALE(5.0);
        _operationView.hidden = YES;
    }
    return _operationView;
}

@end
