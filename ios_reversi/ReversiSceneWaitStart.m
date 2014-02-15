//
//  ReversiSceneWaitStart.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/14.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiSceneWaitStart.h"
#import "ReversiGame.h"
#import "ReversiView.h"
#import "ReversiLib.h"
#import "ReversiDraw.h"
#import "ReversiSceneOperation.h"

@implementation ReversiSceneWaitStart

- (id<ReversiScene>)begin:(ReversiGame *)game
{
    return self;
}

- (id<ReversiScene>)nextFrame:(ReversiGame *)game
{
    if ([game isSerialUpdated]) {
        [game serialUpdate];
        return [[ReversiSceneOperation alloc] initWithPlayer:STONE_BLACK];
    }
    return nil;
}

- (void)draw:(ReversiGame *)game
{
    CGRect viewRect = game.view.bounds;
    CGRect boardRect = [ReversiLib boardRect:viewRect];
    [ReversiDraw drawBoard:boardRect];
    [ReversiDraw drawTurnIndicate:boardRect
                    currentPlayer:STONE_NONE
                           player:game.player
                            phase:game.effectPhase];
}

@end
