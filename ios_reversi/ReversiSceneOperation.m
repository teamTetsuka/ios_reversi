//
//  ReversiSceneOperation.m
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiSceneOperation.h"
#import "ReversiView.h"
#import "ReversiGame.h"
#import "ReversiGesuture.h"
#import "ReversiMap.h"
#import "ReversiReverseCountMap.h"
#import "ReversiPosition.h"
#import "ReversiLib.h"
#import "ReversiDraw.h"
#import "ReversiSceneReverse.h"

@interface ReversiSceneOperation()
{
    EStoneType _player;
    ReversiReverseCountMap* _reverseCountMap;
}
@end

@implementation ReversiSceneOperation

- (id)initWithPlayer:(EStoneType)player
{
    self = [super init];
    if (self){
        _player = player;
    }
    return self;
}

- (id<ReversiScene>)begin:(ReversiGame *)game
{
    _reverseCountMap = [[ReversiReverseCountMap alloc]
                        initWithStageMap:game.stageMap
                        player:_player];
    game.effectPhase = 0;
    return self;
}

- (id<ReversiScene>)nextFrame:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect stageRect = [ReversiLib stageRect:viewRect];
    
    ReversiPosition* decidedPos = nil;
    if (game.gesture.decide){
        decidedPos = [ReversiLib selectedPos:stageRect location:game.gesture.location];
        id __reverseCountMap = [_reverseCountMap get:decidedPos];
        if (__reverseCountMap != [NSNull null]) {
            return [[ReversiSceneReverse alloc] initWithPlayer:_player
                                                    decidedPos:decidedPos
                                               reverseCountMap:__reverseCountMap];
        }
    }
        
    return nil;
}

- (void)draw:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect stageRect = [ReversiLib stageRect:viewRect];
    
    ReversiPosition* selectedPos = nil;
    if (game.gesture.touching){
        selectedPos = [ReversiLib selectedPos:stageRect location:game.gesture.location];
    }
    for(int r = 0;r < ROWS;r++){
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            id tmp = [_reverseCountMap get:pos];
            if (tmp != [NSNull null]) {
                CGRect cellRect = [ReversiLib cellRect:stageRect pos:pos];
                if ([pos isEqual:selectedPos]) {
                    [ReversiDraw drawSelectedCell:cellRect];
                }else{
                    [ReversiDraw drawSelectableCell:cellRect phase:game.effectPhase];
                }
            }
        }
    }
    
    [ReversiDraw drawStage:stageRect];
    
    for(int r = 0;r < ROWS;r++){
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            CGRect cellRect = [ReversiLib cellRect:stageRect pos:pos];
            CGRect stoneRect = [ReversiLib stoneRect:cellRect];
            [ReversiDraw drawStone:stoneRect
                              type:[game.stageMap getInt:pos]];
        }
    }
    
    [ReversiDraw drawTurnIndicate:stageRect
                             turn:_player
                           myself:STONE_BLACK
                            phase:game.effectPhase];
    [ReversiDraw drawStoneCount:stageRect stageMap:game.stageMap];
}

@end
