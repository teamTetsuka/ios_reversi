//
//  ReversiGame.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReversiMap;
@class ReversiView;
@class ReversiGesuture;

@interface ReversiGame : NSObject
@property (nonatomic, strong)ReversiMap *boardMap;
@property (nonatomic, strong)ReversiGesuture *gesture;
@property (nonatomic, readonly)ReversiView* view;
@property (nonatomic, assign)float effectPhase;
- (id)initWithFrame:(CGRect)frame;
- (void)draw;
- (void)stageInit;
@end
