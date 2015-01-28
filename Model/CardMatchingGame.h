//
//  CardMatchingGame.h
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/5/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// Designated initializer
-(instancetype)initWithCardCount: (NSInteger)count
                       usingDeck: (Deck *)deck;
-(void) chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger gameMode_2_or_3;
@property (nonatomic, readonly) NSMutableArray *lastPickedCards;
@property (nonatomic, readonly) NSInteger lastScore;

@end
