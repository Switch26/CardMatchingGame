//
//  ViewController.m
//  StanfordMatchismo
//
//  Created by Serguei Vinnitskii on 11/4/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSInteger currentGameMode;
- (IBAction)mode_2or3:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControlOutlet;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

-(void) viewDidLoad
{
    [self setNeedsStatusBarAppearanceUpdate];
}

-(CardMatchingGame *) game {
    if (!_game) [self startNewGame];
    return _game;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self.segControlOutlet setEnabled:NO];
}

-(void) updateUI {
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    NSString *gameStatus = [[NSString alloc] init];
    for (Card *card in self.game.lastPickedCards) {
        gameStatus = [gameStatus stringByAppendingFormat:@"%@", card.contents];
    }
    
    if (self.game.lastScore > 1) {
        self.textLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points!", gameStatus, self.game.lastScore];
    }
    else if (self.game.lastScore < 0) {
        self.textLabel.text = [NSString stringWithFormat:@"%@ don't match! %d points penalty!", gameStatus, -self.game.lastScore];
    }
}

-(NSString *)titleForCard: (Card*)card {
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)newGameButton:(UIButton *)sender {
    [self startNewGame];
    [self updateUI];
    [self.segControlOutlet setEnabled:YES];
    self.textLabel.text = nil;
}

- (void) startNewGame{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    self.game.gameMode_2_or_3 = self.currentGameMode;
}

- (IBAction)mode_2or3:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.game.gameMode_2_or_3 = 2;
        self.currentGameMode = 2;
    }
    if (sender.selectedSegmentIndex == 1){
        self.game.gameMode_2_or_3 = 3;
        self.currentGameMode = 3;
    }
}

@end
