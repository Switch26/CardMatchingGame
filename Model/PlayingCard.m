//
//  PlayingCard.m
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/4/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards{
    
    int score = 0;
    
    if ([otherCards count]== 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) score = 4;
        else if ([otherCard.suit isEqualToString:self.suit]) score = 1;
    }
    if ([otherCards count]== 2){
        PlayingCard *card1 = [otherCards objectAtIndex:0];
        PlayingCard *card2 = [otherCards objectAtIndex:1];
        
        if (card1.rank == self.rank) score += 4;
        else if ([card1.suit isEqualToString:self.suit]) score += 1;
        
        if (card2.rank == self.rank) score += 4;
        else if ([card2.suit isEqualToString:self.suit]) score += 1;
        
        if (card1.rank == card2.rank) score += 4;
        else if ([card1.suit isEqualToString:card2.suit]) score += 1;

    }

    return score;
}

+(NSArray *) validSuits{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+(NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

-(NSString *) contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

-(void) setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject: suit]) {
        _suit = suit;
    }
}

-(NSString *) suit{
    return _suit ? _suit : @"?";
}

+(NSUInteger) maxRank{
    return [[self rankStrings] count]-1;
}

-(void) setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
