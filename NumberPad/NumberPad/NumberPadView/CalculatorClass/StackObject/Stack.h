//
//  Stack.h
//  NumberPad
//
//  Created by Administrator on 17/11/2015.
//  Copyright © 2015 munfai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorComponent.h"

@interface Stack : NSObject
{
    NSMutableArray *stack;
}

@property (nonatomic) id lastObject;

-(void)push:(id)object;

-(id)pop;

-(NSInteger)getStackCount;

-(id)getObjectAtIndex:(NSInteger)index;

-(NSMutableArray *)getAllObject;

-(id)calculate;

-(void)reset;

@end
