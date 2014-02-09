//
//  ReversiPosision.m
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiPosition.h"

@implementation ReversiPosition

- (id)initWithRow:(int)row col:(int)col
{
    self = [super init];
    if (self) {
        _row = row;
        _col = col;
    }
    return self;
}

+ (id)posWithRow:(int)row col:(int)col
{
    return [[ReversiPosition alloc] initWithRow:row col:col];
}

- (id)neighbor:(EDirection)dir
{
    switch (dir) {
        case DIR_ABOVE:
            return [ReversiPosition posWithRow:self.row - 1 col:self.col];
            break;
        case DIR_BELOW:
            return [ReversiPosition posWithRow:self.row + 1 col:self.col];
            break;
        case DIR_LEFT:
            return [ReversiPosition posWithRow:self.row col:self.col - 1];
            break;
        case DIR_RIGHT:
            return [ReversiPosition posWithRow:self.row col:self.col + 1];
            break;
        case DIR_ABOVELEFT:
            return [ReversiPosition posWithRow:self.row - 1 col:self.col - 1];
            break;
        case DIR_ABOVERIGHT:
            return [ReversiPosition posWithRow:self.row - 1 col:self.col + 1];
            break;
        case DIR_BELOWLEFT:
            return [ReversiPosition posWithRow:self.row + 1 col:self.col - 1];
            break;
        case DIR_BELOWRIGHT:
            return [ReversiPosition posWithRow:self.row + 1 col:self.col + 1];
            break;
    }
}

- (NSUInteger)hash{
    return _row * ROWS + _col;
}

- (BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[ReversiPosition class]]) {
        ReversiPosition* tmp = object;
        return _col == tmp.col && _row == tmp.row;
    }else{
        return false;
    }
}

@end