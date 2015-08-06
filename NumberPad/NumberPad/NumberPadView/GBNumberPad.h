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


//Set the delegate to self to received delegate calls

@property (nonatomic, assign) IBOutlet id <GBNumberPadViewDelegate> delegate;


//Variation for the NumberPad

@property (nonatomic) NumberPadVariation myNumberPadVariation;



//Flag to determine whether add button is required
//add button is only available in NumberPadVariationDoubleZero Type
//default set to NO

@property (nonatomic) BOOL hasAddButton;



//Flag to determine if all subviews need border
//default set to NO

@property (nonatomic) BOOL isSubViewNeedBorder;



//Flag to determine if outer view frame need border
//default set to NO

@property (nonatomic) BOOL isOuterViewFrameNeedBorder;



//Font size for amount view, default set to 66

@property (nonatomic) CGFloat amountFontSize;



//Font size for all other labels, default set to 40

@property (nonatomic) CGFloat numberFontSize;



//Custom back button image if any
//if no image is assigned, a <- Label will be used

@property (nonatomic) UIImage *backImage;



//Custom add button image if any
//if no image is assigned, a + Label will be used

@property (nonatomic) UIImage *addImage;



//Font family name if any
//default set to Helvetical-Light

@property (nonatomic) NSString *amountFontName;
@property (nonatomic) NSString *numberFontName;


//background color of the NumberPad View

@property (nonatomic) UIColor *myBackgroundColor;



//UIColor for total Amount

@property (nonatomic) UIColor *myTextAmountColor;


//UIColor for Other Text Labels

@property (nonatomic) UIColor *myTextColor;


//UIColor for View Border, only applicable if [isSubViewNeedBorder] and/or [isOuterViewFrameNeedBorder] is set to YES

@property (nonatomic) UIColor *myBorderColor;


//Text alignment for Total Amount

@property (nonatomic) NSTextAlignment myTextAmountAlignment;


//Flag to determine if the total amount's $ label and fractional label need to be in superscript form
//default set to NO

@property (nonatomic) BOOL myTextAmountUsesSuperscript;


//Flag to determine if total amount will be formatted to have a comma in every 3 digits
//default set to NO

@property (nonatomic) BOOL myTextAmountAddCommaEvery3Digits;


//Y Coordinate of the Total Amount View
//default set to 0

@property (nonatomic) CGFloat myAmountViewY;


/* THE FOLLOWING TO PROPERTY, EITHER SET BOTH, OR LEAVE BOTH PROPERTY NOT SET, WHICH IS DEFAULT TO 0 */


//Height for the total amount view

@property (nonatomic) CGFloat myAmountViewHeight;


//Height for the other number views

@property (nonatomic) CGFloat myQuarterHeight;



@end



@protocol GBNumberPadViewDelegate <NSObject>

@optional

//Return the total amount selected

-(void)numberPadReturnAmountForView:(UIView *)numView forNumberString:(NSString *)number;


//Return the current number that has tap/selected, non-number will return null string

-(void)numberPad:(UIView *)numView didTapAtNumberString:(NSString *)string withNumber:(NSInteger)number;


//Return the total amount when user tap on Add Button

-(void)numberPad:(UIView *)numView didTapAddForNumberString:(NSString *)number;

@end