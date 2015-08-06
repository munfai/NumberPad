//
//  GBNumberPadUtils.m
//  NumberPad
//
//  Created by Mun Fai Leong on 8/5/15.
//  Copyright (c) 2015 munfai. All rights reserved.
//

#import "GBNumberPadUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation GBNumberPadUtils

+(CALayer *)createOneSidedBorderForUIView:(UIView *)myView Side:(BorderSide)Side withBorderColor:(UIColor *)color
{
    CGRect myFrame = myView.frame;
    CGFloat x, y, width, height;
    
    switch (Side)
    {
        case BorderLeft:
        {
            x = 0;
            y = 0;
            height = myView.frame.size.height;
            width = [GBNumberPadUtils getBorderWidthAccordingToDisplay];
        }
            break;
            
        case BorderTop:
        {
            x = 0;
            y = 0;
            height = [GBNumberPadUtils getBorderWidthAccordingToDisplay];
            width = myView.frame.size.width;
        }
            break;
            
        case BorderRight:
        {
            x = myView.frame.size.width - [GBNumberPadUtils getBorderWidthAccordingToDisplay];
            y = 0;
            height = myView.frame.size.height;
            width = [GBNumberPadUtils getBorderWidthAccordingToDisplay];
        }
            break;
            
        case BorderBottom:
        {
            x = 0;
            y = myView.frame.size.height - [GBNumberPadUtils getBorderWidthAccordingToDisplay];
            height = [GBNumberPadUtils getBorderWidthAccordingToDisplay];
            width = myView.frame.size.width;
        }
            break;
    }
    
    myFrame.origin.x = x;
    myFrame.origin.y = y;
    myFrame.size.height = height;
    myFrame.size.width = width;
    
    CALayer *newLayer = [CALayer layer];
    newLayer.frame = myFrame;
    newLayer.backgroundColor = color.CGColor;
    
    return newLayer;
}

+(float)getBorderWidthAccordingToDisplay
{
    float width = 0;
    
    if ([UIScreen mainScreen].scale >= 2)
        width = 0.5;
    else
        width = 0.6;
    
    return width;
}

+(NSMutableAttributedString *)createStringWithSpacing:(NSString *)string spacngValue:(float)spacing
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    
    [attributeString addAttribute:NSKernAttributeName value:@(spacing) range:NSMakeRange(0, string.length)];
    
    return attributeString;
}



+ (UIColor *)getCustomBlueColor
{
    return [UIColor colorWithRed:0.0/255.0 green:175.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+ (UIColor *)getGlobeamCustomBlueColor:(CGFloat)alpha
{
    return [UIColor colorWithRed:40.0/255.0 green:132.0/255.0 blue:220.0/255.0 alpha:alpha];
}

+ (UIColor *)getBlack69opacityColor
{
    return [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.69];
}

+ (UIColor *)getBlack40opacityColor
{
    return [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.40];
}

+ (UIColor *)getBlackColorRGB_0_0_0:(CGFloat)value
{
    return [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:value];
}

+ (UIColor *)getColorRGB_0_32_44:(CGFloat)value
{
    return [UIColor colorWithRed:0.0/255.0 green:32.0/255.0 blue:44.0/255.0 alpha:value];
}

+ (UIColor *)getColorRGB_4_32_44:(CGFloat)value
{
    return [UIColor colorWithRed:4.0/255.0 green:32.0/255.0 blue:44.0/255.0 alpha:value];
}

+ (UIColor *)getColorRGB237:(CGFloat)value
{
    return [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:value];
}

+ (UIColor *)getColorRGB255:(CGFloat)value
{
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:value];
}


@end
