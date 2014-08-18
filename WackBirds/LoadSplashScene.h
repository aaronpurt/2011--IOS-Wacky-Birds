//
//  LoadSplashScene.h
//  wackybirds
//
//  Loads the Game company images and the game image for the game when you first load the game
//  Created by AARON on 7/9/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuScene.h"

@interface LoadSplashScene : CCScene {	
}
@end

@interface LoadSplashLayer : CCLayer {    
}
-(void)fadeAndShow:(NSMutableArray *)images;
-(void)InitOFdata;
-(void)cFadeAndShow:(id)sender data:(void*)data;

@end