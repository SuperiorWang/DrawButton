//
//  JBDrawView.m
//  DrawButton
//
//  Created by Mac on 14-3-11.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "JBDrawView.h"
#define Space 100

CGFloat const JBUpdateUTFrequency = 1. / 25.;

@implementation JBDrawView{
    float _side;    //正方形的边
    float _storeWidth; //描边宽度
    CGColorRef _storeColor; //描边颜色
    CGColorRef _circleBgColor;//circle底色
    CGFloat _circleWidth;//circle宽度
    UIButton *_iconButton;
    UIColor *_circleColor;//设置Circle的颜色
    CGFloat _progress; //进度
    NSTimer *_timer;    //定时器
    CGFloat _sapceSpeed;//进度间隔
    UIImageView *_targetIcon;//小三角的图标
    UILabel *_label;  //显示数值的文本
    UIView *_coverView;
    id _target; // 目标
    SEL _action; //动作
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    if (self.frame.size.width < self.frame.size.height )
        _side = self.frame.size.width;
    else
        _side = self.frame.size.height;
    
    self.backgroundColor = [UIColor redColor];
    
    const float lightbule[] = {111.0/255.0,188.0/255.0,137.0/255.0,1.0f};
    _storeColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), lightbule);
    
    _storeWidth = 2.0f;
    
    _circleWidth = 20.0f;
    
    _circleBgColor = [UIColor whiteColor].CGColor;
    
    if (!_iconButton) {
        CGRect iconFrame = CGRectMake(0+ _storeWidth + _circleWidth, 0 + _storeWidth + _circleWidth, _side - _storeWidth*2 -_circleWidth*2 , _side - _storeWidth*2 - _circleWidth*2);
        _iconButton = [[UIButton alloc]initWithFrame:iconFrame];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"main-food"] forState:UIControlStateNormal];
        [self addSubview:_iconButton];
    }
    
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    _action = action;
    _target = target;
}
-(void)drawRect:(CGRect)rect
{
    //绘制最外面的一圈细圆框
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, _side, _side));
    CGContextSetFillColorWithColor(context, _storeColor);
    CGContextFillPath(context);
    //绘制进度条背景
    CGContextAddEllipseInRect(context, CGRectMake(0 + _storeWidth, 0 + _storeWidth, _side - _storeWidth*2 , _side - _storeWidth*2 ));
    CGContextSetFillColorWithColor(context, _circleBgColor);
    CGContextFillPath(context);
    //进度条
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_side /2, _side /2) radius:_side/2-_storeWidth-_circleWidth/2 startAngle:(CGFloat) -M_PI_2 endAngle:(CGFloat)(-M_PI_2 + _progress*2*M_PI) clockwise:YES];
    [_circleColor setStroke];
    progressCircle.lineWidth = _circleWidth;
    [progressCircle stroke];
    
}

//设置进度条的颜色
- (void)setCircleColor:(UIColor*)color
{
    _circleColor = color;
    [self setNeedsDisplay];
}

//设置进度条的背景色
- (void)setCircleBgColor:(CGColorRef)cgColor
{
    _circleBgColor = cgColor;
    [self setNeedsDisplay];
}

//设置Button的背景图片
- (void)setButtonImage:(NSString*)imageName
{
    [_iconButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

//设置进度
- (void)updateProgressCircle:(CGFloat)progress
{
    _progress = 0;
    
    _targetIcon.frame = CGRectZero;
    
    _label.frame = CGRectZero;
    
    _coverView = nil;
    
    _targetIcon = nil;
    
    _label = nil;
    
    _sapceSpeed = progress / Space;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:JBUpdateUTFrequency target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)update
{
    if (_progress < _sapceSpeed * Space) {
        _progress += _sapceSpeed;
    }else{
        if (!_coverView) {
            _coverView = [[UIView alloc]initWithFrame:CGRectMake(0 + _storeWidth + _circleWidth, 0  + _storeWidth + _circleWidth, _side - _storeWidth*2 -_circleWidth*2 , _side - _storeWidth*2 - _circleWidth*2)];
            _coverView.backgroundColor = [UIColor clearColor];
            [self addSubview:_coverView];
        }
        
//        if (!_targetIcon) {
//            //加三角形图标
//            _targetIcon = [[UIImageView alloc]init];
//            _targetIcon.frame = CGRectMake(_coverView.frame.size.width/2 - 7.5, 0, 0, 0);
//            [_coverView addSubview:_targetIcon];
//            [UIView animateWithDuration:1.0 animations:^{
//                _targetIcon.frame = CGRectMake(_coverView.frame.size.width/2 - 7.5, 0, 15, 15);
//                _targetIcon.image = [UIImage imageNamed:@"triangleIcon"];
//            }];
//        }
//        //加入文本
//        if (!_label) {
//            _label = [[UILabel alloc]init];
//            _label.frame = CGRectMake(_coverView.frame.size.width/2 - 25 , 15, 0, 0);
//            _label.text = @"455";
//            _label.textAlignment = NSTextAlignmentCenter;
//            _label.textColor = [UIColor colorWithRed:164./255. green:179./255. blue:172./255. alpha:1.0];
//            [_coverView addSubview:_label];
//            [UIView animateWithDuration:1.5 animations:^{
//                _label.frame = CGRectMake(_coverView.frame.size.width/2 - 25 , 15, 50, 20);
//            }];
//        }
        
        
        //淡入淡出的效果
        if (!_targetIcon) {
            //加三角形图标
            _targetIcon = [[UIImageView alloc]init];
            _targetIcon.frame = CGRectMake(_coverView.frame.size.width/2 - 7.5, 0, 15, 15);
            _targetIcon.alpha = 0.;
            [_coverView addSubview:_targetIcon];
            [UIView animateWithDuration:2.0 animations:^{
                _targetIcon.image = [UIImage imageNamed:@"triangleIcon"];
                _targetIcon.alpha = 1.;
            }];
        }
        //加入文本
        if (!_label) {
            _label = [[UILabel alloc]init];
            _label.frame = CGRectMake(_coverView.frame.size.width/2 - 25 , 15, 50, 20);
            _label.font = [UIFont boldSystemFontOfSize:12];
            _label.alpha = 0.;
            _label.text = @"455";
            _label.textAlignment = NSTextAlignmentCenter;
            _label.textColor = [UIColor colorWithRed:164./255. green:179./255. blue:172./255. alpha:1.0];
            [_coverView addSubview:_label];
            [UIView animateWithDuration:2.5 animations:^{
                _label.alpha = 1.;
            }];
        }
        
        
        _label.transform = CGAffineTransformMakeRotation(-_progress * M_PI *2);
        _coverView.transform = CGAffineTransformMakeRotation(_progress * M_PI*2);
        
        [_timer invalidate];
    }
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_target performSelector:_action];
    #pragma clang diagnostic pop
}
@end
