//
//  RTPScrawlVC.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPScrawlVC.h"
#import "RTPScrawlView.h"
#import <RongIMKit/RongIMKit.h>
#import "RTPMessageHandle.h"

@interface RTPScrawlVC ()<RCIMReceiveMessageDelegate>

@property (nonatomic, strong) RTPScrawlView *scrawlView;


@property (nonatomic, strong) UIButton *undoBtn;

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation RTPScrawlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    [self.view addSubview:self.scrawlView];
    [self.view addSubview:self.undoBtn];
    [self.view addSubview:self.closeBtn];
}

- (void)undoBtnClicked:(UIButton *)sender {
    [self.scrawlView undo];
}

- (void)closeBtnClicked:(UIButton *)sender {
    //注销融云连接
    [[RCIM sharedRCIM] logout];
    
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        [self.scrawlView drawLineWithPathData:testMessage.content];
    }
    
    NSLog(@"还剩余的未接收的消息数：%d", left);
}

- (RTPScrawlView *)scrawlView {
    if (!_scrawlView) {
        _scrawlView = [[RTPScrawlView alloc] initWithFrame:CGRectMake(50.0, 50.0, 700.0, 700.0)];
        _scrawlView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    return _scrawlView;
}

- (UIButton *)undoBtn {
    if (!_undoBtn) {
        _undoBtn = [[UIButton alloc]initWithFrame:CGRectMake(900, 50, 100, 50)];
        [_undoBtn setTitle:@"撤回" forState:(UIControlStateNormal)];
        _undoBtn.backgroundColor = [UIColor redColor];
        [_undoBtn addTarget:self action:@selector(undoBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _undoBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(900, 150, 100, 50)];
        [_closeBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
        _closeBtn.backgroundColor = [UIColor redColor];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}

@end
