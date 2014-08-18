


//
//  GameOverScene.h
//  Wacky Birds
//
//  Created by Aaron Clandening on 5/14/10.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface GameOverLayer : CCLayer {
	
    CCLabelTTF *_title;  
    
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
@property (nonatomic, retain) CCLabelTTF *title;
@property (nonatomic, retain) CCLabelTTF *scoreLbl;
@property (nonatomic, retain) CCLabelTTF * percentageLbl;
@property (nonatomic, retain) CCLabelTTF *highScore;


@end


@interface GameOverScene : CCScene {
    GameOverLayer *_layer;
}
@property (nonatomic, retain) GameOverLayer *layer;

@end
