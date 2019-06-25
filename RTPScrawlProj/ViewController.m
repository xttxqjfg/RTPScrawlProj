//
//  ViewController.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/15.
//  Copyright © 2019 易博. All rights reserved.
//

#import "ViewController.h"

#import <RongIMKit/RongIMKit.h>
#import "RTPScrawlVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *userListTableView;

@property (nonatomic,strong) NSMutableArray *userListArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.userListTableView];
    [self.userListTableView reloadData];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource --
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"UserListCell"];
    }
    NSDictionary *userDic = (NSDictionary *)[self.userListArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"ID:%@",[userDic objectForKey:@"userid"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"姓名:%@",[userDic objectForKey:@"username"]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *userDic = (NSDictionary *)[self.userListArr objectAtIndex:indexPath.row];
    if ([[userDic objectForKey:@"token"] length] > 0) {
        [[RCIMClient sharedRCIMClient] connectWithToken:[NSString stringWithFormat:@"%@",[userDic objectForKey:@"token"]] success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            dispatch_async(dispatch_get_main_queue(), ^{
                RTPScrawlVC *scrawlVC = [[RTPScrawlVC alloc]init];
                [self presentViewController:scrawlVC animated:YES completion:^{
                    //
                }];
            });
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%d", status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    }
}

- (UITableView *)userListTableView {
    if (!_userListTableView) {
        _userListTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _userListTableView.delegate = self;
        _userListTableView.dataSource = self;
    }
    return _userListTableView;
}

- (NSMutableArray *)userListArr {
    if (!_userListArr) {
        _userListArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RegisterUserList.plist" ofType:nil]];
        
    }
    return _userListArr;
}


@end
