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
    ReversiReverseCountMap *_reverseCountMap;
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
                        initWithStageMap:game.boardMap
                        player:_player];
    game.effectPhase = 0;
    return self;
}

- (id<ReversiScene>)nextFrame:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect boardRect = [ReversiLib boardRect:viewRect];
    
    ReversiPosition* pos = nil;
    if (game.gesture.decide){
        pos = [ReversiLib selectedPos:boardRect
                                    location:game.gesture.location];
        id __reverseCountMap = [_reverseCountMap get:pos];
        if (__reverseCountMap != [NSNull null]) {
            [game send:_player pos:pos];
            return [[ReversiSceneReverse alloc] initWithPlayer:_player
                                                    decidedPos:pos
                                               reverseCountMap:__reverseCountMap];
        }
    }
        
    return nil;
}

- (void)draw:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect boardRect = [ReversiLib boardRect:viewRect];
    
    ReversiPosition* selectedPos = nil;
    if (game.gesture.touching){
        selectedPos = [ReversiLib selectedPos:boardRect
                                     location:game.gesture.location];
    }
    for(int r = 0;r < ROWS;r++){
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            id tmp = [_reverseCountMap get:pos];
            if (tmp != [NSNull null]) {
                CGRect cellRect = [ReversiLib cellRect:boardRect pos:pos];
                if ([pos isEqual:selectedPos]) {
                    [ReversiDraw drawSelectedCell:cellRect];
                }else{
                    [ReversiDraw drawSelectableCell:cellRect
                                              phase:game.effectPhase];
                }
            }
        }
    }
    
    [ReversiDraw drawBoard:boardRect];
    
    for(int r = 0;r < ROWS;r++){
        for(int c = 0;c < COLS;c++){
            ReversiPosition* pos = [ReversiPosition posWithRow:r col:c];
            CGRect cellRect = [ReversiLib cellRect:boardRect pos:pos];
            CGRect stoneRect = [ReversiLib stoneRect:cellRect];
            [ReversiDraw drawStone:stoneRect
                              type:[game.boardMap getInt:pos]];
        }
    }
    
    [ReversiDraw drawTurnIndicate:boardRect
                    currentPlayer:_player
                           player:game.player
                            phase:game.effectPhase];
    [ReversiDraw drawStoneCount:boardRect boardMap:game.boardMap];
}

@end
