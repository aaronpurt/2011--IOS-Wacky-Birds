//
//  HUDLayer.h
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface HUDLayer : CCLayer {
	 
	CCLabelBMFont * level;
	CCLabelBMFont * score;
	CCLabelBMFont * bombs;
	NSMutableArray * lives;
    
    CCLabelBMFont * timer;
    NSMutableArray * bonuses;
}

@property (nonatomic,retain) NSMutableArray * bonuses;

@property (nonatomic,retain) CCLabelBMFont * timer;
@property (nonatomic,retain) CCLabelBMFont * level;
@property (nonatomic,retain) CCLabelBMFont * score;
@property (nonatomic,retain) CCLabelBMFont * bombs;

@property (nonatomic,retain) NSMutableArray * lives;

-(void)LevelOver:(NSString *)score currentLevel:(NSString*)level;
-(void)UpdateLivesCount;

@end
