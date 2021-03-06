//
//  ViewController.m
//  Two Player Math Game
//
//  Created by Chloe on 2016-01-18.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import "ViewController.h"
#import "GameModel.h"
#import "Player.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (nonatomic, strong) NSMutableArray *inputNumbers;
@property (nonatomic, strong) GameModel *startGame;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _startGame = [[GameModel alloc] init];
    _inputNumbers = [[NSMutableArray alloc] init];

    [self playGame];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playGame {
    if (self.startGame.player1.lives == 0 || self.startGame.player2.lives == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"GAME OVER!!!"
                                                                       message:@"Do you want to play again?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Hell yes!" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  self.startGame.player1.lives = 3;
                                                                  self.startGame.player2.lives = 3;
                                                                  self.startGame.currentPlayer = YES;
                                                                  [self playGame];
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        NSLog(@"Game Over!");
    } else {
        if (self.startGame.currentPlayer) {
            [self.startGame generateEquation:self.startGame.player1];
            self.titleLabel.text = self.startGame.displayEquation;
            self.player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1 Score: %d", self.startGame.player1.lives];
            self.player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2 Score: %d", self.startGame.player2.lives];
        } else {
            [self.startGame generateEquation:self.startGame.player2];
            self.titleLabel.text = self.startGame.displayEquation;
            self.player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1 Score: %d", self.startGame.player1.lives];
            self.player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2 Score: %d", self.startGame.player2.lives];
        }
    }
}

- (void)createAnswer {
    NSString *answerString = [self.inputNumbers componentsJoinedByString:@""];
    [self.inputNumbers removeAllObjects];
    self.startGame.inputAnswer = [answerString intValue];
    NSLog(@"%d", self.startGame.inputAnswer);
}

#pragma mark - Number Buttons

- (IBAction)enterButton:(UIButton *)sender {
    [self createAnswer];
    if ([self.startGame checkAnswer]) {
        self.answerLabel.text = @"Correct!";
        self.answerLabel.textColor = [UIColor greenColor];
        [self fadeOut];
    } else {
        self.answerLabel.text = @"Wrong!";
        self.answerLabel.textColor = [UIColor redColor];
        [self fadeOut];
    };
    if (self.startGame.currentPlayer) {
        self.startGame.currentPlayer = NO;
        [self playGame];
    } else  {
        self.startGame.currentPlayer = YES;
        [self playGame];
    }
    
}

- (IBAction)zeroButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"0"];
}
- (IBAction)oneButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"1"];
}
- (IBAction)twoButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"2"];
}
- (IBAction)threeButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"3"];
}
- (IBAction)fourButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"4"];
}
- (IBAction)fiveButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"5"];
}
- (IBAction)sixButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"6"];
}
- (IBAction)sevenButton:(UIButton *)sender {
   [self.inputNumbers addObject:@"7"];
}
- (IBAction)eightButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"8"];
}
- (IBAction)nineButton:(UIButton *)sender {
    [self.inputNumbers addObject:@"9"];
}

- (void)fadeOut {
    self.answerLabel.alpha = 1.0;
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{self.answerLabel.alpha = 0.0;}
                     completion:^(BOOL finished){}];

}



@end
