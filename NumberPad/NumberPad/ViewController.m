//
//  ViewController.m
//  NumberPad
//
//  Created by Mun Fai Leong on 8/5/15.
//  Copyright (c) 2015 munfai. All rights reserved.
//

#import "ViewController.h"

#import "GBNumberPad.h"

@interface ViewController () <GBNumberPadViewDelegate>
{
    GBNumberPad *myNumberPad;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:40.0/255.0 green:132.0/255.0 blue:220.0/255.0 alpha:1];
    
    [self createNumberPadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNumberPadView
{
    myNumberPad = [[GBNumberPad alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    myNumberPad.hasAddButton = YES;

    myNumberPad.amountFontSize = 120;
    myNumberPad.numberFontSize = 25;

    //myNumberPad.amountFontName = @"";
    //myNumberPad.numberFontName = @"";
    
    myNumberPad.backImage = [UIImage imageNamed:@"sample_back"];
    myNumberPad.addImage = [UIImage imageNamed:@"sample_add_button"];
    
    myNumberPad.myBackgroundColor = [UIColor clearColor];
    myNumberPad.backgroundColor = [UIColor clearColor];
    
    myNumberPad.myTextAmountColor = [UIColor cyanColor];
    myNumberPad.myTextColor = [UIColor whiteColor];
    myNumberPad.myBorderColor = [UIColor lightGrayColor];
    myNumberPad.myTextAmountAlignment = NSTextAlignmentCenter;
    
    myNumberPad.isSubViewNeedBorder = NO;
    myNumberPad.isOuterViewFrameNeedBorder = NO;
    
    myNumberPad.myNumberPadVariation = NumberPadVariationDoubleZeroType;
    myNumberPad.myTextAmountUsesSuperscript = YES;
    myNumberPad.myTextAmountAddCommaEvery3Digits = YES;
    
    myNumberPad.myAmountViewHeight = 180;
    myNumberPad.myQuarterHeight = 60;
    myNumberPad.myAmountViewY = self.view.frame.size.height / 2 - (180 + 60 * 4) / 2;
    
    [self.view addSubview:myNumberPad];
    
}

@end
