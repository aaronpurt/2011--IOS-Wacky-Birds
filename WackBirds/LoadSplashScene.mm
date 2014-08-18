//
//  LoadSplashScene.m
//  wackybirds
//
//  Created by AARON on 7/9/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "LoadSplashScene.h"
#import "cocos2d.h"

@implementation LoadSplashScene

- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[LoadSplashLayer node]];		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}
@end

@implementation LoadSplashLayer

- (id) init {
    if ((self = [super init])) {
		
		isTouchEnabled_ = YES;
		
		NSMutableArray * splashImages = [[NSMutableArray alloc]init];
		for(int i =1;i<=1;i++)
		{
            CCSprite * splashImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"splash%d.png",i]];
            [splashImage setScale:2];
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

-(void)InitOFdata{

    //[[CCDirector sharedDirector] pause];
    //[[CCDirector sharedDirector] stopAnimation];
    
       
    //window.. needed..
    
	//ofDelegate = [SampleOFDelegate new];
	//ofNotificationDelegate = [SampleOFNotificationDelegate new];
	//ofChallengeDelegate = [SampleOFChallengeDelegate new];
	//ofBragDelegate = [SampleOFBragDelegate new];
    
	/*OFDelegatesContainer* delegates = [OFDelegatesContainer containerWithOpenFeintDelegate:ofDelegate
     andChallengeDelegate:ofChallengeDelegate
     andNotificationDelegate:ofNotificationDelegate];
     
     delegates.bragDelegate = ofBragDelegate;
     */
         
    //[[CCDirector sharedDirector] resume];
    
}


-(void)fadeAndShow:(NSMutableArray *)images
{
	if([images count]<=0)
	{        
		[images release];        
		[[CCDirector sharedDirector]replaceScene:[CCTransitionFlipAngular transitionWithDuration:0.2 scene:[MenuScene node] orientation:kOrientationLeftOver]];
	}else {
		
		CCSprite * actual = (CCSprite *)[images objectAtIndex:0];
		[images removeObjectAtIndex:0];
		      [actual runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCFadeOut actionWithDuration:0.2],[CCDelayTime actionWithDuration:0.1],[CCCallFuncND actionWithTarget:self selector:@selector(cFadeAndShow:data:)data:images],nil]];	

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
