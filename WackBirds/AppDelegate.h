//
//  AppDelegate.h
//  wackybirds
//
//  Created by AARON on 7/9/11.
//  Copyright Wacky Birds 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "GameScene.h"
#import "LoadSplashScene.h"
#import "LevelOverScene.h"
#import "LoadingLevel.h"
#import "GameOverScene.h"
#import "loadingRound.h"
#import "MenuScene.h"

@class RootViewController;

@class GameScene;
@class LoadingLevelScene;
@class LoadingRound;
//test
@class LevelOverScene;
@class GameOverScene;

//test
@class SampleOFDelegate;
@class SampleOFNotificationDelegate;
@class SampleOFChallengeDelegate;
@class SampleOFBragDelegate;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    int _levelScore;
    int percentageHit;
    
    float _allScale;
    
    GameScene *_gameScene;
    
    LevelOverScene *_levelOverScene;
    LoadingLevelScene *_loadingLevelScene;
    LoadingRound *_loadingRound;
    GameOverScene *_gameOverScene;
    
    NSMutableArray *_levels;
    int _currentLevelIndex;
    int _levelCount;
    
    //lets do this.. test... 
    int  _timerLevelCount;
    int _levelFullScore;
    
    SampleOFDelegate *ofDelegate;
	SampleOFNotificationDelegate *ofNotificationDelegate;
	SampleOFChallengeDelegate *ofChallengeDelegate;
	SampleOFBragDelegate *ofBragDelegate;
    
    //End of level variables.. 
    int _highLevelScore;
    
    bool _levelFailed;

}
-(void)loadLevelNumberEgg;//private 
+(AppDelegate *) get;
@property (nonatomic, retain) UIWindow *window;
@property(readwrite,nonatomic) bool paused;
@property(readwrite,nonatomic) int levelScore;
@property(readwrite,nonatomic) int percentageHit;
@property(readwrite,nonatomic) float allScale;

@property(readwrite,nonatomic) int highLevelScore;
@property(readwrite,nonatomic) bool levelFailed;

@property (nonatomic, assign) int currentLevelIndex;
@property (nonatomic, retain) NSMutableArray *levels;

@property (nonatomic, assign) int levelCount;
@property (nonatomic, assign) int timerLevelCount;
@property (nonatomic, assign) int levelFullScore;

@property (nonatomic, retain) GameScene *gameScene;

@property (nonatomic, retain) LevelOverScene *levelOverScene;
@property (nonatomic, retain) GameOverScene *gameOverScene;
@property (nonatomic, retain) LoadingRound *loadingRound;

- (GameScene *)currentLevel;

-(void)nextRound;
- (void)nextLevel:(int)level;
- (void)levelComplete;
-(void)loadWinScene;
-(void)InitOFdata;
-(void)loadLoadingScene;
-(void)restartLevel:(int)level;
+(GameScene *)initWithLevel:(int)level timerCount:(int)timerIndex;
-(void)increaseTimerLevelCount;
@end
