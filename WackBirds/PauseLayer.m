//
//  PauseLayer.m
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "PauseLayer.h"

@implementation PauseLayer


- (id) initWithColor:(ccColor4B)color{
    if ((self = [super initWithColor:color])) {
		
		self.isTouchEnabled=YES;
        [self onExit];
              
        CCMenuItem *playItem = [CCMenuItemImage itemFromNormalImage:@"miniPlayBtn.png" selectedImage:@"miniPlayBtn.png" target: self selector: @selector(returnToGame:)];
        playItem.scale = 2.0;
        CCMenu * menuPlay = [CCMenu menuWithItems:playItem,nil];
		//[menu alignItemsVerticallyWithPadding:50];
		[self addChild:menuPlay z:100];
		[menuPlay setPosition:ccp(160,300)];        
        
        CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"miniMenuEggBtn.png" selectedImage:@"miniMenuEggBtn.png" target: self selector: @selector(goBackMainMenu:)];
        menuItem.scale = 2.0;
        CCMenu * menu = [CCMenu menuWithItems:menuItem,nil];
		[menu alignItemsVerticallyWithPadding:50];
		[self addChild:menu z:100];
		[menu setPosition:ccp(160,200)];

    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)returnToGame:(id)sender
{
    GameLayer * gl = (GameLayer *)[self.parent getChildByTag:KGameLayer];
    [gl resume];
    [self.parent removeChild:self cleanup:YES];
}

-(void)goBackMainMenu:(id)sender
{
	MenuScene * gs = [MenuScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}

- (void) dealloc
{
	[super dealloc];
}

@end