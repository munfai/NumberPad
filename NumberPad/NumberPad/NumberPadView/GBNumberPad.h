//
//  GBNumberPad.h
//  test
//
//  Created by Administrator on 4/14/15.
//  Copyright (c) 2015 Globeam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NumberPadVariationDoubleZeroType,
    NumberPadVariationSingleZeroWithDot
} NumberPadVariation;

@protocol GBNumberPadViewDelegate;

@interface GBNumberPad : UIView

@property (nonatomic, assign) IBOutlet id <GBNumberPadViewDelegate> delegate;

@property (nonatomic) NumberPadVariation myNumberPadVariation;

//Flag to determine whether add button is required
@property (nonatomic) BOOL hasAddButton;

//Flag to determine if all subviews need border
@property (nonatomic) BOOL isSubViewNeedBorder;

//Flag to determine if outer view frame need border
@property (nonatomic) BOOL isOuterViewFrameNeedBorder;

//Font size for amount view
@property (nonatomic) CGFloat amountFontSize;

//Font size for all other labels
@property (nonatomic) CGFloat numberFontSize;

//Custom back button image if any
@property (nonatomic) UIImage *backImage;

//Custom add button image if any
@property (nonatomic) UIImage *addImage;

//Font family name
@property (nonatomic) NSString *amountFontName;
@property (nonatomic) NSString *numberFontName;


@property (nonatomic) UIColor *myBackgroundColor;

@property (nonatomic) UIColor *myTextColor;

@property (nonatomic) UIColor *myTextAmountColor;

@property (nonatomic) UIColor *myBorderColor;

@property (nonatomic) NSTextAlignment myTextAmountAlignment;

@property (nonatomic) BOOL myTextAmountUsesSuperscript;

@property (nonatomic) BOOL myTextAmountAddCommaEvery3Digits;

@property (nonatomic) CGFloat myQuarterWidth;
@property (nonatomic) CGFloat myQuarterHeight;
@property (nonatomic) CGFloat myQuarterX;
@property (nonatomic) CGFloat myQuarterY;
@property (nonatomic) CGFloat myAmountViewHeight;
@property (nonatomic) CGFloat myAmountViewY;








@end



@protocol GBNumberPadViewDelegate <NSObject>

@optional

-(void)numberPadReturnAmountForView:(UIView *)numView forNumberString:(NSString *)number;

-(void)numberPad:(UIView *)numView didTapAtNumberString:(NSString *)string withNumber:(NSInteger)number;

-(void)didTapNumberPadAddForView:(UIView *)numView forNumberString:(NSString *)number;

@end