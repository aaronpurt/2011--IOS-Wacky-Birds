//
//  SplashScene.h
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "SplashScene.h"
#import "cocos2d.h"
#import "MenuScene.h"

@implementation SplashScene

- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[SplashLayer node]];
		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end

@implementation SplashLayer

- (id) init {
    if ((self = [super init])) {
		
		isTouchEnabled_ = YES;
		
		NSMutableArray * splashImages = [[NSMutableArray alloc]init];
		for(int i =1;i<=2;i++)
		{
			CCSprite * splashImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"splash%d.png",i]];
			[splashImage setPosition:ccp(160,240)];
			[self addChild:splashImage];
			if(i!=1)
				[splashImage setOpacity:0];
			
			[splashImages addObject:splashImage];
		}
		
		[self fadeAndShow:splashImages];
        
		
    }
    return self;
}

-(void)InitOFdata
{
        
}


-(void)fadeAndShow:(NSMutableArray *)images
{
	if([images count]<=1)
	{
		[images release];
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipAngular transitionWithDuration:2 scene:[MenuScene node] orientation:kOrientationLeftOver]];
	}else {
		
		CCSprite * actual = (CCSprite *)[images objectAtIndex:0];
		[images removeObjectAtIndex:0];
		
		CCSprite * next = (CCSprite *)[images objectAtIndex:0];
		
		
		[actual runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2],[CCFadeOut actionWithDuration:1],[CCCallFuncN actionWithTarget:self selector:@selector(remove:)],nil]];
		[next runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2],[CCFadeIn actionWithDuration:1],[CCDelayTime actionWithDuration:2],[CCCallFuncND actionWithTarget:self selector:@selector(cFadeAndShow: data:)data:images],nil]];
	}
}

-(void) cFadeAndShow:(id)sender data:(void*)data
{
	NSMutableArray * images = (NSMutableArray *)data;
        
	[self fadeAndShow:images];
  
}

-(void)remove:(CCSprite *)s
{
	[s.parent removeChild:s cleanup:YES];
}

-(void)dealloc
{
	[super dealloc];
}

@end
