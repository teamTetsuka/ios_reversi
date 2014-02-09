//
//  ReversiPosision.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReversiPosition : NSObject
@property (nonatomic, readonly)int row;
@property (nonatomic, readonly)int col;
-(id)initWithRow:(int)row col:(int)col;
+(id)posWithRow:(int)row col:(int)col;
-(id)neighbor:(EDirection)dir;
@end
