//
//  ViewController.m
//  01-刷新和加载更多
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation ViewController
    static NSString *QYID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QYID];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    tableView.rowHeight = 200;
    _datas = [NSMutableArray arrayWithObjects:@"123",@"1234",@"12345",@"zhangsan ",@"lisi ",@"wangwu", nil];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)loadMoreSource
{
    [_datas addObject:@"吓一跳"];
    [_tableView reloadData];
}
//刷新
-(void)refresh:(UIRefreshControl *)refreshControl{
    [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:3];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QYID forIndexPath:indexPath];
    
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y > (_tableView.contentSize.height - _tableView.frame.size.height) + 100) {
        [self loadMoreSource];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
