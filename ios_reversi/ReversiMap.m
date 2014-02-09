//
//  ReversiMap.m
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiMap.h"
#import "ReversiPosition.h"

@interface ReversiMap()
{
    id _defaultValue;
    NSMutableArray *_map;
}
@end

@implementation ReversiMap

-(id)initWithDefaultValue:(id)defalutValue
{
    self = [super init];
    if (self) {
        int count = COLS * ROWS;
        _defaultValue = defalutValue;
        _map = [NSMutableArray arrayWithCapacity:count];
        for(int i = 0;i < count;i++){
            [_map addObject:_defaultValue];
        }
    }
    return self;
}

- (id)get:(ReversiPosition *)pos
{
    if (pos.row < 0 || pos.row >= ROWS ||
        pos.col < 0 || pos.col >= COLS) {
        return _defaultValue;
    }
    return [_map objectAtIndex:pos.row * COLS + pos.col];
}

- (int)getInt:(ReversiPosition *)pos
{
    return [[self get:pos] integerValue];
}

- (void)put:(ReversiPosition *)pos value:(id)value
{
    if (pos.row < 0 || pos.row >= ROWS ||
        pos.col < 0 || pos.col >= COLS) {
        return;
    }
    [_map replaceObjectAtIndex:pos.row * COLS + pos.col withObject:value];
}
@end
