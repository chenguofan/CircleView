//
//  BatteryCircleView.h
//  TestDome
//
//  Created by suhengxian on 2020/9/10.
//  Copyright © 2020 suhengxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BatteryCircleView : UIView
@property(nonatomic,assign) CGFloat percent;
@property(nonatomic,assign) CGFloat lineHeight;
@property(nonatomic,assign) CGFloat lineWidth;
@property(nonatomic,strong) UIColor *normalLineColor;
@property(nonatomic,strong) UIColor *selectLineColor;
@property(nonatomic,assign) CGFloat startAngle;
@property(nonatomic,assign) CGFloat endAngle;
@property(nonatomic,assign) UIColor *bgColor;

-(instancetype)initWithFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
