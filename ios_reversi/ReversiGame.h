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
@class ReversiPosition;

@interface ReversiGame : NSObject<NSURLConnectionDataDelegate>
@property (nonatomic, strong)ReversiMap *boardMap;
@property (nonatomic, strong)ReversiGesuture *gesture;
@property (nonatomic, readonly)ReversiView *view;
@property (nonatomic, assign)EStoneType player;
@property (nonatomic, strong)NSDictionary *receiptData;
@property (nonatomic, assign)float effectPhase;
- (id)initWithFrame:(CGRect)frame
          sessionId:(NSString*)sessionId
             player:(EStoneType)player;
- (void)draw;
- (void)boardSetup;
- (void)send:(EStoneType)player pos:(ReversiPosition *)pos;
- (BOOL)isSerialUpdated;
- (void)serialUpdate;
@end
