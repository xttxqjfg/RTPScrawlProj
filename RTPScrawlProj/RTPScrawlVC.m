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

@end

@implementation RTPScrawlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.scrawlView addObserver:self forKeyPath:@"linesArr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self.view addSubview:self.scrawlView];
}

- (RTPScrawlView *)scrawlView {
    if (!_scrawlView) {
        _scrawlView = [[RTPScrawlView alloc] initWithFrame:self.view.bounds];
        _scrawlView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    return _scrawlView;
}
@end
