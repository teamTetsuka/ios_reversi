//
//  ReversiSceneReverse.m
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiSceneReverse.h"
#import "ReversiView.h"
#import "ReversiGame.h"
#import "ReversiMap.h"
#import "ReversiReverseCountMap.h"
#import "ReversiPosition.h"
#import "ReversiLib.h"
#import "ReversiDraw.h"
#import "ReversiSceneOperation.h"
#import "ReversiSceneWait.h"

@interface ReversiSceneReverse()
{
    int _count;
    EStoneType _player;
    ReversiPosition* _decidedPos;
    NSDictionary* _reverseCountMap;
    ReversiMap* _reverseMap;
}
@end

@implementation ReversiSceneReverse

- (id)initWithPlayer:(EStoneType)player
          decidedPos:(ReversiPosition *)decidedPos
     reverseCountMap:(NSDictionary *)reverseCountMap
{
    self = [super init];
    if (self) {
        _count = 0;
        _player = player;
        _decidedPos = decidedPos;
        _reverseCountMap = reverseCountMap;
        [self createReverseMap];
    }
    return self;
}

- (void)createReverseMap
{
    _reverseMap = [[ReversiMap alloc] initWithDefaultValue:@(FALSE)];
    for (id k in [_reverseCountMap keyEnumerator]) {
        EDirection dir = [k integerValue];
        int count = [_reverseCountMap[k] integerValue];
        ReversiPosition* pos = _decidedPos;
        for (int i = 0; i < count; i++) {
            pos = [pos neighbor:dir];
            [_reverseMap put:pos value:@(TRUE)];
        }
    }
}

- (id<ReversiScene>)begin:(ReversiGame *)game
{
    return self;
}

- (id<ReversiScene>)nextFrame:(ReversiGame *)game
{
    if (_count == 20) {
        [game.boardMap put:_decidedPos value:@(_player)];
        for(int r = 0;r < ROWS;r++){
            for(int c = 0;c < COLS;c++){
                ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
                if ([_reverseMap getInt:pos]) {
                    int opponent = [ReversiLib opponent:[game.boardMap getInt:pos]];
                    [game.boardMap put:pos value:@(opponent)];
                }
            }
        }
        EStoneType opponent = [ReversiLib opponent:_player];
        if (opponent == game.player) {
            return [[ReversiSceneOperation alloc] initWithPlayer:opponent];
        }else{
            return [[ReversiSceneWait alloc] initWithPlayer:opponent];
        }
        
    }else{
        _count++;
        return nil;
    }
}

- (void)draw:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect boardRect = [ReversiLib boardRect:viewRect];
    EStoneType opponent = [ReversiLib opponent:_player];
    
    [ReversiDraw drawBoard:boardRect];
    
    for(int r = 0;r < ROWS;r++){
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            CGRect cellRect = [ReversiLib cellRect:boardRect pos:pos];
            CGRect stoneRect = [ReversiLib stoneRect:cellRect];
            if ([_decidedPos isEqual:pos]) {
                [ReversiDraw drawStone:stoneRect type:_player];
            }
            if (![_reverseMap getInt:pos]) {
                [ReversiDraw drawStone:stoneRect
                                  type:[game.boardMap getInt:pos]];
            }
        }
    }
    for(int r = 0;r < ROWS;r++){
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            CGRect cellRect = [ReversiLib cellRect:boardRect pos:pos];
            CGRect stoneRect = [ReversiLib stoneRect:cellRect];
            if ([_reverseMap getInt:pos]) {
                [ReversiDraw drawStone:stoneRect
                                  type:opponent
                               reverse:_count / 20.0];
            }
        }
    }
    
    [ReversiDraw drawTurnIndicate:boardRect
                    currentPlayer:_player
                           player:game.player
                            phase:game.effectPhase];
    [ReversiDraw drawStoneCount:boardRect boardMap:game.boardMap];
}

@end
