//
//  ViewController.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "ViewController.h"
#import "FriendsCircleViewController.h"
#import "FeedListViewController.h"
#import "WXFriendsCirlceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"跳转->不带评论" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showFriendsCircleViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1000;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"跳转->有评论" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(showFriendsCircleViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1001;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 200, 40)];
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"微信朋友圈" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(showFriendsCircleViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1002;
    [self.view addSubview:btn2];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];;
    
}

-(void)showFriendsCircleViewController:(UIButton *)sender{
    NSInteger tag = sender.tag - 1000;
    if (tag == 0) {
        FeedListViewController *vc = [[FeedListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (tag == 1) {
        FriendsCircleViewController *vc = [[FriendsCircleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (tag == 2) {
        WXFriendsCirlceViewController *vc = [[WXFriendsCirlceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
}

@end
