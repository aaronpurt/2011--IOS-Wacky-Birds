//
//  MenuScene.h
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "cocos2d.h"
#import "LoopingMenu.h"
#import "InputController.h"
#import "GameScene.h"

@interface MenuScene : CCScene {
	//MenuLayer * menulayer;
}

@end

@interface MenuLayer : CCLayer
{
	CCSprite *menuSprite;
    CCSprite *_birdSprite;
    NSMutableArray * _MenuItemArray;
}

@property (nonatomic,retain) NSMutableArray * MenuItemArray;
@property (nonatomic,retain) CCSprite * birdSprite;

-(void)MenuItem1: (id)sender;
-(void)MenuItem2: (id)sender;
-(void)MenuItem3: (id)sender;
-(void)MenuItem4: (id)sender;
-(void)MenuItem5: (id)sender;

@end
