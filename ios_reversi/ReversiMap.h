//
//  ReversiMap.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReversiPosition;

@interface ReversiMap : NSObject
- (id)initWithDefaultValue:(id)defalutValue;
- (id)get:(ReversiPosition*)pos;
- (int)getInt:(ReversiPosition*)pos;
- (void)put:(ReversiPosition*)pos value:(id)value;
@end
