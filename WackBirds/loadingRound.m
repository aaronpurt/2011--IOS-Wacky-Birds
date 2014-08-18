//
//  SplashScene.m
//  Whack-em
//
//  Created by AARON on 6/11/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "loadingRound.h"
#import "GameScene.h"

@implementation LoadingRound
- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[LoadingRoundLayer node]];
    }
    return self;
}

-(void)dealloc{
	[super dealloc];
}
@end

@implementation LoadingRoundLayer
- (id) init {
    if ((self = [super init])) {
		
        int test = [AppDelegate get].timerLevelCount;

		isTouchEnabled_ = YES;

		NSMutableArray * splashImages = [[NSMutableArray alloc]init];
		for(int i =1;i<=2;i++)
		{
			CCSprite * splashImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"egg%d.png",test]];
			[splashImage setPosition:ccp(160,240)];
			[self addChild:splashImage z:0];
			if(i!=1)
                
            [splashImage setOpacity:.2];
			[splashImages addObject:splashImage];
		}
		
		[self fadeAndShow:splashImages];
 
    }
    return self;
}

-(void)fadeAndShow:(NSMutableArray *)images
{
	if([images count]<=1)
	{
		[images release];
               
        //need to get the current level from AppDelegate.
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
		[next runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],[CCFadeIn actionWithDuration:0.1],[CCDelayTime actionWithDuration:0.5],[CCCallFuncND actionWithTarget:self selector:@selector(cFadeAndShow: data:) data:images],nil]];
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
