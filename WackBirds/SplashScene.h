//
//  SplashScene.h
//  AerialGun
//
//  Created by Pablo Ruiz on 5/14/10.
//  Copyright 2010 Wacky Birds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuScene.h"

@interface SplashScene : CCScene {
}

@end

@interface SplashLayer : CCLayer {

}
-(void)fadeAndShow:(NSMutableArray *)images;
-(void)InitOFdata;
-(void) cFadeAndShow:(id)sender data:(void*)data;
@end