//
//  CalculatorComponent.h
//  NumberPad
//
//  Created by Administrator on 17/11/2015.
//  Copyright © 2015 munfai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBNumberPadUtils.h"

@interface CalculatorComponent : NSObject

@property (nonatomic) BOOL isOperator;

@property (nonatomic) CalculatorOperation selectedOperation;

@property (nonatomic) double value;

@property (nonatomic) NSString *valueString;

@end
