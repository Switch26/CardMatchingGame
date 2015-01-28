//
//  PlayingCard.h
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/4/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
