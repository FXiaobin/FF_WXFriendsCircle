//
//  FriendsCircleViewController.m
//  FF_WXFriendsCircle
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "FriendsCircleViewController.h"
#import "FriendsCirlceModel.h"
#import "FriendsCircleCell_02.h"

@interface FriendsCircleViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;



@end

@implementation FriendsCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"朋友圈";
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    [self.view addSubview:self.tableView];
    
    
    [self loadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsCirlceModel *model = self.dataArr[indexPath.row];
    return model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    FriendsCircleCell_02 *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCircleCell_02" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    FriendsCirlceModel *model = self.dataArr[indexPath.row];
    cell.model01 = model;


    cell.openBtnActionBlock = ^(UIButton * _Nonnull sender,FriendsCirlceModel *aModel) {
        aModel.isOpen = !aModel.isOpen;
        sender.selected = aModel.isOpen;
        [tableView reloadData];
    };

    return cell;
    
}

-(void)loadData{
    
    
    NSArray *names = @[@"醉卧浮生的体育世界",@"界面新闻",@"中国日报网",@"每日经济新闻",@"机智玩机机"];
    NSArray *comments = @[@"小红 回复 小胡:我的天啊，你说的是真的吗？",@"小胡 回复 小红:当然是真的了，难道你不相信我？我真是看错你了！",@"小红 回复 小胡:呃呃呃，不要生气啊，我就是问一下而已，嘿嘿嘿~~~",@"小华 回复 小胡: 哈哈哈哈，小胡啊，你好怂啊！",@"小胡 回复 小华: 你懂什么？这是爱情啊，哈哈，你个这个小屁孩懂什么？好好读书吧，等你长大了就知道了！",@"小华 回复 小胡: 你说的是真的吗？我才不行你，你就是个大怂包，哈哈哈哈哈"];
    //NSArray *comments = @[];
    NSArray *avators = @[@"https://timg01.bdimg.com/timg?pacompress=&imgtype=0&sec=1439619614&autorotate=1&di=8c1a16bf3fa12ed277f409e6891a9bd9&quality=90&size=b200_200&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2F57a566e2f54ea104c17a07d5337bd166.jpeg",
                         @"https://timg01.bdimg.com/timg?pacompress=&imgtype=0&sec=1439619614&autorotate=1&di=36ce089c01f39da8076bf66f9c849756&quality=90&size=b200_200&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2F8988248fada6af139bf2d8764a9c0b1c.jpeg",
                         @"https://timg01.bdimg.com/timg?pacompress=&imgtype=3&sec=1439619614&autorotate=1&di=e7c056d54284d607ca52d198ba6c211b&quality=90&size=b200_200&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2Fde95322c932202b06a4c755b54576a9a.png",
                         @"https://timg01.bdimg.com/timg?pacompress&imgtype=0&sec=1439619614&autorotate=1&di=f658cd3051a2cddbe869470b061365e0&quality=90&size=b200_200&src=http%3A%2F%2Fbos.nj.bpc.baidu.com%2Fv1%2Fmediaspot%2F5d7b706ec28fd38e85a742c74b29dbf0.jpeg",
                         @"https://timg01.bdimg.com/timg?pacompress&imgtype=3&sec=1439619614&autorotate=1&di=2038a0dceb2ed8eabb233824a9b00958&quality=90&size=b870_10000&src=http%3A%2F%2Fbos.nj.bpc.baidu.com%2Fv1%2Fmediaspot%2Fa55a8b496b1b60c66a3f419075eb270d.png"];
    NSArray *contents = @[@"法网第12冠！纳达尔3-1胜蒂姆再创历史 夺第18座大满贯剑指费德勒",
                          @"中国人民银行周一发布数据显示，截至5月末，中国外汇储备规模为31010.04亿美元，环比增加60.51亿美元。此外，5月，央行还增持51万盎司黄金至6161万盎司，为连续第6个月增持。",
                          @"6月9日，旅客在天津西站候车大厅排队等候。 据悉，全国铁路9日迎来端午小长假返程客流高峰，预计发送旅客1370万人次，加开旅客列车889列。 新华社发（杨宝森摄）",
                          @"城乡居民医保个人账户将在明年内取消！医保局这段解释关系到你的福利",
                          @"从第一款iPhone发布一直以来，安卓手机就开始走上了跟随苹果的道路，长达十年的时间直至今日，安卓手机依然不停的致敬（抄袭）着苹果。苹果在iPhone上做的每一件事，都被这些追随者视为绝对正确。比如刘海屏，砍掉耳机孔，大白带天线等。"];
    NSArray *times = @[@"06-10 00:16",@"06-10 08:09",@"06-09 21:35",@"06-10 07:08",@"06-09 23:30"];
    NSArray *pictures = @[@[@"https://pics3.baidu.com/feed/18d8bc3eb13533fae539a838ee91091b40345bdb.png?token=af96d383e61c401bb2d186f5e2c3253c&s=7B95D7A214310D9C82A654B00300501A",
                            @"https://pics1.baidu.com/feed/1c950a7b02087bf45494e9fdb491a32811dfcf75.png?token=baf1b33ceb6718adcc1aadb2a77ffd1b&s=03E260A502060753D63578890300B082",
                            @"https://pics1.baidu.com/feed/eaf81a4c510fd9f9aaddf7d0636f202e2934a40c.png?token=c46a7d5a676dc5196d28586e75056533&s=CA8068855E1246D09A197057030050D0",@"https://pics0.baidu.com/feed/50da81cb39dbb6fd02e8818c4f665f1c962b37ab.png?token=ac8ab006ca9bb1df8ebd47b6612bd7b2&s=6DD008C666D625D64D0099380300C093",@"https://pics7.baidu.com/feed/83025aafa40f4bfb9c1afa84450d8cf4f53618da.png?token=e07ccd935344ccb8e832eaeee419464d&s=4AB21AC5066777151E888F690300B053",@"https://pics2.baidu.com/feed/d000baa1cd11728bda8b563e8ebe37cac2fd2ccb.png?token=28f576e84b168e9a8ffd7936e59a40be&s=2BE0408544462B43520DA89C0300B083"],
                          @[@"https://pics0.baidu.com/feed/d6ca7bcb0a46f21fd71925c26fbf9f640d33ae96.jpeg?token=b05e1962117b5c900337a196f65ef8a1&s=E28761A418532ECC6A2DE0830300408C"],
                          @[@"https://pics7.baidu.com/feed/95eef01f3a292df552383d1ff137a86435a873c8.jpeg?token=a3df6b07c45d83442646a1fd7850e102&s=7724AEE1D2EC88EE4AA5EC890300B093",@"https://pics0.baidu.com/feed/203fb80e7bec54e7e54545bff63e6f544ec26af5.jpeg?token=0a96414e94a59982cbaa9482019f423f&s=6E96448D44C518FA4D0D7D810300B080",@"https://pics2.baidu.com/feed/35a85edf8db1cb131d92045c9752a24a93584b94.jpeg?token=6d17cac296e1f456c90cf9506b3e2f20&s=F8E6A144EE0318DEB78DF89903005091",@"https://pics1.baidu.com/feed/f9198618367adab4b80ff37ac0d247188701e43c.jpeg?token=caf519be6666d14534b4e2916d97caeb&s=3692D9A40E33A1EF4485D59003007093",@"https://pics3.baidu.com/feed/b7003af33a87e950a0e04c565b3ea747fbf2b424.jpeg?token=26484f01a3dd4452e2fce2cf5eba4790&s=5C14499D46467CEC1620D1C20300B0B3",@"https://pics4.baidu.com/feed/bba1cd11728b4710bf5ab7c18dc837f9fc032354.jpeg?token=b89d75f964d726014e37de013683d1e8&s=7986209CCC9738D80C1754820300208A",@"https://pics0.baidu.com/feed/e4dde71190ef76c6c6462c20c91009feaf516734.jpeg?token=9063b6365600de779418496fd485c5d1&s=1F145C846413F7EF1C884D17030080B3",@"https://pics7.baidu.com/feed/0df431adcbef7609f0bedb6a60db57c87dd99e9d.jpeg?token=49b9a5f6061f7f3c3cb67ff9cda7001c&s=4A00218855431EE85C690D8703009082",@"https://pics4.baidu.com/feed/a8ec8a13632762d0d52d5919eeeafcfe513dc614.jpeg?token=2fa67b07112e55b5da7cc6717c378dd9&s=AB3251855E032ACA7408259603008082"],
                          @[@"https://pics7.baidu.com/feed/8c1001e93901213fcefd72995e6fc2d52e2e9531.jpeg?token=b5d5fdeea1cc9a20c16a8e72311b5e84&s=EB43CE1A1CA87C01345A18D90300D0B0",@"https://pics0.baidu.com/feed/b64543a98226cffc67ef0f2bb789be94f403eaeb.jpeg?token=12ea17c5a143a7a93d1739f9b80f00a3&s=3FD6C9160723771302E1D4CF03004025",@"https://pics3.baidu.com/feed/8ad4b31c8701a18b8d0c2b0094a7f30c2938fe22.jpeg?token=d404f7d91a71598990f9e96910a8c7dc&s=BE20618116500DCA42297DD90300C092",@"https://pics3.baidu.com/feed/b58f8c5494eef01f5b5e1bd8ea766d21bd317df5.jpeg?token=4881df8ce31f317f4ca1f69125583f26&s=7FEFA856B3F04592504CBBFF0300502D"],
                          @[@"https://pics5.baidu.com/feed/b90e7bec54e736d1d596d8cda94fbbc6d4626916.jpeg?token=31febbf48b8eb2abbbff4b8cb79f149a&s=4F20BB470E5231E5009508AA03003012",@"https://pics7.baidu.com/feed/2cf5e0fe9925bc31ca9ee83b6ac079b5ca137072.jpeg?token=437aa756153d9953f63fc9323de6b88c&s=A5C1B75986B21F9A4B9DC05D0300C0F6",@"https://pics3.baidu.com/feed/ac6eddc451da81cb6e13eaa76079241208243182.jpeg?token=df1b724ba03745d953df3324baeb8b11&s=F73455CB01330D9EE0D571390300C040"]
                          ];
    
    //pictures = @[@[],@[],@[],@[],@[]];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"name"] = names[i];
        dic[@"avator"] = avators[i];
        dic[@"content"] = contents[i];
        dic[@"createTime"] = times[i];
        dic[@"pics"] = pictures[i];
        [array addObject:dic];
    }
    
    for (int i = 0; i < 3; i++) {
        NSInteger index = arc4random() % 5;
        NSDictionary *dic = array[index];
        
        FriendsCirlceModel *model = [FriendsCirlceModel new];
        model.name = dic[@"name"];
        model.avator = dic[@"avator"];
        model.content = dic[@"content"];
        model.createTime = dic[@"createTime"];
        model.pics = dic[@"pics"];
        model.comments = comments;
        
        [self.dataArr addObject:model];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    });
    
}

#pragma mark -- Lazy
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight([UIScreen mainScreen].bounds) - 64.0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[FriendsCircleCell_02 class] forCellReuseIdentifier:@"FriendsCircleCell_02"];

        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArr removeAllObjects];
            [self loadData];
        }];
        _tableView.mj_header = header;
        
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadData];
        }];
        _tableView.mj_footer = footer;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0.0;
            _tableView.estimatedSectionHeaderHeight = 0.0;
            _tableView.estimatedRowHeight = 0.0;    //防止刷新抖动
           
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
