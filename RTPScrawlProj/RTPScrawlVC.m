//
//  RTPScrawlVC.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPScrawlVC.h"
#import "RTPScrawlView.h"

@interface RTPScrawlVC ()

@property (nonatomic, strong) RTPScrawlView *scrawlView;


@property (nonatomic, strong) UIButton *undoBtn;

@end

@implementation RTPScrawlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.scrawlView];
    [self.view addSubview:self.undoBtn];
}

- (void)undoBtnClicked:(UIButton *)sender {
    [self.scrawlView undo];
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
        _undoBtn.backgroundColor = [UIColor redColor];
        [_undoBtn addTarget:self action:@selector(undoBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _undoBtn;
}

@end
