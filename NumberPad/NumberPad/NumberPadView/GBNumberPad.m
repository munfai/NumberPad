//
//  GBNumberPad.m
//  test
//
//  Created by Administrator on 4/14/15.
//  Copyright (c) 2015 Globeam. All rights reserved.
//

#import "GBNumberPad.h"
#import "GBNumberPadUtils.h"

@interface GBNumberPad()
{
    UIView *numberPadView;
    UILabel *amountTotal;
    NSString *numericTotal, *numeric2Decimal;
    NSInteger countIndex;
    double transferAmount;
    BOOL hasEnabledDecimalPoint;
    
    CGFloat quarterWidth, quarterHeight, screenWidth, screenHeight, amountViewHeight;
}


//number pad views
@property (retain, nonatomic) IBOutlet UIView *AmountView;
@property (retain, nonatomic) IBOutlet UIView *NumericView1;
@property (retain, nonatomic) IBOutlet UIView *NumericView2;
@property (retain, nonatomic) IBOutlet UIView *NumericView3;
@property (retain, nonatomic) IBOutlet UIView *NumericView4;
@property (retain, nonatomic) IBOutlet UIView *NumericView5;
@property (retain, nonatomic) IBOutlet UIView *NumericView6;
@property (retain, nonatomic) IBOutlet UIView *NumericView7;
@property (retain, nonatomic) IBOutlet UIView *NumericView8;
@property (retain, nonatomic) IBOutlet UIView *NumericView9;
@property (retain, nonatomic) IBOutlet UIView *NumericView0;
@property (retain, nonatomic) IBOutlet UIView *NumericViewSingle0;
@property (retain, nonatomic) IBOutlet UIView *NumericViewBack;
@property (retain, nonatomic) IBOutlet UIView *NumericViewAdd;

//Custom font if any
@property (nonatomic) UIFont *numberFont;

//Custom font if any
@property (nonatomic) UIFont *amountFont;

@end

@implementation GBNumberPad


/*

    NEED FURTHER IMPROVEMENT ON CUSTOMIZING
 
    NEED UPDATE FOR DOUBLE ZERO VARIATION
        - ADD SUPERSCRIPT CUSTOMIZATION
        - ADD COMMA FOR EVERY 3 DIGIT

    NEED TO FACTOR OUT CERTAIN CODE AND CODE CLEANING
*/


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self calculateWidthAndHeight:self.myNumberPadVariation];
    
    [self createNumberPadView];
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initializeVariable];
        
        
        [self calculateWidthAndHeight:self.myNumberPadVariation];
        
    }
    
    return self;
}

-(void)initializeVariable
{
    //[self listAllFontFamily];
    
    self.hasAddButton = NO;
    
    self.amountFontSize = 66;
    
    self.numberFontSize = 40;
    
    self.amountFontName = @"Helvetica-Light";
    
    self.numberFontName = @"Helvetica-Light";
    
    self.myBackgroundColor = [UIColor whiteColor];
    
    self.myBorderColor = [GBNumberPadUtils getColorRGB237:1];
    
    self.myTextAmountColor = [GBNumberPadUtils getGlobeamCustomBlueColor:1];
    
    self.myTextColor = [GBNumberPadUtils getColorRGB_0_32_44:1];
    
    self.myTextAmountAlignment = NSTextAlignmentRight;
    
    self.myNumberPadVariation = NumberPadVariationDoubleZeroType;
    
    self.isSubViewNeedBorder = YES;
    
    self.isOuterViewFrameNeedBorder = NO;
    
    self.myTextAmountAddCommaEvery3Digits = NO;
    
    self.myTextAmountUsesSuperscript = NO;
    
    [self setFont];
}

-(void)calculateWidthAndHeight:(NumberPadVariation)variation
{
    int numberOfColumn = 4;
    
    if (variation == NumberPadVariationSingleZeroWithDot)
        numberOfColumn = 3;
    
    quarterWidth = self.frame.size.width / numberOfColumn;
    
    screenHeight = self.frame.size.height;
    screenWidth = self.frame.size.width;
    
    if (self.myQuarterHeight == 0 && self.myAmountViewHeight == 0)
    {
        if ((int)screenHeight % 5  == 0)
        {
            quarterHeight = self.frame.size.height / 5;
            amountViewHeight = quarterHeight;
        }
        else
        {
            int i = 1;
            
            while (((int)(self.frame.size.height - i) % 5) != 0)
            {
                i++;
            }
            
            quarterHeight = (self.frame.size.height - i) / 5;
            amountViewHeight = quarterHeight + i;
        }
    }
    else
    {
        quarterHeight = self.myQuarterHeight;
        amountViewHeight = self.myAmountViewHeight;
    }
    
}

-(void)setFont
{
    self.numberFont = [UIFont fontWithName:self.numberFontName size:self.numberFontSize];
    
    self.amountFont = [UIFont fontWithName:self.amountFontName size:self.amountFontSize];
}




//////////////  CREATE VIEW ///////////////////////////

-(void)createNumberPadView
{
    [self setInitialStartingValue];
    hasEnabledDecimalPoint = NO;
    
    /////////////// VIEWS ////////////////////////////////////
    
    numberPadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    numberPadView.backgroundColor = self.myBackgroundColor;
    
    self.AmountView = [[UIView alloc]initWithFrame:CGRectMake(0, self.myAmountViewY, screenWidth, amountViewHeight)];
    
    
    
    CGFloat width = quarterWidth;//152;
    CGFloat height = quarterHeight;//129;
    CGFloat row1y, row2y,row3y, row4y, column1x, column2x,column3x, column4x;
    int multiplier = 4;
    
    if (self.hasAddButton)
        multiplier = 2;
    
    row1y = amountViewHeight + self.myAmountViewY;
    row2y = amountViewHeight + quarterHeight + self.myAmountViewY;
    row3y = amountViewHeight + (quarterHeight * 2) + self.myAmountViewY;
    row4y = amountViewHeight + (quarterHeight * 3) + self.myAmountViewY;
    
    column1x = 0;
    column2x = quarterWidth;
    column3x = quarterWidth * 2;
    column4x = quarterWidth * 3;
    
    //CGRect numberFrame = CGRectMake(0, 0, width, height);
    UIFont *fontsize = [UIFont systemFontOfSize:self.numberFontSize];
    
    [self setFont];
    
    self.NumericView1 = [[UIView alloc]initWithFrame:CGRectMake(column1x, row1y, width, height)];
    
    self.NumericView2 = [[UIView alloc]initWithFrame:CGRectMake(column2x, row1y, width, height)];
    
    self.NumericView3 = [[UIView alloc]initWithFrame:CGRectMake(column3x, row1y, width, height)];
    
    self.NumericView4 = [[UIView alloc]initWithFrame:CGRectMake(column1x, row2y, width, height)];
    
    self.NumericView5 = [[UIView alloc]initWithFrame:CGRectMake(column2x, row2y, width, height)];
    
    self.NumericView6 = [[UIView alloc]initWithFrame:CGRectMake(column3x, row2y, width, height)];
    
    self.NumericView7 = [[UIView alloc]initWithFrame:CGRectMake(column1x, row3y, width, height)];
    
    self.NumericView8 = [[UIView alloc]initWithFrame:CGRectMake(column2x, row3y, width, height)];
    
    self.NumericView9 = [[UIView alloc]initWithFrame:CGRectMake(column3x, row3y, width, height)];
    
    
    if (self.myNumberPadVariation == NumberPadVariationDoubleZeroType)
    {
        self.NumericView0 = [[UIView alloc]initWithFrame:CGRectMake(column1x, row4y, width * 2, height)];
        
        self.NumericViewSingle0 = [[UIView alloc]initWithFrame:CGRectMake(column3x, row4y, width, height)];
        
        self.NumericViewBack = [[UIView alloc]initWithFrame:CGRectMake(column4x, row1y, width, height * multiplier)];
    }
    else if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot)
    {
        self.NumericView0 = [[UIView alloc]initWithFrame:CGRectMake(column1x, row4y, width, height)];
        
        self.NumericViewSingle0 = [[UIView alloc]initWithFrame:CGRectMake(column2x, row4y, width, height)];
        
        self.NumericViewBack = [[UIView alloc]initWithFrame:CGRectMake(column3x, row4y, width, height)];
    }
    
    
    
    
    
    
    
    if (self.hasAddButton)
    {
        self.NumericViewAdd = [[UIView alloc]initWithFrame:CGRectMake(column4x, row3y, width, height * multiplier)];
        
        
        UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, quarterWidth, quarterHeight * multiplier)];
        addLabel.font = fontsize;
        //number1.font = [GBNumberPadUtils getCustomTypefaceForUILabel:GothamThin withObject:number1];
        addLabel.text = @"+";
        addLabel.textColor = [GBNumberPadUtils getBlack69opacityColor];
        addLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2 - 15, height * multiplier/2 - 15, 30, 30)];
        addImageView.image = self.addImage;
        
        if (self.addImage != nil)
            [self.NumericViewAdd addSubview:addImageView];
        else
            [self.NumericViewAdd addSubview:addLabel];
    }
    
    if (self.isSubViewNeedBorder)
        [self addBorderToSubView];
    
    if (self.isOuterViewFrameNeedBorder)
        [self addBorderToOuterView];
    
    [self createNumberPadSubView];
    
    [self addSubViewToMainView];

    [self addGestureToNumberPad];

}

-(void)createNumberPadSubView
{
    CGFloat width = quarterWidth;//152;
    CGFloat height = quarterHeight;//129;
    CGFloat row1y, row2y,row3y, row4y, column1x, column2x,column3x, column4x;
    int multiplier = 4;
    
    if (self.hasAddButton)
        multiplier = 2;
    
    row1y = amountViewHeight;
    row2y = amountViewHeight + quarterHeight;
    row3y = amountViewHeight + (quarterHeight * 2);
    row4y = amountViewHeight + (quarterHeight * 3);
    
    column1x = 0;
    column2x = quarterWidth;
    column3x = quarterWidth * 2;
    column4x = quarterWidth * 3;
    
    CGRect numberFrame = CGRectMake(0, 0, width, height);
    UIFont *fontsize = [UIFont systemFontOfSize:self.numberFontSize];
    
    //////////////// LABELS AND BUTTONS  //////////////////////////////
    
    NSString *amountText = @"$0.00";
    
    if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot && self.myTextAmountUsesSuperscript)
        amountText = @"$0";
    
    amountTotal = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.AmountView.frame.size.width - 40, self.AmountView.frame.size.height)];
    amountTotal.numberOfLines = 1;
    amountTotal.adjustsFontSizeToFitWidth = YES;
    amountTotal.textColor = self.myTextAmountColor;
    amountTotal.text = amountText;
    amountTotal.textAlignment = self.myTextAmountAlignment;
    amountTotal.font = [UIFont systemFontOfSize:self.amountFontSize];
    amountTotal.font = self.amountFont;
    
    NSMutableAttributedString *mString = [GBNumberPadUtils createStringWithSpacing:amountTotal.text spacngValue:0];
    
    if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot && self.myTextAmountUsesSuperscript)
    {
        UIFont *tempFont = [UIFont fontWithName:self.amountFontName size:amountTotal.font.pointSize / 3];
        
        [mString setAttributes:@{NSFontAttributeName : tempFont ,NSBaselineOffsetAttributeName : @50} range:NSMakeRange(0,1)];
    }
    
    amountTotal.attributedText = mString;
    
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake((quarterWidth/2) - 15, (self.NumericViewBack.frame.size.height /2) - 10, 30, 20)];
    backImageView.image = self.backImage;
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, quarterWidth, quarterHeight * multiplier)];
    backLabel.font = fontsize;
    backLabel.font = self.numberFont;
    backLabel.text = @"<-";
    backLabel.textColor = self.myTextColor;
    backLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number1 = [[UILabel alloc]initWithFrame:numberFrame];
    number1.font = fontsize;
    number1.font = self.numberFont;
    number1.text = @"1";
    number1.textColor = self.myTextColor;
    number1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number2 = [[UILabel alloc]initWithFrame:numberFrame];
    number2.font = fontsize;
    number2.font = self.numberFont;
    number2.text = @"2";
    number2.textColor = self.myTextColor;
    number2.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number3 = [[UILabel alloc]initWithFrame:numberFrame];
    number3.font = fontsize;
    number3.font = self.numberFont;
    number3.text = @"3";
    number3.textColor = self.myTextColor;
    number3.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number4 = [[UILabel alloc]initWithFrame:numberFrame];
    number4.font = fontsize;
    number4.font = self.numberFont;
    number4.text = @"4";
    number4.textColor = self.myTextColor;
    number4.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number5 = [[UILabel alloc]initWithFrame:numberFrame];
    number5.font = fontsize;
    number5.font = self.numberFont;
    number5.text = @"5";
    number5.textColor = self.myTextColor;
    number5.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number6 = [[UILabel alloc]initWithFrame:numberFrame];
    number6.font = fontsize;
    number6.font = self.numberFont;
    number6.text = @"6";
    number6.textColor = self.myTextColor;
    number6.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number7 = [[UILabel alloc]initWithFrame:numberFrame];
    number7.font = fontsize;
    number7.font = self.numberFont;
    number7.text = @"7";
    number7.textColor = self.myTextColor;
    number7.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number8 = [[UILabel alloc]initWithFrame:numberFrame];
    number8.font = fontsize;
    number8.font = self.numberFont;
    number8.text = @"8";
    number8.textColor = self.myTextColor;
    number8.textAlignment = NSTextAlignmentCenter;
    
    UILabel *number9 = [[UILabel alloc]initWithFrame:numberFrame];
    number9.font = fontsize;
    number9.font = self.numberFont;
    number9.text = @"9";
    number9.textColor = self.myTextColor;
    number9.textAlignment = NSTextAlignmentCenter;
    
    NSString *numberZeroString = @"00";
    UIFont *zeroFont = self.numberFont;
    
    if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot)
    {
        numberZeroString = @".";
        zeroFont = [UIFont fontWithName:self.numberFontName size:40];
    }
    
    UILabel *number0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.NumericView0.frame.size.width, height)];
    number0.font = fontsize;
    number0.font = zeroFont;
    number0.text = numberZeroString;
    number0.textColor = self.myTextColor;
    number0.textAlignment = NSTextAlignmentCenter;
    
    UILabel *numberSingle0 = [[UILabel alloc]initWithFrame:numberFrame];
    numberSingle0.font = fontsize;
    numberSingle0.font = self.numberFont;
    numberSingle0.text = @"0";
    numberSingle0.textColor = self.myTextColor;
    numberSingle0.textAlignment = NSTextAlignmentCenter;
    
    
    [self.NumericView0 addSubview:number0];
    [self.NumericView1 addSubview:number1];
    [self.NumericView2 addSubview:number2];
    [self.NumericView3 addSubview:number3];
    [self.NumericView4 addSubview:number4];
    [self.NumericView5 addSubview:number5];
    [self.NumericView6 addSubview:number6];
    [self.NumericView7 addSubview:number7];
    [self.NumericView8 addSubview:number8];
    [self.NumericView9 addSubview:number9];
    [self.NumericViewSingle0 addSubview:numberSingle0];
    
    if (self.backImage != nil)
        [self.NumericViewBack addSubview:backImageView];
    else
        [self.NumericViewBack addSubview:backLabel];
    
    if (self.hasAddButton)
        [numberPadView addSubview:self.NumericViewAdd];
    
    [self.AmountView addSubview:amountTotal];
}

-(void)addSubViewToMainView
{
    [numberPadView addSubview:self.AmountView];
    [numberPadView addSubview:self.NumericView1];
    [numberPadView addSubview:self.NumericView2];
    [numberPadView addSubview:self.NumericView3];
    [numberPadView addSubview:self.NumericView4];
    [numberPadView addSubview:self.NumericView5];
    [numberPadView addSubview:self.NumericView6];
    [numberPadView addSubview:self.NumericView7];
    [numberPadView addSubview:self.NumericView8];
    [numberPadView addSubview:self.NumericView9];
    [numberPadView addSubview:self.NumericView0];
    [numberPadView addSubview:self.NumericViewSingle0];
    [numberPadView addSubview:self.NumericViewBack];
    
    [self addSubview:numberPadView];
}

-(void)addBorderToSubView
{
    [self.AmountView.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.AmountView Side:BorderBottom withBorderColor:self.myBorderColor]];
    
    [self.NumericView1.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView1 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView1.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView1 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView2.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView2 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView2.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView2 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView3.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView3 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView3.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView3 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView4.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView4 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView4.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView4 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView5.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView5 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView5.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView5 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView6.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView6 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView6.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView6 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView7.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView7 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView7.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView7 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView8.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView8 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView8.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView8 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView9.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView9 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView9.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView9 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericView0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView0 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView0 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericViewSingle0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewSingle0 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericViewSingle0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewSingle0 Side:BorderRight withBorderColor:self.myBorderColor]];
    
    [self.NumericViewBack.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewBack Side:BorderBottom withBorderColor:self.myBorderColor]];
    
    if (self.hasAddButton)
        [self.NumericViewAdd.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewAdd Side:BorderBottom withBorderColor:self.myBorderColor]];
}

-(void)addBorderToOuterView
{
    [self.AmountView.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.AmountView Side:BorderTop withBorderColor:self.myBorderColor]];
    
    [self.NumericView1.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView1 Side:BorderLeft withBorderColor:self.myBorderColor]];
    
    
    [self.NumericView4.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView4 Side:BorderLeft withBorderColor:self.myBorderColor]];
    
    
    [self.NumericView7.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView7 Side:BorderLeft withBorderColor:self.myBorderColor]];
    
    if (!self.isSubViewNeedBorder)
        [self.NumericView0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView0 Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericView0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView0 Side:BorderLeft withBorderColor:self.myBorderColor]];
    
    if (!self.isSubViewNeedBorder)
    [self.NumericViewSingle0.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewSingle0 Side:BorderBottom withBorderColor:self.myBorderColor]];

    if (!self.isSubViewNeedBorder)
        [self.NumericViewBack.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewBack Side:BorderBottom withBorderColor:self.myBorderColor]];
    [self.NumericViewBack.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewBack Side:BorderRight withBorderColor:self.myBorderColor]];
    
    if (self.hasAddButton)
        [self.NumericViewAdd.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericViewAdd Side:BorderRight withBorderColor:self.myBorderColor]];
    
    if (self.myNumberPadVariation == NumberPadVariationDoubleZeroType)
    {
        [self.NumericView3.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView3 Side:BorderRight withBorderColor:self.myBorderColor]];
        
        [self.NumericView6.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView6 Side:BorderRight withBorderColor:self.myBorderColor]];
        
        [self.NumericView9.layer addSublayer:[GBNumberPadUtils createOneSidedBorderForUIView:self.NumericView9 Side:BorderRight withBorderColor:self.myBorderColor]];
    }
}

-(void)addGestureToNumberPad
{
    UITapGestureRecognizer *numbertap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap0)];
    numbertap0.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap1)];
    numbertap1.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap2)];
    numbertap2.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap3)];
    numbertap3.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap4)];
    numbertap4.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap5)];
    numbertap5.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap6)];
    numbertap6.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap7)];
    numbertap7.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap8)];
    numbertap8.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTap9)];
    numbertap9.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertapback = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTapBack)];
    numbertapback.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertapsingle0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTapSingle0)];
    numbertapsingle0.numberOfTapsRequired=1;
    UITapGestureRecognizer *numbertapAdd = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NumbersTapAdd)];
    numbertapAdd.numberOfTapsRequired=1;
    
    [self.NumericView0 addGestureRecognizer:numbertap0];
    [self.NumericView1 addGestureRecognizer:numbertap1];
    [self.NumericView2 addGestureRecognizer:numbertap2];
    [self.NumericView3 addGestureRecognizer:numbertap3];
    [self.NumericView4 addGestureRecognizer:numbertap4];
    [self.NumericView5 addGestureRecognizer:numbertap5];
    [self.NumericView6 addGestureRecognizer:numbertap6];
    [self.NumericView7 addGestureRecognizer:numbertap7];
    [self.NumericView8 addGestureRecognizer:numbertap8];
    [self.NumericView9 addGestureRecognizer:numbertap9];
    [self.NumericViewBack addGestureRecognizer:numbertapback];
    [self.NumericViewSingle0 addGestureRecognizer:numbertapsingle0];
    
    if (self.hasAddButton)
        [self.NumericViewAdd addGestureRecognizer:numbertapAdd];
}




//////////////  HELPER METHOD ///////////////////////////

-(void)setInitialStartingValue
{
    numericTotal = @"000";
    countIndex = 0;
    
    numeric2Decimal = @"00";
    
    if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot)
        numericTotal = @"0";
}

-(void)setAmountTotalToSuperScript
{
    if (self.myTextAmountUsesSuperscript)
    {
        UIFont *tempFont = [UIFont fontWithName:self.amountFontName size:amountTotal.font.pointSize / 3];
        
        NSMutableAttributedString *mString = [GBNumberPadUtils createStringWithSpacing:amountTotal.text spacngValue:0];
        
        [mString setAttributes:@{NSFontAttributeName : tempFont ,NSBaselineOffsetAttributeName : @50} range:NSMakeRange(0,1)];
        
        if (![numeric2Decimal isEqualToString:@"00"])
        {
            [mString setAttributes:@{NSFontAttributeName : tempFont ,NSBaselineOffsetAttributeName : @50} range:NSMakeRange(mString.length - numeric2Decimal.length, numeric2Decimal.length)];
        }
        
        amountTotal.attributedText = mString;
    }
}

-(void)setDecimalPointEnabled:(BOOL)enabled
{
    if (!enabled)
    {
        hasEnabledDecimalPoint = NO;
        
        self.NumericView0.backgroundColor = [UIColor clearColor];
    }
    else
    {
        hasEnabledDecimalPoint = YES;
        
        self.NumericView0.backgroundColor = [GBNumberPadUtils getColorRGB_4_32_44:0.1];
    }
}

-(void)listAllFontFamily
{
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
}




////////////// NUMBER PAD GESTURES ////////////////////////////////

-(void)updateTotalAmountForVariationSingleDot
{
    NSMutableString *amountString, *displayString;
    
    NSString *appendString = [NSString stringWithFormat:@"%@%@", numericTotal, numeric2Decimal];
    amountString = [NSMutableString stringWithString:appendString];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    if ([numeric2Decimal isEqualToString:@"00"])
    {
        displayString = [NSMutableString stringWithString:numericTotal];
        
        if (self.myTextAmountAddCommaEvery3Digits)
            displayString = [NSMutableString stringWithString:[formatter stringFromNumber:[NSNumber numberWithInteger:[displayString integerValue]]]];
    }
    else
    {
        if (self.myTextAmountAddCommaEvery3Digits)
        {
            NSString *tempS = [formatter stringFromNumber:[NSNumber numberWithInteger:[numericTotal integerValue]]];
            
            displayString = [NSMutableString stringWithFormat:@"%@%@", tempS, numeric2Decimal];
        }
        else
            displayString = [NSMutableString stringWithString:appendString];
    }
    
    [amountString insertString:@"." atIndex:[amountString length]- numeric2Decimal.length];
    transferAmount = [amountString doubleValue];
    
    if (!self.myTextAmountUsesSuperscript && ![numeric2Decimal isEqualToString:@"00"])
    {
        [displayString insertString:@"." atIndex:[displayString length]- numeric2Decimal.length];
    }
    
    amountTotal.text = [NSString stringWithFormat:@"$%@", displayString];
    
    [self setAmountTotalToSuperScript];
    
    //NSLog(@"final: %@, %@, %@", displayString, amountString, amountTotal.text);
    
    if ([self.delegate respondsToSelector:@selector(numberPadReturnAmountForView:forNumberString:)])
    {
        [self.delegate numberPadReturnAmountForView:self forNumberString:amountString];
    }
}

-(void)updateTotalAmountForVariationDoubleZero
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSMutableString *displayString, *amountString;
    
    if (self.myTextAmountAddCommaEvery3Digits)
        displayString = [NSMutableString stringWithString:[formatter stringFromNumber:[NSNumber numberWithInteger:[[numericTotal substringToIndex:numericTotal.length - 2] integerValue]]]];
    
    displayString = [NSMutableString stringWithFormat:@"%@%@", displayString, [numericTotal substringFromIndex:numericTotal.length - 2]];
    [displayString insertString:@"." atIndex:[displayString length]-2];
    
    amountString = [NSMutableString stringWithString:numericTotal];
    [amountString insertString:@"." atIndex:[numericTotal length]-2];
    
    transferAmount = [amountString doubleValue];
    
    amountTotal.text = [NSString stringWithFormat:@"$%@", displayString];
    
    NSLog(@"value: %@, %@", displayString, [formatter stringFromNumber:[NSNumber numberWithInteger:[[numericTotal substringToIndex:numericTotal.length - 2] integerValue]]]);
    
    if ([self.delegate respondsToSelector:@selector(numberPadReturnAmountForView:forNumberString:)])
    {
        [self.delegate numberPadReturnAmountForView:self forNumberString:amountString];
    }
}

- (void)appendTotalNumber:(NSString *)integer AddIndex:(NSInteger)addindex
{
    @try {
        
        if ([self.delegate respondsToSelector:@selector(numberPad:didTapAtNumberString:withNumber:)])
        {
            [self.delegate numberPad:self didTapAtNumberString:integer withNumber:[integer integerValue]];
        }
        
        if (self.myNumberPadVariation == NumberPadVariationDoubleZeroType)
        {
            if ([numericTotal length] < 1)
            {
                numericTotal = @"000";
            }
            
            if (countIndex < 3)
            {
                numericTotal = [numericTotal substringFromIndex:1];
                numericTotal = [NSString stringWithFormat:@"%@%@", numericTotal, integer];
            }
            else
            {
                numericTotal = [NSString stringWithFormat:@"%@%@", numericTotal, integer];
            }
            
            countIndex = countIndex + addindex;
            
            [self updateTotalAmountForVariationDoubleZero];
            
            /*
            NSMutableString *tempStr = [NSMutableString stringWithString:numericTotal];
            [tempStr insertString:@"." atIndex:[numericTotal length]-2];
            
            transferAmount = [tempStr doubleValue];
            
            amountTotal.text = [NSString stringWithFormat:@"$%@", tempStr];
            
            
            //NSLog(@"index: %lu, value: %@", (long)countIndex, numericTotal);
            
            if ([self.delegate respondsToSelector:@selector(numberPadReturnAmountForView:forNumberString:)])
            {
                [self.delegate numberPadReturnAmountForView:self forNumberString:tempStr];
            }*/
            
        }
        else if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot)
        {
            if (!hasEnabledDecimalPoint)
            {
                if ([numericTotal length] < 1)
                {
                    numericTotal = @"0";
                }
                
                if ([numericTotal isEqualToString:@"0"])
                {
                    numericTotal = [NSString stringWithFormat:@"%@", integer];
                }
                else
                {
                    numericTotal = [NSString stringWithFormat:@"%@%@", numericTotal, integer];
                }
            }
            else
            {
                if ([numeric2Decimal length] < 1)
                {
                    numeric2Decimal = @"00";
                }
                
                if ([numeric2Decimal isEqualToString:@"00"])
                {
                    numeric2Decimal = [NSString stringWithFormat:@"%@", integer];
                }
                else if (numeric2Decimal.length < 2)
                {
                    numeric2Decimal = [NSString stringWithFormat:@"%@%@", numeric2Decimal, integer];
                }
            }
            
            [self updateTotalAmountForVariationSingleDot];
            
            /*
            NSMutableString *amountString, *displayString;
            
            NSString *appendString = [NSString stringWithFormat:@"%@%@", numericTotal, numeric2Decimal];
            amountString = [NSMutableString stringWithString:appendString];
            
            
            if ([numeric2Decimal isEqualToString:@"00"])
            {
                displayString = [NSMutableString stringWithString:numericTotal];
            }
            else
            {
                displayString = [NSMutableString stringWithString:appendString];
            }
            
            [amountString insertString:@"." atIndex:[amountString length]- numeric2Decimal.length];
            transferAmount = [amountString doubleValue];
            
            if (!self.myTextAmountUsesSuperscript)
            {
                [displayString insertString:@"." atIndex:[displayString length]- numeric2Decimal.length];
            }
            
            
            
            amountTotal.text = [NSString stringWithFormat:@"$%@", displayString];
            countIndex = countIndex + addindex;
            
            [self setAmountTotalToSuperScript];
            
            //NSLog(@"final: %@, %@, %@", displayString, amountString, amountTotal.text);
            
            if ([self.delegate respondsToSelector:@selector(numberPadReturnAmountForView:forNumberString:)])
            {
                [self.delegate numberPadReturnAmountForView:self forNumberString:amountString];
            }*/
        }
    }
    @catch (NSException *exception) {
            NSLog(@"ex: %@", exception.description);
    }
    @finally {
        
    }
    
}

- (void) NumbersTapBack
{
    @try {
        
        if ([self.delegate respondsToSelector:@selector(numberPad:didTapAtNumberString:withNumber:)])
        {
            [self.delegate numberPad:self didTapAtNumberString:nil withNumber:0];
        }
        
        if (self.myNumberPadVariation == NumberPadVariationDoubleZeroType)
        {
            if (countIndex > 3)
            {
                numericTotal = [numericTotal substringToIndex:[numericTotal length]-1];
            }
            else
            {
                if (countIndex != 0)
                {
                    numericTotal = [numericTotal substringToIndex:[numericTotal length]-1];
                    numericTotal = [NSString stringWithFormat:@"0%@", numericTotal];
                }
            }
            
            if (countIndex > 0)
            {
                countIndex = countIndex - 1;
            }
            
            if ([numericTotal isEqualToString:@"0"])
            {
                numericTotal = @"000";
            }
            
            
            [self updateTotalAmountForVariationDoubleZero];
            
            /*
             NSMutableString *tempStr = [NSMutableString stringWithString:numericTotal];
             [tempStr insertString:@"." atIndex:[numericTotal length]-2];
             
             transferAmount = [tempStr doubleValue];
             
             amountTotal.text = [NSString stringWithFormat:@"$%@", tempStr];
             
             //NSLog(@"index: %lu, value: %@", (long)countIndex, numericTotal);
             
             if ([self.delegate respondsToSelector:@selector(numberPadReturnAmountForView:forNumberString:)])
             {
             [self.delegate numberPadReturnAmountForView:self forNumberString:tempStr];
             }*/
        }
        else if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot)
        {
            if (!hasEnabledDecimalPoint)
            {
                if (numericTotal.length > 1)
                {
                    numericTotal = [numericTotal substringToIndex:[numericTotal length]-1];
                }
                else
                {
                    numericTotal = @"0";
                }
            }
            else
            {
                if (numeric2Decimal.length > 1 && ![numeric2Decimal isEqualToString:@"00"])
                {
                    numeric2Decimal = [numeric2Decimal substringToIndex:[numeric2Decimal length]-1];
                }
                else if ([numeric2Decimal isEqualToString:@"00"])
                {
                    [self setDecimalPointEnabled:NO];
                }
                else
                {
                    numeric2Decimal = @"00";
                }
            }
            
            [self updateTotalAmountForVariationSingleDot];
            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"ex: %@", exception.description);
    }
    @finally {
    }
    
    
}

-(void) NumbersTapAdd
{
    @try {
        
        NSMutableString *tempStr = [NSMutableString stringWithString:numericTotal];
        [tempStr insertString:@"." atIndex:[numericTotal length]-2];
        
        numericTotal = @"000";
        countIndex = 0;
        amountTotal.text = [NSString stringWithFormat:@"$%@", @"0.00"];
        
        if ([self.delegate respondsToSelector:@selector(didTapNumberPadAddForView:forNumberString:)])
        {
            [self.delegate didTapNumberPadAddForView:self forNumberString:tempStr];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exTapAdd: %@", exception.description);
    }
    @finally {
        
    }
}

- (void) NumbersTapSingle0
{
    if (![numericTotal hasPrefix:@"000"])
    {
        [self appendTotalNumber:@"0" AddIndex:1];
    }
}

- (void) NumbersTap0
{
    if (self.myNumberPadVariation == NumberPadVariationDoubleZeroType) //user tap on double zero, total amount will add 2 digit of zero behind
    {
        for (int i= 0; i < 2; i++)
        {
            if (![numericTotal hasPrefix:@"000"])
            {
                [self appendTotalNumber:@"0" AddIndex:1];
            }
        }
    }
    else if (self.myNumberPadVariation == NumberPadVariationSingleZeroWithDot) //user tap on dot, goes into fraction edit mode
    {
        if (hasEnabledDecimalPoint)
        {
            [self setDecimalPointEnabled:NO];
        }
        else
        {
            [self setDecimalPointEnabled:YES];
        }
    }
}

- (void) NumbersTap1
{
    [self appendTotalNumber:@"1" AddIndex:1];
}

- (void) NumbersTap2
{
    [self appendTotalNumber:@"2" AddIndex:1];
}

- (void) NumbersTap3
{
    [self appendTotalNumber:@"3" AddIndex:1];
}

- (void) NumbersTap4
{
    [self appendTotalNumber:@"4" AddIndex:1];
}

- (void) NumbersTap5
{
    [self appendTotalNumber:@"5" AddIndex:1];
}

- (void) NumbersTap6
{
    [self appendTotalNumber:@"6" AddIndex:1];
}

- (void) NumbersTap7
{
    [self appendTotalNumber:@"7" AddIndex:1];
}

- (void) NumbersTap8
{
    [self appendTotalNumber:@"8" AddIndex:1];
}

- (void) NumbersTap9
{
    [self appendTotalNumber:@"9" AddIndex:1];
}



@end
