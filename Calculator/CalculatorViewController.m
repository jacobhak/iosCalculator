//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Jacob Håkansson on 2012-11-22.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

- (CalculatorBrain *)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsEnteringNumber = YES;
    }
}
- (IBAction)pointPressed:(UIButton *)sender {
    if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
        [self digitPressed:sender];
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsEnteringNumber = NO;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsEnteringNumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}
@end
