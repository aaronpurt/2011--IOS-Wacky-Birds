//
//  GameOverScene.h
//  Whack-em
//
//  Created by AARON on 5/1/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "cocos2d.h"

@interface LevelOverLayer : CCLayer {
	
    NSString *_title;  
    CCLabelTTF * _highScore;
    CCLabelTTF *_scoreLbl;
    CCLabelTTF *_percentageLbl;
    CCSprite * _menuBackground;
    CCSprite * _menuWinLose;
    CCSprite * _newWin;
    CCSprite * _LevelOverNumber;
}

@property (nonatomic, retain) CCSprite * LevelOverNumber;
@property (nonatomic, retain) CCSprite * newWin;
@property (nonatomic, retain) CCSprite * menuWinLose;
@property (nonatomic, retain) CCSprite * menuBackground;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) CCLabelTTF *scoreLbl;
@property (nonatomic, retain) CCLabelTTF * percentageLbl;
@property (nonatomic, retain) CCLabelTTF *highScore;
@end

@interface LevelOverScene : CCScene {
	LevelOverLayer *_layer;
}

@property (nonatomic, retain) LevelOverLayer *layer;
@end
