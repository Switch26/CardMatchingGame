//
//  Deck.h
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/4/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard: (Card *)card atTop:(BOOL) atTop;
-(void) addCard: (Card *)card;

-(Card *)drawRandomCard;

@end
