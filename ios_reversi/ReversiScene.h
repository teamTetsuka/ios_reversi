//
//  ReversiScene.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReversiView;
@class ReversiGame;


@protocol ReversiScene <NSObject>
-(id<ReversiScene>)begin:(ReversiGame*)game;
-(id<ReversiScene>)nextFrame:(ReversiGame*)game;
-(void)draw:(ReversiGame*)game;
@end
