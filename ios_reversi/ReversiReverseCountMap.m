//
//  ReversiReverseMap.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/09.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiReverseCountMap.h"
#import "ReversiPosition.h"
#import "ReversiLib.h"

@implementation ReversiReverseCountMap

- (id)initWithStageMap:(ReversiMap *)stageMap player:(EStoneType)player
{
    self = [super initWithDefaultValue:[NSNull null]];
    if (self) {
        [self initAux:stageMap player:player];
    }
    return self;
}

- (void)initAux:(ReversiMap*)stageMap player:(EStoneType)player
{
    for(int r = 0;r < ROWS;r++) {
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            if ([stageMap getInt:pos] == STONE_NONE) {
                NSMutableDictionary* countMap = [@{} mutableCopy];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_ABOVE];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_BELOW];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_LEFT];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_RIGHT];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_ABOVELEFT];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_ABOVERIGHT];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_BELOWLEFT];
                [self fillCount:countMap stageMap:stageMap player:player
                            pos:pos dir:DIR_BELOWRIGHT];
                if (countMap.count > 0) {
                    [self put:pos value:countMap];
                }
            }
        }
    }
}

- (void)fillCount:(NSMutableDictionary*)countMap
         stageMap:(ReversiMap*)stageMap
           player:(EStoneType)player
              pos:(ReversiPosition*)pos
              dir:(EDirection)dir
{
    EStoneType opponent = [ReversiLib opponent:player];
    ReversiPosition* _pos = [pos neighbor:dir];
    if ([stageMap getInt:_pos] != opponent) {
        return;
    }
    int count = 1;
    while (true) {
        _pos = [_pos neighbor:dir];
        EStoneType type = [stageMap getInt:_pos];
        if (type == opponent) {
            count++;
        }else{
            if (type == player){
                [countMap setObject:@(count) forKey:@(dir)];
            }
            return;
        }
    }
}

@end
