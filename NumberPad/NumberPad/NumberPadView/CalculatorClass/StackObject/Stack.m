//
//  Stack.m
//  NumberPad
//
//  Created by Administrator on 17/11/2015.
//  Copyright © 2015 munfai. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(id)init
{
    self = [super init];
    
    if (self)
    {
        stack = [[NSMutableArray alloc]init];
    }
    
    return self;
}

-(void)push:(id)object
{
    [stack addObject:object];
}

-(id)pop
{
    if ([self getStackCount] > 0)
    {
        id lastObject = stack.lastObject;
        [stack removeObject:lastObject];
        
        return lastObject;
    }
    else
        return nil;
}

-(NSInteger)getStackCount
{
    return stack.count;
}

-(void)reset
{
    [stack removeAllObjects];
}


-(id)getObjectAtIndex:(NSInteger)index
{
    if ([self getStackCount] > 0)
        return [stack objectAtIndex:index];
    else
        return nil;
}

-(NSMutableArray *)getAllObject
{
    return stack;
}


-(id)calculate
{
    if ([self getStackCount] == 4)
    {
        id object = [self internalCalculation];
        id lastObject = [stack lastObject];
        
        [self reset];
        
        [self push:object];
        [self push:lastObject];
        
        [self internalSetLastObject];
        
        return object;
    }
    else if ([self getStackCount] == 3)
    {
        id object = [self internalCalculation];
        
        [self reset];
        
        [self push:object];
        
        [self internalSetLastObject];
        
        return object;
    }
    else if ([self getStackCount] == 1 || [self getStackCount] == 2)
    {
        [self internalSetLastObject];
        
        return [stack firstObject];
    }
    else
        return nil;
}


-(id)internalCalculation
{
    CalculatorComponent *firstValue = (CalculatorComponent *)[stack objectAtIndex:0];
    CalculatorComponent *secondValue = (CalculatorComponent *)[stack objectAtIndex:2];
    
    CalculatorComponent *operatorObject = (CalculatorComponent *)[stack objectAtIndex:1];
    
    CalculatorComponent *valueObject = [[CalculatorComponent alloc]init];
    valueObject.isOperator = NO;
    
    switch (operatorObject.selectedOperation)
    {
        case CalculatorOperation_Plus:
        {
            valueObject.value = firstValue.value + secondValue.value;
        }
            break;
            
        case CalculatorOperation_Minus:
        {
            valueObject.value = firstValue.value - secondValue.value;
        }
            break;
            
        case CalculatorOperation_Multiply:
        {
            valueObject.value = firstValue.value * secondValue.value;
        }
            break;
            
        case CalculatorOperation_Divide:
        {
            valueObject.value = firstValue.value / secondValue.value;
        }
            break;
            
        default:
            valueObject = nil;
            break;
    }
    
    if (valueObject != nil)
    {
        valueObject.valueString = [NSString stringWithFormat:@"%.2f", valueObject.value];
    }
    
    return valueObject;
}

-(void)internalSetLastObject
{
    if ([self getStackCount] > 0)
        self.lastObject = stack.lastObject;
    else
        self.lastObject = nil;
}

@end
