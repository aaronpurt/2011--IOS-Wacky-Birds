//
//  LoadingLevel.m
//  Whack-em
//
//  Created by AARON on 6/11/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "LoadingLevel.h"
#import "GameScene.h"

@implementation LoadingLevelScene
- (id) init {
    self = [super init];
    if (self != nil) {
        [self addChild:[LoadingLayer node]];
    }
    return self;
}

-(void)dealloc{
	[super dealloc];
}

@end

@implementation LoadingLayer

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
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        int level = [AppDelegate get].currentLevelIndex;

        CCSprite *menuBg = [CCSprite spriteWithSpriteFrameName:@"MenuBackground.png"];
        //[vLayer1.texture setAliasTexParameters];
        menuBg.scale = 2.0;
        menuBg.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
        [self addChild:menuBg z:9];

        CCSprite *birdInfo ;   

        switch (level) {
            case 1:
                
                birdInfo = [CCSprite spriteWithSpriteFrameName:@"vInfo.png"];
                //[vLayer1.texture setAliasTexParameters];
                birdInfo.scale = 2.0;
                birdInfo.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
                [self addChild:birdInfo z:10];
                break;
            case 2:
                
                birdInfo = [CCSprite spriteWithSpriteFrameName:@"oInfo.png"];
                //[vLayer1.texture setAliasTexParameters];
                birdInfo.scale = 2.0;
                birdInfo.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
                [self addChild:birdInfo z:10];
                break;
            case 3:
                
                birdInfo = [CCSprite spriteWithSpriteFrameName:@"rInfo.png"];
                //[vLayer1.texture setAliasTexParameters];
                birdInfo.scale = 2.0;
                birdInfo.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
                [self addChild:birdInfo z:10];
                break;
            case 4:
                
                birdInfo = [CCSprite spriteWithSpriteFrameName:@"pInfo.png"];
                //[vLayer1.texture setAliasTexParameters];
                birdInfo.scale = 2.0;
                birdInfo.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
                [self addChild:birdInfo z:10];
                break;
            case 5:
                
                birdInfo = [CCSprite spriteWithSpriteFrameName:@"dInfo.png"];
                //[vLayer1.texture setAliasTexParameters];
                birdInfo.scale = 2.0;
                birdInfo.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];                
                [self addChild:birdInfo z:10];
                break;
                
            default:
                break;
        }

        //Ready button for level
        //CCSprite *ready = [CCSprite spriteWithSpriteFrameName:@"ready.png"];
        CCMenuItem *readyMenuItem  = [CCMenuItemImage itemFromNormalImage:@"Play.png" selectedImage:@"Play.png" target: self selector: @selector(loadLevel:)];
        readyMenuItem.scale = 2.0;

        CCMenu * readyMenu = [CCMenu menuWithItems:readyMenuItem,nil];
        [self addChild:readyMenu z:11];
		[readyMenu setPosition:ccp(160,290)];
        ///////////////////////

       //Go back to main menu        
        CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"miniMenuEggBtn.png"
                                                          selectedImage:@"miniMenuEggBtn.png" 
                                                          disabledImage:@"miniMenuEggBtn.png" target:self   selector:@selector(goBackMainMenu:)];
        goback.scale = 2.0;
        CCMenu * dMenu = [CCMenu menuWithItems:goback, nil];
        [dMenu alignItemsVerticallyWithPadding:20];
        
        dMenu.position =  ccp(40, 80);
        [self addChild:dMenu z:11];
        ////////////////////
        
    }
    return self;
}

-(void)loadLevel:(id)sender{
    int level = [AppDelegate get].currentLevelIndex;
    int score = [AppDelegate get].levelScore;
    //int level = btn.tag;
    GameScene * gs = [[GameScene alloc]initWithLevel:level levelScore:score];
    [[CCDirector sharedDirector]replaceScene:gs];
}

-(void)goBackMainMenu:(id)sender{
	MenuScene * gs = [MenuScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}
-(void)fadeAndShow:(NSMutableArray *)images{
	if([images count]<=1)
	{
		[images release];
        int level = [AppDelegate get].currentLevelIndex;
        int score = [AppDelegate get].levelScore;
        //int level = btn.tag;
        GameScene * gs = [[GameScene alloc]initWithLevel:level levelScore:score];
        [[CCDirector sharedDirector]replaceScene:gs];
        
	}else {
		
		CCSprite * actual = (CCSprite *)[images objectAtIndex:0];
		[images removeObjectAtIndex:0];
		CCSprite * next = (CCSprite *)[images objectAtIndex:0];
		[actual runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],[CCFadeOut actionWithDuration:0.1],[CCCallFuncN actionWithTarget:self selector:@selector(remove:)],nil]];
		[next runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],[CCFadeIn actionWithDuration:0.1],[CCDelayTime actionWithDuration:0.2],[CCCallFuncND actionWithTarget:self selector:@selector(cFadeAndShow: data:) data:images],nil]];
	}
}

-(void) cFadeAndShow:(id)sender data:(void*)data{
	NSMutableArray * images = (NSMutableArray *)data;
	[self fadeAndShow:images];
}

-(void)remove:(CCSprite *)s{
	[s.parent removeChild:s cleanup:YES];
}

-(void)dealloc{
	[super dealloc];
}

@end
