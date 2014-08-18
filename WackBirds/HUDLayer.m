//
//  HUDLayer.m
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "HUDLayer.h"

@implementation HUDLayer;

@synthesize score,level,timer,bombs,lives,bonuses;

//is used to convert to be able to be in good view on Ipad
- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        //return ccp(point.x*2,point.y*2); 
        return point;
    }    
}

-(int)GetLives
{
    
    int level = [AppDelegate get].currentLevelIndex;
    
    int lives = 0;
    
    if(level >0 && level<=10)
    {
        lives=5;
    
    }
    else
        if(level>=11 && level <=20)
        {
            lives=4;
        }
    else
    {
        lives=3;
    }
    
    return lives;
}

- (id) init {
    if ((self = [super init])) {
		
		self.isTouchEnabled=YES;
        
        NSString *menuPlist = @"menu.plist";
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:menuPlist];
                 
        int localLives = [self GetLives];
              
		lives = [[NSMutableArray arrayWithCapacity:localLives]retain];
      
        
		for(int i=0;i<localLives;i++)
		{
			CCSprite * life = [CCSprite spriteWithFile:@"EggLives.png"];
			[life setPosition:ccp(18+ 28*i,450)];
			[self addChild:life];
			[lives addObject:life];
		}

        bonuses = [[NSMutableArray arrayWithCapacity:1]retain];
        
		for(int i=1;i<=1;i++)
		{
			CCSprite * bonus = [CCSprite spriteWithFile:@"Bonus.png"];
			[bonus setPosition:ccp(280,400)];
            bonus.scale = 2.0;
			[self addChild:bonus];
			[bonuses addObject:bonus];
            [bonus setVisible:NO];
		}
                
        CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"miniMenuBtn.png" selectedImage:@"miniMenuBtn.png" target: self selector: @selector(GoToPauseMenu:)];
        menuItem.scale = 2.0;
        CCMenu * menu = [CCMenu menuWithItems:menuItem,nil];
		//[menu alignItemsVerticallyWithPadding:50];
		[self addChild:menu z:100];        
		[menu setPosition:ccp(180,455)];
        
        timer = [CCLabelBMFont labelWithString:@"Timer 0" fntFile:@"wackyBirdFntData.fnt"];
		[timer setAnchorPoint:ccp(1,0.5)];
		[timer setPosition:ccp(80,465)];
		[timer setColor:ccWHITE];
        //[timer setScale:2];
		[self addChild:timer];
		
        score = [CCLabelBMFont labelWithString:@"Score 0" fntFile:@"wackyBirdFntData.fnt"];
		[score setAnchorPoint:ccp(1,0.5)];
		[score setPosition:ccp(310,445)];
		[score setColor:ccWHITE];
        //[score setScale:3];        
		[self addChild:score];

        level = [CCLabelBMFont labelWithString:@"Level 0" fntFile:@"wackyBirdFntData.fnt"];
		[level setAnchorPoint:ccp(1,0.5)];
		[level setPosition:ccp(310,465)];
		[level setColor:ccWHITE];
        
        //[level setScale:3];
		[self addChild:level];
         
        //NSLog(@"Init HUD Layer");
				
    }
    return self;
}
-(void)GoToPauseMenu:(id)sender
{
    ccColor4B c = {100,100,0,100};
	PauseLayer * p = [[[PauseLayer alloc]initWithColor:c]autorelease];
	[self.parent addChild:p z:99];
}

- (void)onExit
{
	if(![AppDelegate get].paused)
	{           
		[AppDelegate get].paused = YES;
        [self stopAllActions];
        [self unscheduleAllSelectors];        
		[super onExit];
	}
}

-(void)GoToNextLevel:(NSString *)level
{
    GameScene * gs = [[[GameScene alloc]initWithLevel:level]autorelease];
	[[CCDirector sharedDirector]replaceScene:gs];
    //call back to AppHolding to get next level. 
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	GameLayer * gl = (GameLayer *)[self.parent getChildByTag:KGameLayer];
	
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		if(location.y>440)
		{
			[gl pauseGame];
        }
	}
}

- (void) dealloc
{
	[super dealloc];
	[lives release];
    [timer release];
}

@end