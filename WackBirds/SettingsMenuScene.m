//
//  SettingsMenuScene.m
//  Whack-em
//
//  Created by AARON on 6/4/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//
/*
#import "SettingsMenuScene.h"


@implementation SettingsMenuScene

- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[SettingsMenuLayer node]];
		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end

@implementation SettingsMenuLayer
- (id) init {
    if ((self = [super init])) {
		
		//isTouchEnabled = YES;
		
		CCSprite * background = [CCSprite spriteWithFile:@"options_background.png"];
		[background setPosition:ccp(160,240)];
		[self addChild:background];
        
        
        
		//CCLabelBMFont * difficultyLabel = [CCLabelBMFont labelWithString:@"Difficulty" fntFile:@"hud_font.fnt"];
		//[difficultyLabel setColor:ccRED];
		//[self addChild:difficultyLabel];
		//[difficultyLabel setPosition:ccp(80,350)];
		
		CCLabelBMFont * musicLabel = [CCLabelBMFont labelWithString:@"MUSIC" fntFile:@"hud_font.fnt"];
		[musicLabel setColor:ccRED];
		[self addChild:musicLabel];
		[musicLabel setPosition:ccp(80,250)];
		
		CCLabelBMFont * soundLabel = [CCLabelBMFont labelWithString:@"SOUND" fntFile:@"hud_font.fnt"];
		[soundLabel setColor:ccRED];
		[self addChild:soundLabel];
		[soundLabel setPosition:ccp(80,150)];
		
		
		/*
		CCMenuItemImage * easyBtn = [CCMenuItemImage itemFromNormalImage:@"easy.png"
														   selectedImage:@"easy_dwn.png"];
		
		CCMenuItemImage * normalBtn = [CCMenuItemImage itemFromNormalImage:@"normal.png"
															 selectedImage:@"normal_dwn.png" ];
		
		CCMenuItemToggle * difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeDifficulty:) items:easyBtn,normalBtn,nil];
		*/
         
         /*
		CCMenuItemImage * unchecked1 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
                                                              selectedImage:@"options_check_d.png"];
		
		CCMenuItemImage * checked1 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
                                                            selectedImage:@"options_check.png" ];
		
		CCMenuItemToggle * music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic:) items:unchecked1,checked1,nil];
		
		CCMenuItemImage * unchecked2 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
                                                              selectedImage:@"options_check_d.png"];
		
		CCMenuItemImage * checked2 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
                                                            selectedImage:@"options_check.png" ];
		
		CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:unchecked2,checked2,nil];
		
		
		CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"options_goback.png"
                                                          selectedImage:@"options_goback.png" 
                                                          disabledImage:@"options_goback.png"
                                                                 target:self
                                                               selector:@selector(goBack:)];
		
		//[difficulty setPosition:ccp(220,350)];
		[music setPosition:ccp(220,260)];
		[sound setPosition:ccp(220,160)];
		[goback setPosition:ccp(160,30)];
		
		CCMenu * menu = [CCMenu menuWithItems:music,sound,goback,nil];
		[self addChild:menu];
		[menu setPosition:ccp(0,0)];
		
		NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"sound"] == NO)
			sound.selectedIndex = 1;
		if([usrDef boolForKey:@"music"] == NO)
			music.selectedIndex = 1;
        /*
		if([usrDef integerForKey:@"difficulty"] == 0)
			difficulty.selectedIndex =0;
		else if([usrDef integerForKey:@"difficulty"] == 1)
			difficulty.selectedIndex =1;
		*//*
    }
    return self;
}

-(void)changeDifficulty:(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setInteger:1 forKey:@"difficulty"];
	if(sender.selectedIndex ==0)
		[usrDef setInteger:0 forKey:@"difficulty"];
}

-(void)changeSound:(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setBool:NO forKey:@"sound"];
	if(sender.selectedIndex ==0)
		[usrDef setBool:YES forKey:@"sound"];
}

-(void)changeMusic:(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setBool:NO forKey:@"music"];
	if(sender.selectedIndex ==0)
		[usrDef setBool:YES forKey:@"music"];
}


-(void)goBack:(id)sender
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