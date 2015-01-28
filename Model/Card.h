//
//  Card.h
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/4/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match: (NSArray *) otherCards;

@end
