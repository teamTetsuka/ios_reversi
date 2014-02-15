//
//  ReversiSceneWait.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/15.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiSceneWait.h"
#import "ReversiGame.h"
#import "ReversiView.h"
#import "ReversiMap.h"
#import "ReversiReverseCountMap.h"
#import "ReversiPosition.h"
#import "ReversiLib.h"
#import "ReversiDraw.h"
#import "ReversiSceneReverse.h"

@interface ReversiSceneWait()
{
    EStoneType _player;
    ReversiReverseCountMap *_reverseCountMap;
}
@end

@implementation ReversiSceneWait

- (id)initWithPlayer:(EStoneType)player
{
    self = [super init];
    if (self){
        _player = player;
    }
    return self;
}

-(id<ReversiScene>)begin:(ReversiGame *)game
{
    _reverseCountMap = [[ReversiReverseCountMap alloc]
                        initWithStageMap:game.boardMap
                        player:_player];
    game.effectPhase = 0;
    return self;
}

- (id<ReversiScene>)nextFrame:(ReversiGame *)game
{
    EStoneType receiptPlayer = [game.receiptData[@"p"] integerValue];
    if ([game isSerialUpdated] && receiptPlayer == _player) {
        [game serialUpdate];
        ReversiPosition *pos =
        [ReversiPosition posWithRow:[game.receiptData[@"r"] integerValue]
                                col:[game.receiptData[@"c"] integerValue]];
        NSDictionary *countMap = [_reverseCountMap get:pos];
        return [[ReversiSceneReverse alloc] initWithPlayer:_player
                                                decidedPos:pos
                                           reverseCountMap:countMap];
    }
    return nil;
}

- (void)draw:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect boardRect = [ReversiLib boardRect:viewRect];
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
