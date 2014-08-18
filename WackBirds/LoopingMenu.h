//
//  LoopingMenu.h
//  wackybirds
//
//  Created by AARON on 7/9/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface LoopingMenu : CCMenu
{	
	float hPadding;
	float lowerBound;
	float yOffset;
	bool moving;
	bool touchDown;
	float accelerometerVelocity;
}

@property float yOffset;
@end
