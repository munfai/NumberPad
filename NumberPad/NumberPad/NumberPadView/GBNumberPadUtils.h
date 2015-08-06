//
//  GBNumberPadUtils.h
//  NumberPad
//
//  Created by Mun Fai Leong on 8/5/15.
//  Copyright (c) 2015 munfai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum
{
    iPhone,
    iPad
} GBDeviceModel;

typedef enum{
    BorderLeft,
    BorderTop,
    BorderRight,
    BorderBottom
}BorderSide;

@interface GBNumberPadUtils : NSObject

+(CALayer *)createOneSidedBorderForUIView:(UIView *)myView Side:(BorderSide)Side withBorderColor:(UIColor *)color;

+(float)getBorderWidthAccordingToDisplay;


+ (UIColor *)getCustomBlueColor;
+ (UIColor *)getGlobeamCustomBlueColor:(CGFloat)alpha;
+ (UIColor *)getBlack40opacityColor;
+ (UIColor *)getBlack69opacityColor;
+ (UIColor *)getBlackColorRGB_0_0_0:(CGFloat)value;
+ (UIColor *)getColorRGB_4_32_44:(CGFloat)value;
+ (UIColor *)getColorRGB_0_32_44:(CGFloat)value;
+ (UIColor *)getColorRGB237:(CGFloat)value;
+ (UIColor *)getColorRGB255:(CGFloat)value;

+(NSMutableAttributedString *)createStringWithSpacing:(NSString *)string spacngValue:(float)spacing;


@end
