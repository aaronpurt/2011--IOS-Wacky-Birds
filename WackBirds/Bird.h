//
//  Bird.h
//  Whack-em
//
//  Created by AARON on 6/7/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class GameLayer;
@class Level;
@class AppDelegate;

@interface Bird : CCNode {
    
	CCSprite * _birdSprite;
    CCSprite * _negBirdSprite;    
	GameLayer * _theGame;
    
    //goes to the management class
    NSMutableArray *_currentBirds;
        
    float _scale;
    float _birdBeginScale;   
    int _xB;
    int _yB;
    int _zB; 
    int  _birdLocation;
    
    //angle birds comes out of hole. 
    int _birdAngle;      
    //NSString *_tongueAnim;   
    
    int _positiveCurrentBirdIndex;   
    int _negativeCurrentBirdIndex;
    bool _isNegativeBird;
    
    //set the values for bird animation    
    float _rotateAnim;
    float _moveAnim;
    float _scaleAnim;   
    float _delayAnim;
    
}
+(Bird *) getBird;
@property (nonatomic,retain) CCSprite * birdSprite;
@property (nonatomic,retain) CCSprite * negBirdSprite;
@property (nonatomic,retain) GameLayer * theGame;

@property (nonatomic,assign) int  birdLocation;
@property (nonatomic,readwrite) float scale;
@property (nonatomic,readwrite) float birdBeginScale;
@property (nonatomic,readwrite) int xB;
@property (nonatomic,readwrite) int yB;
@property (nonatomic,readwrite) int zB;
@property (nonatomic,readwrite) int birdAngle;
@property (nonatomic,retain) NSString *tongueAnim;

@property (nonatomic,readwrite) int birdIndexCount;
@property (nonatomic,readwrite) int negBirdIndexCount;
@property (nonatomic,readwrite) bool isNegativeBird;

@property (nonatomic,readwrite) float scaleAnim;
@property (nonatomic,readwrite) float rotateAnim;
@property (nonatomic,readwrite) float moveAnim;
@property (nonatomic,readwrite) float delayAnim;

-(void)initBirds;
-(void)update;
-(void)birdCoordinates; 

@end
