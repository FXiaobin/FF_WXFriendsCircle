//
//  FriendsCircleCell_02.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "FriendsCircleCell_02.h"
#import "PicsContainerView.h"
#import "CommentsContainerView.h"

@interface FriendsCircleCell_02 ()


@property (nonatomic,strong) UIImageView *avatorIcon;

@property (nonatomic,strong) UILabel *nameLabel;


@property (nonatomic,strong) UILabel *timeLabel;


@property (nonatomic,strong) MLLinkLabel *contentLabel;

@property (nonatomic,strong) UIButton *openBtn;

@property (nonatomic,strong) PicsContainerView *picsContainerView;


@property (nonatomic,strong) CommentsContainerView *commentsContainterView;



@property (nonatomic,strong) UIButton *commentBtn;

@property (nonatomic,strong) UIButton *collectionBtn;

@property (nonatomic,strong) UIButton *likeBtn;

@end

@implementation FriendsCircleCell_02

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
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.picsContainerView];
        [self.contentView addSubview:self.commentsContainterView];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.collectionBtn];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.openBtn];
        
        [self.avatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self.contentView).offset(kSCALE(30.0));
            make.width.and.height.mas_equalTo(kSCALE(100.0));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatorIcon.mas_right).offset(kSCALE(20.0));
            make.top.equalTo(self.avatorIcon.mas_top).offset(kSCALE(5.0));
            make.width.mas_lessThanOrEqualTo(kSCALE(300.0));
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.avatorIcon.mas_bottom).offset(kSCALE(-5.0));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatorIcon);
            make.top.equalTo(self.avatorIcon.mas_bottom).offset(kSCALE(20.0));
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
            make.right.equalTo(self.contentLabel.mas_right);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(kSCALE(20.0));
            make.height.mas_equalTo(0.01);
        }];
        
        [self.commentsContainterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.right.equalTo(self.contentLabel.mas_right);
            make.top.equalTo(self.picsContainerView.mas_bottom).offset(kSCALE(20.0));
            make.height.mas_equalTo(0.01);
        }];

        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picsContainerView);
            //make.top.equalTo(self.picsContainerView.mas_bottom).offset(kSCALE(20.0));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(kSCALE(-20.0));
            make.width.mas_equalTo(kSCALE(200.0));
            make.height.mas_equalTo(kSCALE(80.0));
        }];
        
        [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.commentBtn);
            make.width.mas_equalTo(kSCALE(200.0));
            make.height.mas_equalTo(kSCALE(80.0));
        }];
        
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.picsContainerView.mas_right);
            make.centerY.equalTo(self.commentBtn);
            make.width.mas_equalTo(kSCALE(200.0));
            make.height.mas_equalTo(kSCALE(80.0));
        }];
        
        
    }
    return self;
}

-(void)setModel01:(FriendsCirlceModel *)model01{
    _model01 = model01;
    
    [self.avatorIcon sd_setImageWithURL:[NSURL URLWithString:model01.avator]];
    self.nameLabel.text = model01.name;
    self.timeLabel.text = model01.createTime;
    
    NSString *content = model01.content;
    
    self.openBtn.hidden = !(content.length > 65);
    self.openBtn.selected = model01.isOpen;
    if (content.length > 65 && !model01.isOpen) {
        content = [content substringWithRange:NSMakeRange(0, 65)];
        content = [content stringByAppendingString:@"..."];
    }
    self.contentLabel.text = content;
    
    [self.picsContainerView updatePicsContainerImagesWithPics:model01.pics constraintView:self.contentLabel];
    
    [self.commentsContainterView updateCommentsContainerViewWithComments:model01.comments constraintView:self.picsContainerView];
    
}



-(void)openBtnAction:(UIButton *)sender{
    if (self.openBtnActionBlock) {
        self.openBtnActionBlock(sender,self.model01);
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
    }
    return _openBtn;
}

-(PicsContainerView *)picsContainerView{
    if (_picsContainerView == nil) {
        _picsContainerView = [PicsContainerView new];
    }
    return _picsContainerView;
}

-(CommentsContainerView *)commentsContainterView{
    if (_commentsContainterView == nil) {
        _commentsContainterView = [CommentsContainerView new];
    }
    return _commentsContainterView;
}

-(UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [[UIButton alloc] init];
        _commentBtn.backgroundColor = [UIColor orangeColor];
        [_commentBtn setTitle:@"评论（9）" forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = kFont(kSCALE(28.0));
    }
    return _commentBtn;
}

-(UIButton *)collectionBtn{
    if (_collectionBtn == nil) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor orangeColor];
        [_collectionBtn setTitle:@"收藏（18）" forState:UIControlStateNormal];
        _collectionBtn.titleLabel.font = kFont(kSCALE(28.0));
    }
    return _collectionBtn;
}

-(UIButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [[UIButton alloc] init];
        _likeBtn.backgroundColor = [UIColor orangeColor];
        [_likeBtn setTitle:@"点赞（27）" forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = kFont(kSCALE(28.0));
    }
    return _likeBtn;
}
@end
