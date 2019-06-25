//
//  RTPScrawlView.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPScrawlView.h"
#import "RTPPaintPath.h"

#import "RTPPathMessage.h"
#import "RTPMessageHandle.h"

@interface RTPScrawlView()

/**
 *  线条layer数组
 */
@property (nonatomic, strong) NSMutableArray *pathLinesArr;

/**
 当前正在绘画的轨迹笔
 */
@property (nonatomic, strong) RTPPaintPath *path;

/**
 当前正在绘画的轨迹坐标点集合
 */
@property (nonatomic, strong) NSMutableArray *pointArr;

/**
 单个轨迹承载的layer
 */
@property (nonatomic, strong) CAShapeLayer *slayer;

@end

@implementation RTPScrawlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        backImageView.image = [UIImage imageNamed:@"20190625001"];
        backImageView.userInteractionEnabled = YES;
        [self addSubview:backImageView];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint startP = [self pointWithTouches:touches];
    
    if ([event allTouches].count == 1) {
        
        RTPPaintPath *path = [RTPPaintPath initRTPPaintPath];
        [path moveToPoint:startP];
        [self.pointArr removeAllObjects];
        [self.pointArr addObject:@{@"x":[NSString stringWithFormat:@"%f",startP.x],@"y":[NSString stringWithFormat:@"%f",startP.y]}];
        
        _path = path;
        
        CAShapeLayer *slayer = [CAShapeLayer layer];
        slayer.path = path.CGPath;
        slayer.backgroundColor = [UIColor clearColor].CGColor;
        slayer.fillColor = [UIColor clearColor].CGColor;
        slayer.lineCap = kCALineCapRound;
        slayer.lineJoin = kCALineJoinRound;
        slayer.strokeColor = [UIColor redColor].CGColor;
        slayer.lineWidth = path.lineWidth;
        [self.layer addSublayer:slayer];
        _slayer = slayer;
        [[self mutableArrayValueForKey:@"pathLinesArr"] addObject:_slayer];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取移动点
    CGPoint moveP = [self pointWithTouches:touches];
    if ([event allTouches].count == 1) {
        //超出绘画区域则直接跳过
        if(CGRectContainsPoint(self.bounds, moveP)) {
            [_path addLineToPoint:moveP];
            [self.pointArr addObject:@{@"x":[NSString stringWithFormat:@"%f",moveP.x],@"y":[NSString stringWithFormat:@"%f",moveP.y]}];
            _slayer.path = _path.CGPath;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"---- touchesEnded --- %@",self.pointArr);
    RTPPathMessage *pathMessage = [[RTPPathMessage alloc]init];
    [[RTPMessageHandle shareInstance] sendMessage:(RTPMessageType_PATH) content:[pathMessage messageWithContent:self.pointArr size:self.bounds.size]];
}

/**
 *  画线
 */
- (void)drawLineWithPathData:(NSString *)jsonStr {
    //收到的json转换成字典数据
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *pathDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if(pathDic && [pathDic objectForKey:@"message_content"] && [[pathDic objectForKey:@"message_content"] isKindOfClass:[NSArray class]]) {
        
        NSArray *pathArr = [[NSArray alloc]initWithArray:[pathDic objectForKey:@"message_content"]];

        //不同屏幕适配的宽高比
        CGFloat widthScale = self.bounds.size.width / [[[pathDic objectForKey:@"layer_size"] objectForKey:@"width"] floatValue];
        CGFloat heightScale = self.bounds.size.height / [[[pathDic objectForKey:@"layer_size"] objectForKey:@"height"] floatValue];
        
        CGPoint startP = CGPointMake([[[pathArr firstObject] objectForKey:@"x"] floatValue] * widthScale, [[[pathArr firstObject] objectForKey:@"y"] floatValue] * heightScale);
        RTPPaintPath *path = [RTPPaintPath initRTPPaintPath];
        [path moveToPoint:startP];
        
        for (NSInteger i = 1; i < pathArr.count; i++) {
            CGPoint moveP = CGPointMake([[[pathArr objectAtIndex:i] objectForKey:@"x"] floatValue] * widthScale, [[[pathArr objectAtIndex:i] objectForKey:@"y"] floatValue] * heightScale);
            [path addLineToPoint:moveP];
        }
        _path = path;
        
        CAShapeLayer *slayer = [CAShapeLayer layer];
        slayer.path = path.CGPath;
        slayer.backgroundColor = [UIColor clearColor].CGColor;
        slayer.fillColor = [UIColor clearColor].CGColor;
        slayer.lineCap = kCALineCapRound;
        slayer.lineJoin = kCALineJoinRound;
        slayer.strokeColor = [UIColor redColor].CGColor;
        slayer.lineWidth = path.lineWidth;
        _slayer = slayer;
        [self.pathLinesArr addObject:_slayer];
        //主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.layer addSublayer:self.slayer];
        });
    }
}

/**
 *  清屏
 */
- (void)clearAllPaint {
    if (!self.pathLinesArr.count) return ;
    
    [self.pathLinesArr makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [[self mutableArrayValueForKey:@"pathLinesArr"] removeAllObjects];
}

/**
 *  撤销
 */
- (void)undo {
    //当前屏幕已经清空，就不能撤销了
    if (!self.pathLinesArr.count) return;
    [self.pathLinesArr.lastObject removeFromSuperlayer];
    [[self mutableArrayValueForKey:@"pathLinesArr"] removeLastObject];
}

#pragma mark -- get
- (NSMutableArray *)pathLinesArr {
    if (!_pathLinesArr) {
        _pathLinesArr = [[NSMutableArray alloc]init];
    }
    return _pathLinesArr;
}

- (NSMutableArray *)pointArr {
    if (!_pointArr) {
        _pointArr = [[NSMutableArray alloc]init];
    }
    return _pointArr;
}

@end
