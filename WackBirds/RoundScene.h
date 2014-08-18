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

@interface RoundLayer : CCLayer {
    
    Bird * _bird;
    Background * _background;
    AppDelegate * _appdelegate;
    
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
    
    int currentIndexBird;
    NSMutableArray *_posBirdsPatArray;
    int _countIndexBirds;
    
    NSMutableArray * _negBirdsPatArray;
    int _negCurrentIndexBird;
    int _negCountIndexBirds;
    
    NSString * _hitAnim;
    NSString * _missAnim;
    int _timerCountIndex;
}

@property (nonatomic,retain) NSString *missAnim;
@property (nonatomic,retain) NSString *hitAnim;
@property (nonatomic,readwrite) bool isNegativeBird;

@property (nonatomic, assign) CGPoint *currentBirdLoc;
@property (nonatomic,retain) Background * background;
@property (nonatomic,retain) Bird * bird;
@property (nonatomic,retain) AppDelegate * appdelegate;

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

@property (nonatomic,readwrite) int currentIndexBird;
@property (nonatomic,retain) NSMutableArray * posBirdsPatArray;
@property (nonatomic,readwrite) int countIndexBirds;

@property (nonatomic,retain) NSMutableArray * negBirdsPatArray;
@property (nonatomic,readwrite) int negCurrentIndexBird;
@property (nonatomic,readwrite) int negCountIndexBirds;
@property (nonatomic,readwrite) int timerCountIndex;

-(void)resetGameLayer;
-(void)initWithLevel;
-(CGRect)myRect:(CCSprite *)sp;
-(void)pauseGame;
-(void)popBird:(CCSprite *) bird;
@end

@interface RoundScene : CCScene {
	RoundLayer * _gameLayer;
}
@end

