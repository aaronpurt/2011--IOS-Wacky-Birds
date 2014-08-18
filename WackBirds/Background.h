//
//  Background.h
//  Whack-em
//
//  Created by AARON on 6/15/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class GameLayer;

@interface Background : CCNode {
	
    NSMutableArray * currentBgArray;
	GameLayer * theGame;
    
    float _scale;
    int xB;
    int yB;
    int zB;
    int layerAngle;

}

@property (nonatomic,retain) NSMutableArray * currentBgArray;
@property (nonatomic,retain) GameLayer * theGame;

@property (nonatomic,readwrite) float scale;
@property (nonatomic,readwrite) int xB;
@property (nonatomic,readwrite) int yB;
@property (nonatomic,readwrite) int zB;
@property (nonatomic,readwrite) int layerAngle;

@end
