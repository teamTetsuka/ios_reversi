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
#import "ReversiSceneWaitStart.h"
#import "ReversiSceneWait.h"

@interface PutRequestSender : NSObject<NSURLConnectionDataDelegate>
{
    int nn;
    ReversiGame *_game;
    NSURLConnection* _connection;
}
@end

@interface ReversiGame()
{
    int nn;
    NSURLConnection *_connection;
    PutRequestSender *_putRequestSender;
    NSString *_sessionId;
    id<ReversiScene> _scene;
    id<ReversiScene> _nextScene;
    int _serialNo;
}
- (void)serialUpdate:(int)serialNo;
@end


@implementation PutRequestSender
- (id)initWithGame:(ReversiGame*)game
{
    self = [super init];
    if (self){
        nn = 0;
        _game = game;
    }
    return self;
}
- (void)send:(NSString*)sessionId player:(EStoneType)player pos:(ReversiPosition *)pos
{
    nn++;
    NSURLRequest *request =
    [NSURLRequest requestWithURL:
     [NSURL URLWithString:
      [NSString stringWithFormat:@"%@/p?id=%@&p=%d&r=%d&c=%d&nn=%d",
       SERVER_URL, sessionId, player, pos.row, pos.col, nn]]];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSDictionary *_data = [NSJSONSerialization JSONObjectWithData:data
                                                          options:0
                                                            error:nil];
    [_game serialUpdate:[_data[@"n"] integerValue]];
}
@end

@implementation ReversiGame

- (id)initWithFrame:(CGRect)frame
          sessionId:(NSString *)sessionId
             player:(EStoneType)player
{
    self = [super init];
    if (self){
        nn = 0;
        _sessionId = sessionId;
        _player = player;
        _effectPhase = 0;
        _serialNo = 0;
        _view = [[ReversiView alloc]
                 initWithFrame:CGRectMake(0, 20,
                                          frame.size.width,
                                          frame.size.height - 20)
                 game:self];
        _gesture = [[ReversiGesuture alloc] init];
        _putRequestSender = [[PutRequestSender alloc] init];
        _receiptData = nil;
        [self boardSetup];
        switch (_player) {
            case STONE_BLACK:
                _nextScene = [[ReversiSceneWaitStart alloc] init];
                break;
            case STONE_WHITE:
                _nextScene = [[ReversiSceneWait alloc] initWithPlayer:STONE_BLACK];
                break;
            default:
                break;
        }
        [NSTimer scheduledTimerWithTimeInterval:0.02f
                                         target:self
                                       selector:@selector(nextFrame:)
                                       userInfo:NULL
                                        repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(poll:)
                                       userInfo:NULL
                                        repeats:NO];
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

-(void)poll:(NSTimer*)timer
{
    nn++;
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:
     [NSString stringWithFormat:@"%@/g?id=%@&nn=%d", SERVER_URL, _sessionId, nn]]];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _receiptData = [NSJSONSerialization JSONObjectWithData:data
                                                   options:0
                                                     error:nil];
    NSLog(@"n=%@, p=%@", _receiptData[@"n"], _receiptData[@"p"]);
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(poll:)
                                   userInfo:NULL
                                    repeats:NO];
}

- (void)send:(EStoneType)player pos:(ReversiPosition *)pos
{
    [_putRequestSender send:_sessionId player:player pos:pos];
}

- (BOOL)isSerialUpdated
{
    if (_receiptData == nil) {
        return false;
    }else{
        return _serialNo < [_receiptData[@"n"] integerValue];
    }
}

- (void)serialUpdate
{
    if (_receiptData != nil) {
        [self serialUpdate:[_receiptData[@"n"] integerValue]];
    }
}

- (void)serialUpdate:(int)serialNo
{
    _serialNo = serialNo;
}

-(void)draw
{
    [_scene draw:self];
}

-(void)boardSetup
{
    _boardMap = [[ReversiMap alloc] initWithDefaultValue:@(STONE_NONE)];
    [_boardMap put:[ReversiPosition posWithRow:ROWS / 2 - 1
                                           col:COLS / 2 - 1]
             value:@(STONE_BLACK)];
    [_boardMap put:[ReversiPosition posWithRow:ROWS / 2
                                           col:COLS / 2]
             value:@(STONE_BLACK)];
    [_boardMap put:[ReversiPosition posWithRow:ROWS / 2 - 1
                                           col:COLS / 2]
             value:@(STONE_WHITE)];
    [_boardMap put:[ReversiPosition posWithRow:ROWS / 2
                                           col:COLS / 2 - 1]
             value:@(STONE_WHITE)];
}

@end
