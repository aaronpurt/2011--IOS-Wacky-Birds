//
//  GameScene.h
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "HUDLayer.h"
#import "Bird.h"
#import "Background.h"
#import "PauseLayer.h"
#import "GameScene.h"
#import "LevelOverScene.h"

#define KGameLayer 30
#define KHudLayer 32

@class Bird;
@class Background;
@class AppDelegate;
@class HUDLayer;

@interface GameLayer : CCLayer {
    
   
    Bird * _bird;
    Background * _background;
    AppDelegate * _appdelegate;
    
    HUDLayer * _hudLayer;
    
    NSMutableArray *_currentBirds;
  
    CGPoint *_currentBirdLoc;
    
    int _score;
    int _currentLevel;    
    int _timer;
    
    int totalSpawns;
    BOOL isGameOver;
    BOOL isLevelOver;    
        
    float _countKillBirdTrys;
    float _countBirdKills;
   
    CCParticleSystemPoint * smoke;
    
     bool _isNegativeBird;
              
    //test 
    //gets the patterns for positive bird and negative bird. 
    int _currentIndexBird;
    NSMutableArray *_posBirdsPatArray;
    int _countIndexBirds;
    
     NSMutableArray * _negBirdsPatArray;
     int _negCurrentIndexBird;
     int _negCountIndexBirds;
    
    NSString * _hitPosAnim;
    NSString * _missPosAnim;
    
    CCSprite * roundImage;
    int _roundImageDelayCount;
    
    int _totalLives;
    
    //new variables
    int _currentNegativeIndexLocation;
    int _currentPositiveIndexLocation;
       
    int _countNegativeArray;
    int _countPositiveArray;
 
    //counts for bonus
    int _bonusCount;
    bool _isBonus;
 
    
    //Audio Sound Variables
    NSString * _hitPosSound;
    NSString * _hitNegSound;
    
    NSString * _missPosSound;
    NSString * _missNegSound;
    
    NSString * _bonusSound;
    NSString * _backgroundSound;
    
}

@property (nonatomic,retain) NSString * backgroundSound;

@property (nonatomic,retain) NSString *missPosAnim;
@property (nonatomic,retain) NSString *hitPosAnim;

@property (nonatomic,readwrite) int bonusCount;
@property (nonatomic,readwrite) bool isBonus;

@property (nonatomic,readwrite) bool isNegativeBird;


@property (nonatomic, assign) CGPoint *currentBirdLoc;
@property (nonatomic,retain) Background * background;
@property (nonatomic,retain) Bird * bird;
@property (nonatomic,retain) AppDelegate * appdelegate;
@property (nonatomic,retain) HUDLayer * hudLayer;

@property (nonatomic,retain) NSMutableArray * currentBirds;
@property (nonatomic,retain) NSMutableArray * currentBgs;
@property (assign,readwrite) int score;
@property (assign,readwrite) int currentLevel;
@property (assign,readwrite) int totalSpawns;
@property (assign,readwrite) int timer;

@property (nonatomic,readwrite) bool isLevelOver;
@property (nonatomic,readwrite) bool isGameOver;

@property (nonatomic,readwrite) float countKillBirdTrys;
@property (nonatomic,readwrite) float countBirdKills;


//gets the patterns for positive bird and negative bird. 
@property (nonatomic,readwrite) int currentIndexBird;
@property (nonatomic,retain) NSMutableArray * posBirdsPatArray;
@property (nonatomic,readwrite) int countIndexBirds;

@property (nonatomic,retain) NSMutableArray * negBirdsPatArray;
@property (nonatomic,readwrite) int negCurrentIndexBird;
@property (nonatomic,readwrite) int negCountIndexBirds;
//@property (nonatomic,readwrite) int timerCountIndex;

@property (nonatomic,retain) CCSprite * roundImage;
@property (nonatomic,readwrite) int roundImageDelayCount;
@property (assign,readwrite) int totalLives;

-(void)resetRound;
-(void)resetGameLayer;
-(void)initWithLevel;
-(CGRect)myRect:(CCSprite *)sp;
-(void)pauseGame;
-(void)popBird:(CCSprite *) bird;
-(void)initRoundAnimationSpeed;
-(int)GetIntervalBirdSpeed:(int)level;

@end

@interface GameScene : CCScene {
	GameLayer * _gameLayer;
}

@end

