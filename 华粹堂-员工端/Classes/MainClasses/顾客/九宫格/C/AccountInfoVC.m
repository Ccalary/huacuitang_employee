//
//  AccountInfoVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  账户信息

#import "AccountInfoVC.h"
#import "AccountTableViewCell.h"
#import "AccountInfoDetailVC.h"
#import "HCTConnet.h"
@interface AccountInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation AccountInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户信息";
    if (!self.dataArray){
        _dataArray = [NSMutableArray array];
    }
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)drawView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
//    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountTableViewCell *cell = [AccountTableViewCell cellWithTableView:self.tableView];
    AccountModel *model = [[AccountModel alloc]init];
    model = self.dataArray[indexPath.row];
    cell.leftLabel.text = model.goods_name;
    cell.rightLabel.text = model.balance.description;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountInfoDetailVC *vc = [[AccountInfoDetailVC alloc] init];
    vc.model = self.dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//getCustomerAccountInfo

#pragma mark - ====网络====
- (void)requestData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setValue:self.model.c_id forKey:@"customerId"];
    [params setValue:self.YongHuId forKey:@"customerId"];
   
    
    [HCTConnet getCustomerAccountInfo:params success:^(id responseObject) {
        
//        self.model = [AccountModel mj_objectWithKeyValues:responseObject];
        
        DLog(@"%@",responseObject);
        for (NSDictionary *dic in responseObject) {
            AccountModel *model = [[AccountModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            DLog(@"___%@",dic);
            DLog(@"________%lu",(unsigned long)self.dataArray.count);

        }
        [self.tableView reloadData];

    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

    }];
}


@end
