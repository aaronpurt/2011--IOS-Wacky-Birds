//
//  MainMenuScene.m
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//
/*
#import "MainMenuScene.h"

#import "OpenFeint/OFControllerLoader.h"
#import "OpenFeint/OFViewHelper.h"
#import "OpenFeint/OpenFeint.h"
#import "OpenFeint/OpenFeint+Dashboard.h"
#import "OpenFeint/OpenFeint+UserOptions.h"

@implementation MainMenuScene

//is used to convert to be able to be in good view on Ipad
- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        //return ccp(point.x*2,point.y*2); 
        return point;
    }    
}


- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[MainMenuLayer node]];
		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end

@implementation MainMenuLayer
- (id) init {
    if ((self = [super init])) {
		
		//isTouchEnabled = YES;
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0)];//layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:colorLayer z:0];
        
        CCLabelTTF *timer = [CCLabelTTF labelWithString:@"Wacky Birds" fontName:@"Arial" fontSize:32];
		//[timer setAnchorPoint:ccp(1,0)];
		[timer setPosition:ccp(160,400)];
		[timer setColor:ccGRAY];
        //[timer setScale:2];
		[self addChild:timer];
        
        //Menu Background Image. Use later. 
		CCSprite * background = [CCSprite spriteWithFile:@"OFLogoBottomCornerLeft512.png"];
		[background setPosition:ccp(120,120)];
		[self addChild:background z:99];
		
        /*
        //Go back button. 
        CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"OFLogoBottomCornerLeft512.png"
                                                          selectedImage:@"OFLogoBottomCornerLeft512.png" 
                                                          disabledImage:@"OFLogoBottomCornerLeft512.png"
                                                                 target:self
                                                               selector:@selector(loadOFleaderBoard:)];
        CCMenu * dMenu = [CCMenu menuWithItems:goback, nil];
        [dMenu alignItemsVerticallyWithPadding:20];
        dMenu.position =  ccp(120, 120);
        [self addChild:dMenu z:100];
        */
        /*
		CCLabelBMFont * newgameLabel = [CCLabelBMFont labelWithString:@"NEW GAME" fntFile:@"hud_font.fnt"];
		CCLabelBMFont * settingsLabel = [CCLabelBMFont labelWithString:@"OPTIONS" fntFile:@"hud_font.fnt"];
		CCLabelBMFont * aboutLabel = [CCLabelBMFont labelWithString:@"ABOUT" fntFile:@"hud_font.fnt"];
		
        //[newgameLabel setScale:2];
		[newgameLabel setColor:ccRED];
		[settingsLabel setColor:ccRED];
		[aboutLabel setColor:ccRED];

		CCMenuItemLabel * newgame = [CCMenuItemLabel itemWithLabel:newgameLabel target:self selector:@selector(newGame:)];
		CCMenuItemLabel * options = [CCMenuItemLabel itemWithLabel:settingsLabel target:self selector:@selector(settings:)];
		CCMenuItemLabel * about = [CCMenuItemLabel itemWithLabel:aboutLabel target:self selector:@selector(about:)];

		CCMenu * menu = [CCMenu menuWithItems:newgame,options,about,nil];
		[menu alignItemsVerticallyWithPadding:50];
		[self addChild:menu];
		[menu setPosition:ccp(160,240)];
		
		[newgame runAction:[CCSequence actions:
							[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-24,24)]  rate:2],
							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:3.3],[CCScaleTo actionWithDuration:1 scale:3],nil] times:9000],
							nil]];
		[options runAction:[CCSequence actions:
							[CCDelayTime actionWithDuration:0.5],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-24,24)]  rate:2],
							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:3.3],[CCScaleTo actionWithDuration:1 scale:3],nil] times:9000],
							nil]];
		[about runAction:[CCSequence actions:
                          [CCDelayTime actionWithDuration:1],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-24,24)]  rate:2],
                          [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:3.3],[CCScaleTo actionWithDuration:1 scale:3],nil] times:9000],
                          nil]];
		
		//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"menu_music.mp3" loop:YES];
		
    }
    return self;
}

//load OF leader board screen
-(void)loadOFleaderBoard
{
    
}

-(void)newGame:(id)sender
{
	//[[AerialGunAppDelegate get].soundEngine playSound:SND_ID_CLICK sourceGroupId:CGROUP_ALL pitch:1 pan:0.0f gain:1.0f loop:NO];
    //load the Looping Levels Menu.    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate loadLoadingScene];

}
/*
-(void)showDifficultySelection
{
    //CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    //[self addChild:colorLayer z:0];
    //Menu Background Image. Use later. 
    CCSprite * background = [CCSprite spriteWithFile:@"menuLevels_background.png"];
    [background setPosition:ccp(160,240)];
    [background setScale:2];
    [self addChild:background z:99];
    
	//ccColor4B c = {0,0,0,180};
	//CCLayerColor * difficulty = [CCLayerColor layerWithColor:c];
	//[self addChild:difficulty z:200];
	CCMenuItemImage * level1Btn = [CCMenuItemImage itemFromNormalImage:@"onionLevel.png"
													   selectedImage:@"onionLevel.png" 
													   disabledImage:@"onionLevelLocked.png"
															  target:self
															selector:@selector(selectMode:)];
    
	CCMenuItemImage * level2Btn = [CCMenuItemImage itemFromNormalImage:@"onionLevel2.png"
                                                         selectedImage:@"onionLevel2.png" 
                                                         disabledImage:@"onionLevelLocked.png"
                                                                target:self
                                                              selector:@selector(selectMode:)];
	
	CCMenuItemImage * level3Btn = [CCMenuItemImage itemFromNormalImage:@"onionLevel3.png"
                                                          selectedImage:@"onionLevel3.png" 
                                                          disabledImage:@"onionLevelLocked.png"
                                                                 target:self
                                                               selector:@selector(selectMode:)];
	
    CCMenuItemImage * level4Btn = [CCMenuItemImage itemFromNormalImage:@"onionLevel4.png"
                                                          selectedImage:@"onionLevel4.png" 
                                                          disabledImage:@"onionLevelLocked.png"
                                                                 target:self
                                                               selector:@selector(selectMode:)];
    
    CCMenuItemImage * level5Btn = [CCMenuItemImage itemFromNormalImage:@"onionLevel5.png"
                                                          selectedImage:@"onionLevel5.png" 
                                                          disabledImage:@"onionLevelLocked.png"
                                                                 target:self
                                                               selector:@selector(selectMode:)];
    
    CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"options_goback.png"
                                                      selectedImage:@"options_goback.png" 
                                                      disabledImage:@"options_goback.png"
                                                             target:self
                                                           selector:@selector(goBackMainMenu:)];
	//[extremeBtn setIsEnabled:NO];
	//[goback setScale:2];
    //[level1Btn setScale:2];
	[level1Btn setTag:1];
	[level2Btn setTag:2];
	[level3Btn setTag:3];    
    [level4Btn setTag:4];
	[level5Btn setTag:5];
         
	CCMenu * dMenu = [CCMenu menuWithItems:level1Btn,level2Btn,level3Btn,level4Btn, level5Btn,goback, nil];
	[dMenu alignItemsVerticallyWithPadding:20];
    dMenu.position =  ccp(160, 240);
	[self addChild:dMenu z:100];
}*/

/*
-(void)selectMode:(CCMenuItemImage *)btn
{
	//[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    int level = btn.tag;
    [AppDelegate get].currentLevelIndex = level;
    
    // call AppDelegate to do this method. 
    
    //using /////////
    //LoadingLayer * gs = [LoadingLayer node];    
	//[[CCDirector sharedDirector]replaceScene:gs];
  
    //not using replace with loadinglevel.
	//int level = btn.tag;
	//GameScene * gs = [[GameScene alloc]initWithLevel:level];
	//[[CCDirector sharedDirector]replaceScene:gs];
	
}*/
/*
-(void)settings:(id)sender
{
	SettingsMenuScene * gs = [SettingsMenuScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}

-(void)about:(id)sender
{
	//[self loadOFleaderBoard];
}

-(void)goBackMainMenu:(id)sender
{
	MainMenuScene * gs = [MainMenuScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}
-(void)dealloc
{
	[super dealloc];
}
@end
*/

