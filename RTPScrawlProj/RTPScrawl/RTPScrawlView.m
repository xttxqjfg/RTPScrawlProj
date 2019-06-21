//
//  RTPScrawlView.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPScrawlView.h"
#import "RTPPaintPath.h"

@interface RTPScrawlView()

/**
 *  线条数组
 */
@property (nonatomic, strong) NSMutableArray *linesArr;

/**
 轨迹笔
 */
@property (nonatomic, strong) RTPPaintPath *path;

/**
 
 */
@property (nonatomic, strong) CAShapeLayer *slayer;

@end

@implementation RTPScrawlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

/**
 根据touches集合获取对应的触摸点
 */
- (CGPoint)pointWithTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}


/**
 只允许一个手指绘画
 */
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    if ([event allTouches].count == 1) {
        return YES;
    }
    return NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint startP = [self pointWithTouches:touches];
    
    if ([event allTouches].count == 1) {
        
        RTPPaintPath *path = [RTPPaintPath initRTPPaintPath];
        [path moveToPoint:startP];
        
        _path = path;
        
        CAShapeLayer *slayer = [CAShapeLayer layer];
        slayer.path = path.CGPath;
        slayer.backgroundColor = [UIColor clearColor].CGColor;
        slayer.fillColor = [UIColor clearColor].CGColor;
        slayer.lineCap = kCALineCapRound;
        slayer.lineJoin = kCALineJoinRound;
        slayer.strokeColor = [UIColor blackColor].CGColor;
        slayer.lineWidth = path.lineWidth;
        [self.layer addSublayer:slayer];
        _slayer = slayer;
        [[self mutableArrayValueForKey:@"linesArr"] addObject:_slayer];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取移动点
    CGPoint moveP = [self pointWithTouches:touches];
    if ([event allTouches].count > 1) {
        [self.superview touchesMoved:touches withEvent:event];
    }
    else if ([event allTouches].count == 1) {
        [_path addLineToPoint:moveP];
        _slayer.path = _path.CGPath;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([event allTouches].count > 1) {
        [self.superview touchesMoved:touches withEvent:event];
    }
}

/**
 *  画线
 */
- (void)drawLine {
    [self.layer addSublayer:self.linesArr.lastObject];
}
/**
 *  清屏
 */
- (void)clearAllPaint {
    if (!self.linesArr.count) return ;
    
    [self.linesArr makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [[self mutableArrayValueForKey:@"linesArr"] removeAllObjects];
}

/**
 *  撤销
 */
- (void)undo {
    //当前屏幕已经清空，就不能撤销了
    if (!self.linesArr.count) return;
    [self.linesArr.lastObject removeFromSuperlayer];
    [[self mutableArrayValueForKey:@"linesArr"] removeLastObject];
}

#pragma mark -- get
- (NSMutableArray *)linesArr {
    if (!_linesArr) {
        _linesArr = [[NSMutableArray alloc]init];
    }
    return _linesArr;
}

@end
