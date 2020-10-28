//
//  BatteryCircleView.m
//  TestDome
//
//  Created by suhengxian on 2020/9/10.
//  Copyright © 2020 suhengxian. All rights reserved.
//

#import "BatteryCircleView.h"

@interface BatteryCircleView ()
{
    CGFloat _lineHeight;
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _lineWidth;
    UIColor *_normalLineColor;
    UIColor *_selectLineColor;
    CGFloat _percent;
}
Strong UILabel *centerLab;
Strong UILabel *valueLab;

@end

@implementation BatteryCircleView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
      CAShapeLayer *shapeLayer = [CAShapeLayer layer];
      shapeLayer.frame = self.bounds;
      
      CGFloat W;
      if (self.frame.size.width > self.frame.size.height) {
          W = self.frame.size.height;
      }else{
          W = self.frame.size.width;
      }
      CGPoint centerPoint = CGPointMake(W/2.0,W/2.0);
      
      CGFloat circleRadius = (W-self.lineWidth)/2.0;
      
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:circleRadius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
      shapeLayer.path = path.CGPath;
      shapeLayer.fillColor = [UIColor clearColor].CGColor;
      shapeLayer.lineWidth = self.lineWidth;
      shapeLayer.strokeColor = self.normalLineColor.CGColor;

      //每个虚线长度为4，间隔为4
      NSArray *lineDashPattern = @[@(self.lineHeight),@(6)];
      shapeLayer.lineDashPattern = lineDashPattern;

      CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
      shapeLayer2.frame = self.bounds;
      UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:circleRadius startAngle:self.startAngle endAngle:(2*M_PI - (self.startAngle - self.endAngle)) *self.percent + self.startAngle clockwise:YES];
    
      shapeLayer2.path = path2.CGPath;
      shapeLayer2.fillColor = [UIColor clearColor].CGColor;
      shapeLayer2.lineWidth = self.lineWidth;
      shapeLayer2.strokeColor = self.selectLineColor.CGColor;

      shapeLayer2.lineDashPattern = lineDashPattern;
      
      [self.layer addSublayer:shapeLayer];
      [self.layer addSublayer:shapeLayer2];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self commit];
    }
    return self;
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = _bgColor;
}

-(void)setPercent:(CGFloat)percent{
    _percent = percent;
    if (_percent == 0) {
        self.valueLab.text = ChinaAndEnglish(@"didnotget");
        self.valueLab.textColor = [UIColor grayColor];
        [self setNeedsDisplay];
    }else{
        self.valueLab.text = [NSString stringWithFormat:@"%ld%@",(long)(self.percent * 100),@"%"];
        self.valueLab.textColor = getColor(buttonColor);
        [self setNeedsDisplay];
    }
}

-(CGFloat)percent{
    if (!_percent) {
        _percent = 0.0;
    }
    return _percent;
}

-(void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    [self setNeedsLayout];
}

-(CGFloat)lineHeight{
    if (!_lineHeight) {
        _lineHeight = 8;
    }
    return _lineHeight;
}

-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
}

-(CGFloat)lineWidth{
    if (!_lineWidth) {
        _lineWidth = 30.f;
    }
    return _lineWidth;
}

-(void)setNormalLineColor:(UIColor *)normalLineColor{
    _normalLineColor = normalLineColor;
    [self setNeedsLayout];
}

-(UIColor *)normalLineColor{
    if (!_normalLineColor) {
        _normalLineColor = RGBAColor(0x63, 0x63,0x63,0.1);
    }
    return _normalLineColor;
}

-(void)setSelectLineColor:(UIColor *)selectLineColor{
    _selectLineColor = selectLineColor;
    [self setNeedsLayout];
}

-(UIColor *)selectLineColor{
    if (!_selectLineColor) {
        _selectLineColor = getColor(buttonColor);
    }
    return _selectLineColor;
}

-(void)setStartAngle:(CGFloat)startAngle{
    _startAngle = startAngle;
}

-(CGFloat)startAngle{
    if (!_startAngle) {
        _startAngle = 0;
    }
    return _startAngle;
}

-(void)setEndAngle:(CGFloat)endAngle{
    _endAngle = endAngle;
}

-(CGFloat)endAngle{
    if (!_endAngle) {
        _endAngle = M_PI * 2;
    }
    return _endAngle;
}

-(UILabel *)centerLab{
    if (!_centerLab) {
        _centerLab = [[UILabel alloc] init];
        _centerLab.textAlignment = NSTextAlignmentCenter;
        _centerLab.font = DEF_FontSize_14;
        _centerLab.text = ChinaAndEnglish(@"CurrentBattery");
        _centerLab.textColor = [UIColor grayColor];
    }
    return _centerLab;
}

-(UILabel *)valueLab{
    if (!_valueLab) {
        _valueLab = [[UILabel alloc] init];
        _valueLab.font = [UIFont boldSystemFontOfSize:32];
        _valueLab.textColor = getColor(buttonColor);
        _valueLab.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLab;
}

-(void)commit{
    [self sd_addSubviews:@[self.centerLab,self.valueLab]];
 
    [self.valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-20);
        make.width.mas_equalTo(self.mas_width).offset(-60);
        make.height.mas_equalTo(UNIT_HEIGHT(60));
        
    }];
       
   [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.valueLab.mas_bottom);
       make.width.mas_equalTo(self.mas_width).offset(-60);
       make.height.mas_equalTo(UNIT_HEIGHT(30));
       make.centerX.mas_equalTo(self.mas_centerX);
   }];

}

@end
