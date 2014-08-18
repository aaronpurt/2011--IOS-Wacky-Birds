//
//  GameOverScene.m
//  Whack-em
//
//  Created by AARON on 5/1/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "LevelOverScene.h"
#import "GameScene.h"
#import "AppDelegate.h"

@implementation LevelOverScene
@synthesize layer = _layer;

- (id)init {
    
	if ((self = [super init])) {
		self.layer = [LevelOverLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	[_layer release];
	_layer = nil;
	[super dealloc];
}

@end

@implementation LevelOverLayer
@synthesize title = _title, scoreLbl = _scoreLbl,highScore=_highScore;
@synthesize LevelOverNumber=_LevelOverNumber;;
@synthesize percentageLbl = _percentageLbl;
@synthesize menuBackground=_menuBackground,menuWinLose=_menuWinLose,newWin=_newWin;

//is used to convert to be able to be in good view on Ipad
- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        return point;
    }    
}

- (id) init {
    if ((self = [super init])) {
		
        //NSString *dlSheet = @"duckLevel.pvr.ccz";
        NSString *menuPlist = @"menu.plist";
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:menuPlist];
        //CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.jpg"];
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        self.menuBackground = [CCSprite spriteWithSpriteFrameName:@"MenuBackground.png"];
        //[vLayer1.texture setAliasTexParameters];
        self.menuBackground .scale = 2.0;
        self.menuBackground .position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
        [self addChild:self.menuBackground  z:2];
        self.LevelOverNumber = [CCSprite spriteWithSpriteFrameName:@"EggL2.png"]; 
        //Set the egg number at the end of each level for the win scene    
        self.LevelOverNumber.position = [self convertPoint:ccp(winSize.width/2,420)];
        [self addChild:self.LevelOverNumber z:13];  

        self.menuWinLose = [CCSprite spriteWithSpriteFrameName:@"ClearedLevel.png"];                        
        [self addChild:self.menuWinLose z:3];
        self.newWin = [CCSprite spriteWithSpriteFrameName:@"NewLevelScore.png"];                   
        [self addChild:self.newWin z:3];
                
        self.highScore = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
		self.highScore.color = ccc3(0,0,0);
		self.highScore.position = ccp(240, 210);        
		[self addChild:self.highScore z:3];
        
        self.scoreLbl = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
		self.scoreLbl.color = ccc3(0,0,0);
		self.scoreLbl.position = ccp(240, 170);        
		[self addChild:self.scoreLbl z:3];          
        
        //Replay button        
        CCMenuItem *replayMenuItem  = [CCMenuItemImage itemFromNormalImage:@"miniReplayEggBtn.png" 
                                                             selectedImage:@"miniReplayEggBtn.png" target: self selector: @selector(loadReplayLevel:)];
        replayMenuItem.scale = 2.0;        
        CCMenu * replayMenu = [CCMenu menuWithItems:replayMenuItem,nil];
        [self addChild:replayMenu z:11];
		[replayMenu setPosition:ccp(260,80)];
                
        CCMenuItem *readyMenuItem  = [CCMenuItemImage itemFromNormalImage:@"Play.png" 
                                                            selectedImage:@"Play.png" target: self selector: @selector(loadNextLevel:)];
        readyMenuItem.scale = 2.0;
        CCMenu * readyMenu = [CCMenu menuWithItems:readyMenuItem,nil];
        [self addChild:readyMenu z:11];
		[readyMenu setPosition:ccp(150,80)];
    
        CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"miniMenuEggBtn.png"
                                                          selectedImage:@"miniMenuEggBtn.png" 
                                                          disabledImage:@"miniMenuEggBtn.png" target:self   selector:@selector(goBackMainMenu:)];
        goback.scale = 2.0;
        CCMenu * dMenu = [CCMenu menuWithItems:goback, nil];
        [dMenu alignItemsVerticallyWithPadding:20];        
        dMenu.position =  ccp(50, 60);
        [self addChild:dMenu z:11];
  
    }
    return self;
}

//called on line 38 on reset
- (void)loadReplayLevel:(id)sender
{
    int level = [AppDelegate get].currentLevelIndex;    
   
    [AppDelegate get].currentLevelIndex = level;
    [AppDelegate get].levelScore = 0;
    [AppDelegate get].levelFullScore = 0;
    
    //changed to scene
    LoadingLevelScene * gs = [LoadingLevelScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
    
    //TODO: need to check the level first and run nextLevel before loadingLevel data. 
    //Need to pass in imageX for each levelloading  ** do that from AppDelegate. 
}

//called on line 38 on reset
- (void)loadNextLevel:(id)sender
{
    int level = [AppDelegate get].currentLevelIndex;
    
    level = level + 1;
    [AppDelegate get].currentLevelIndex = level;
    [AppDelegate get].levelScore = 0;
    [AppDelegate get].levelFullScore = 0;
    
    //changed to scene
    LoadingLevelScene * gs = [LoadingLevelScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}

-(void)goBackMainMenu:(id)sender
{
	MenuScene * gs = [MenuScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
	
}
- (void)dealloc {
    [super dealloc];
}

@end
