//
//  GameConfig.h
//  wackybirds
//
//  Created by AARON on 7/9/11.
//  Copyright Wacky Birds 2011. All rights reserved.
//

#import "GameOverScene.h"


@implementation GameOverScene

- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[GameOverLayer node]];
		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@synthesize layer=_layer;
@end

@implementation GameOverLayer


@synthesize title = _title, scoreLbl = _scoreLbl,highScore=_highScore;
@synthesize LevelOverNumber=_LevelOverNumber;
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
        self.menuBackground .scale = 2.0;
        self.menuBackground .position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
        [self addChild:self.menuBackground  z:2];
        
        
        CCSprite * credits = [CCSprite spriteWithFile:@"Credits.png"];
        credits.scale = 2.0;
        credits.position = [self convertPoint:ccp(winSize.width/2,200)];
        [self addChild:credits z:3];
        
        /*
        self.menuWinLose = [CCSprite spriteWithSpriteFrameName:@"ClearedLevel.png"];                        
        [self addChild:self.menuWinLose z:3];
        
        self.newWin = [CCSprite spriteWithSpriteFrameName:@"NewLevelScore.png"];                   
        [self addChild:self.newWin z:3];
        */
        
        /*
         self.title = [CCLabelTTF labelWithString:@"Congratulations!!!" fontName:@"Arial" fontSize:32];
         self.title.color = ccc3(0,0,0);
         self.title.position = ccp(160, 420);        
         [self addChild:self.title z:3];
         
        
        //Need to get the high score of the game. 
        self.highScore = [CCLabelTTF labelWithString:@"Game High Score: 345 " fontName:@"Arial" fontSize:24];
		self.highScore.color = ccc3(0,0,0);
		self.highScore.position = ccp(160, 350);        
		[self addChild:self.highScore z:3];
        
        */
        /////////////////////////////////////////////////
        // Replay Button (Replay same level)
        ////////////////////////////////////////////////
        /*
        CCMenuItem *replayMenuItem  = [CCMenuItemImage itemFromNormalImage:@"miniReplayEggBtn.png" selectedImage:@"miniReplayEggBtn.png" target: self selector: @selector(loadReplayLevel:)];
        replayMenuItem.scale = 2.0;        
        CCMenu * replayMenu = [CCMenu menuWithItems:replayMenuItem,nil];
        [self addChild:replayMenu z:11];
		[replayMenu setPosition:ccp(280,80)];        
        
        /////////////////////////////////////////////////
        // Play Button. (Continue to next level)
        ////////////////////////////////////////////////
        CCMenuItem *readyMenuItem  = [CCMenuItemImage itemFromNormalImage:@"Play.png" selectedImage:@"Play.png" target: self selector: @selector(loadNextLevel:)];
        readyMenuItem.scale = 2.0;        
        CCMenu * readyMenu = [CCMenu menuWithItems:readyMenuItem,nil];
        [self addChild:readyMenu z:11];
		[readyMenu setPosition:ccp(160,80)];
        */
        /////////////////////////////////////////////////
        // Go Back to Main Menu
        ////////////////////////////////////////////////     
        CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"miniMenuEggBtn.png" selectedImage:@"miniMenuEggBtn.png" target:self   selector:@selector(goBackMainMenu:)];
        goback.scale = 2.0;
        CCMenu * dMenu = [CCMenu menuWithItems:goback, nil];
        [dMenu alignItemsVerticallyWithPadding:20];        
        dMenu.position =  ccp(60, 80);
        [self addChild:dMenu z:11];
        ////////////////////

		    }
    return self;
}

-(void)goBackMainMenu:(id)sender
{
	MenuScene * gs = [MenuScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
	
}

-(void)dealloc
{
	[super dealloc];
}
@end