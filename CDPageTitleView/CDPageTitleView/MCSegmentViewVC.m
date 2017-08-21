//
//  MCSegmentViewVC.m
//  CDPageTitleView
//
//  Created by Genius on 18/08/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

#import "MCSegmentViewVC.h"
#import <YYKit.h>
#import "MCPageView.h"
#import "ViewController.h"
#import "MJRefresh.h"


@interface MCSegmentViewVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayM;
@end

@implementation MCSegmentViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayM = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"viewDidLoad");
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.sectionFooterHeight = 10.f;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 30, 0);
    self.tableView.contentOffset = CGPointMake(0, -10);
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 40;
    [self.view addSubview:self.tableView];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSObject *obj = [NSObject new];
            [self.arrayM removeAllObjects];
            
            for (int i = 0; i < 20; i++) {
                [self.arrayM addObject:obj];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromNet)];
    footer.automaticallyHidden = YES;
    footer.triggerAutomaticallyRefreshPercent = -1.0f;
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadDataFromNet {
    [self.arrayM addObjectsFromArray:self.arrayM.copy];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}













@end
