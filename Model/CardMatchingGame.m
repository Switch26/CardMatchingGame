//
//  CardMatchingGame.m
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/5/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSMutableArray *lastPickedCards; // Temp array to hold selected cards
@property (nonatomic, readwrite) NSInteger lastScore;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSInteger)gameMode_2_or_3{
    // Lazy instantination with Default - 2 card game
    if (!_gameMode_2_or_3) _gameMode_2_or_3 = 2;
    return _gameMode_2_or_3;
}

-(instancetype)initWithCardCount:(NSInteger)count
                       usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card)[self.cards addObject:card];
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index]; // picked card is now "card"
        if (!card.isMatched) { // if card is not matched
            if (card.isChosen) card.chosen = NO; // flip it back and un-choose it
            else {  // if card is still not matched and not chosen
             // match against other chosen cards
                NSMutableArray *otherCards = [[NSMutableArray alloc] init];  // create an empty array to store picked cards
                
                for (Card *otherCard in self.cards){ // look through the array of cards to make our matches
                    if (otherCard.isChosen && !otherCard.isMatched){ // if we find a case when otherCard in a deck is not mached and also chosen
                        
                        [otherCards addObject:otherCard]; // lets add this card into an lastPickedCards array
                    }
                }
                // now we have an array otherCards which containts all other cards that are picked and not matched yet
                
                        if ([otherCards count] + 1 == self.gameMode_2_or_3) {
                             int matchScore = [card match:otherCards];
                            self.lastPickedCards = [[NSMutableArray alloc] initWithArray:otherCards];
                            [self.lastPickedCards addObject: card];
                            
                            if (matchScore){
                                self.score += matchScore * MATCH_BONUS;
                                self.lastScore = matchScore * MATCH_BONUS;
                                card.matched = YES;
                                for (Card *matchedCards in otherCards) matchedCards.matched = YES;
                            }else {
                                self.score -= MISMATCH_PENALTY;
                                self.lastScore = 0 - MISMATCH_PENALTY;
                                for (Card *matchedCards in otherCards) matchedCards.chosen = NO;
                            }
                        }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
   }

@end




