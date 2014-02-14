//
//  ReversiGame.m
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiGame.h"
#import "ReversiView.h"
#import "ReversiMap.h"
#import "ReversiGesuture.h"
#import "ReversiPosition.h"
#import "ReversiScene.h"
#import "ReversiSceneOperation.h"

@interface ReversiGame()
{
    id<ReversiScene> _scene;
    id<ReversiScene> _nextScene;
}
@end

@implementation ReversiGame

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self){
        _view = [[ReversiView alloc]
                 initWithFrame:CGRectMake(0, 20,
                                          frame.size.width,
                                          frame.size.height - 20)
                 game:self];
        _nextScene = [[ReversiSceneOperation alloc]
                      initWithPlayer:STONE_BLACK];
        _gesture = [[ReversiGesuture alloc] init];
        [self stageInit];
        _effectPhase = 0;
        [NSTimer scheduledTimerWithTimeInterval:0.02f
                                         target:self
                                       selector:@selector(nextFrame:)
                                       userInfo:NULL
                                        repeats:YES];
    }
    return self;
}

-(void)nextFrame:(NSTimer*)timer
{
    if (_nextScene != nil) {
        _scene = [_nextScene begin:self];
        _nextScene = nil;
    }
    _nextScene = [_scene nextFrame:self];
    [_gesture nextFrame];
    [_view setNeedsDisplay];
    _effectPhase += 0.02;
    if (_effectPhase > 1) _effectPhase = 0;
}

-(void)draw
{
    [_scene draw:self];
}

-(void)stageInit
{
    _boardMap = [[ReversiMap alloc] initWithDefaultValue:@(STONE_NONE)];
    {
        ReversiPosition* pos = [ReversiPosition posWithRow:ROWS / 2 - 1
                                                       col:COLS / 2 - 1];
        [_boardMap put:pos value:@(STONE_WHITE)];
    }
    {
        ReversiPosition* pos = [ReversiPosition posWithRow:ROWS / 2
                                                       col:COLS / 2];
        [_boardMap put:pos value:@(STONE_WHITE)];
    }
    {
        ReversiPosition* pos = [ReversiPosition posWithRow:ROWS / 2 - 1
                                                       col:COLS / 2];
        [_boardMap put:pos value:@(STONE_BLACK)];
    }
    {
        ReversiPosition* pos = [ReversiPosition posWithRow:ROWS / 2
                                                       col:COLS / 2 - 1];
        [_boardMap put:pos value:@(STONE_BLACK)];
    }
}

@end
