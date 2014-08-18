//
//  Background.m
//  Whack-em
//
//  Created by AARON on 6/15/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "Background.h"

#import "SimpleAudioEngine.h"

@implementation Background

@synthesize theGame;
@synthesize xB,yB,zB,layerAngle;

//test
@synthesize scale = _scale;

//is used to convert to be able to be in good view on Ipad
- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
       //return ccp(point.x*2,point.y*2); 
        return point;
    }    
}
-(void)resetBg
{
    xB = -1;
    yB = -1;
    zB = -1;
    //scale = -1;
}

- (id) initWithGame:(GameLayer *)game {
    self = [super init];
    if (self != nil) {
        
        self.scale = [AppDelegate get].allScale;
        
		self.theGame = game;
               
        //NSString *dlSheet = @"duckLevel.pvr.ccz";
        NSString *dlPlist = @"duckLevel.plist";
        //NSString *plSheet = @"penguinLevel.pvr.ccz";
        NSString *plPlist = @"penguinLevel.plist";
       // NSString *rlSheet = @"ravenLevel.pvr.ccz";
        NSString *rlPlist = @"ravenLevel.plist";
       // NSString *vlSheet = @"vultureLevel.pvr.ccz";
        NSString *vlPlist = @"vultureLevel.plist";
        //NSString *olSheet = @"ostrichLevel.pvr.ccz";
        NSString *olPlist = @"ostrichLevel.plist";
        
       /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
        {
            //bgSheet = @"background-hd.pvr.ccz";
            // bgPlist = @"background-hd.plist"; 
            dlSheet = @"duckLevel-hd.pvr.ccz";
            dlPlist = @"duckLevel-hd.plist";
            plSheet = @"penguinLevel-hd.pvr.ccz";
            plPlist = @"penguinLevel-hd.plist";
            rlSheet = @"ravenLevel-hd.pvr.ccz";
            rlPlist = @"ravenLevel-hd.plist";
            vlSheet = @"vultureLevel-hd.pvr.ccz";
            vlPlist = @"vultureLevel-hd.plist";        
            olSheet = @"ostrichLevel-hd.pvr.ccz";
            olPlist = @"ostrichLevel-hd.plist";
        }*/
        // Load background and foreground
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:dlPlist];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plPlist];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:rlPlist];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:vlPlist];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:olPlist];        
        
              
        //Might not use delegate in init. 
        CGSize winSize = [CCDirector sharedDirector].winSize;
        //AppDelegate *delegate = [[UIApplication sharedApplication] delegate];        

		/*
		// ***NOTICE **** terrible code. This Init of the Background objects needs to be redone into a couple helper methods.
		*/
			
		
        if(theGame.currentLevel == 1)//Vulture
        {
            CCSprite *vLayer1 = [CCSprite spriteWithSpriteFrameName:@"vl1.png"];
            [vLayer1.texture setAliasTexParameters];
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer1.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            vLayer1.scale = self.scale;
            [theGame addChild:vLayer1 z:30];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer2 = [CCSprite spriteWithSpriteFrameName:@"vl2.png"];
            [vLayer2.texture setAliasTexParameters];
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer2.scale = self.scale;
            vLayer2.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer2 z:28];        
            //[self.currentBgArray addObject:vLayer2];
            
            /////////layer 3////////////////////////
            
            CCSprite *vLayer3 = [CCSprite spriteWithSpriteFrameName:@"vl3.png"];
            [vLayer3.texture setAliasTexParameters];
            vLayer3.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer3.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer3 z:26];
           // [self.currentBgArray addObject:vLayer3];
            
            
            
            CCSprite *vLayer4 = [CCSprite spriteWithSpriteFrameName:@"vl4.png"];
            [vLayer4.texture setAliasTexParameters];
            vLayer4.scale = self.scale;
            // vLayer4.anchorPoint = ccp(0.5, 0);
            vLayer4.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer4 z:24];
            //[self.currentBgArray addObject:vLayer4];
            ///////////////////////////
            
            CCSprite *vLayer5 = [CCSprite spriteWithSpriteFrameName:@"vl5.png"];
            [vLayer5.texture setAliasTexParameters];
            vLayer5.scale = self.scale;
            //vLayer5.anchorPoint = ccp(0.5, 0);
            vLayer5.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer5 z:22];
            //[self.currentBgArray addObject:vLayer5];
            
            ///////////
            
            CCSprite *vLayer6 = [CCSprite spriteWithSpriteFrameName:@"vl6.png"];
            [vLayer6.texture setAliasTexParameters];
            vLayer6.scale = self.scale;
            //vLayer6.anchorPoint = ccp(0.5, 0);
            vLayer6.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer6 z:20];
           // [self.currentBgArray addObject:vLayer6]; 
            
            
            CCSprite *vLayer7 = [CCSprite spriteWithSpriteFrameName:@"vl7.png"];
            [vLayer7.texture setAliasTexParameters];
            vLayer7.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer7.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer7 z:18];
            //[self.currentBgArray addObject:vLayer7];
            
        }    
                   
        if(theGame.currentLevel == 2) //Ostrich 13
        {          
            CCSprite *vLayer1 = [CCSprite spriteWithSpriteFrameName:@"os1.png"];
            [vLayer1.texture setAliasTexParameters];
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer1.scale = self.scale;
            vLayer1.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer1 z:30];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer2 = [CCSprite spriteWithSpriteFrameName:@"os2.png"];
            [vLayer2.texture setAliasTexParameters];
            vLayer2.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer2.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer2 z:28];        
            //[self.currentBgArray addObject:vLayer2];
            
            /////////layer 3////////////////////////
            
            CCSprite *vLayer3 = [CCSprite spriteWithSpriteFrameName:@"os3.png"];
            [vLayer3.texture setAliasTexParameters];
            vLayer3.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer3.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer3 z:26];
            // [self.currentBgArray addObject:vLayer3];
            
            
            
            CCSprite *vLayer4 = [CCSprite spriteWithSpriteFrameName:@"os4.png"];
            [vLayer4.texture setAliasTexParameters];
            vLayer4.scale = self.scale;
            // vLayer4.anchorPoint = ccp(0.5, 0);
            vLayer4.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer4 z:24];
            //[self.currentBgArray addObject:vLayer4];
            ///////////////////////////
            
            CCSprite *vLayer5 = [CCSprite spriteWithSpriteFrameName:@"os5.png"];
            [vLayer5.texture setAliasTexParameters];
            vLayer5.scale = self.scale;
            //vLayer5.anchorPoint = ccp(0.5, 0);
            vLayer5.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer5 z:22];
            //[self.currentBgArray addObject:vLayer5];
            
            ///////////
            
            CCSprite *vLayer6 = [CCSprite spriteWithSpriteFrameName:@"os6.png"];
            [vLayer6.texture setAliasTexParameters];
            vLayer6.scale = self.scale;
            //vLayer6.anchorPoint = ccp(0.5, 0);
            vLayer6.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer6 z:20];
            // [self.currentBgArray addObject:vLayer6]; 
            
            
            CCSprite *vLayer7 = [CCSprite spriteWithSpriteFrameName:@"os7.png"];
            [vLayer7.texture setAliasTexParameters];
            vLayer7.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer7.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer7 z:18];
            //[self.currentBgArray addObject:vLayer7];
            
            CCSprite *vLayer8 = [CCSprite spriteWithSpriteFrameName:@"os8.png"];
            [vLayer8.texture setAliasTexParameters];
            vLayer8.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer8.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer8 z:16];
            
            /////////layer 3////////////////////////
            
            CCSprite *vLayer9 = [CCSprite spriteWithSpriteFrameName:@"os9.png"];
            [vLayer9.texture setAliasTexParameters];
            vLayer9.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer9.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer9 z:14];
            // [self.currentBgArray addObject:vLayer3];

            CCSprite *vLayer10 = [CCSprite spriteWithSpriteFrameName:@"os10.png"];
            [vLayer10.texture setAliasTexParameters];
            vLayer10.scale = self.scale;
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer10.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer10 z:12];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer11 = [CCSprite spriteWithSpriteFrameName:@"os11.png"];
            [vLayer11.texture setAliasTexParameters];
            vLayer11.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer11.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer11 z:10];        
            //[self.currentBgArray addObject:vLayer2];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer12 = [CCSprite spriteWithSpriteFrameName:@"os12.png"];
            [vLayer12.texture setAliasTexParameters];
            vLayer12.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer12.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer12 z:8];        
            //[self.currentBgArray addObject:vLayer2];          
            
            /////////layer 2////////////////////////
            /*
            CCSprite *vLayer13 = [CCSprite spriteWithSpriteFrameName:@"ol13.png"];
            [vLayer13.texture setAliasTexParameters];
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer13.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer13 z:7];        
            //[self.currentBgArray addObject:vLayer2];       
             */
            
        }
        
        if(theGame.currentLevel == 3)//Raven 10
        {       
            CCSprite *vLayer1 = [CCSprite spriteWithSpriteFrameName:@"rl1.png"];
            [vLayer1.texture setAliasTexParameters];
            vLayer1.scale = self.scale;
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer1.position = [self convertPoint:ccp(winSize.width/2,230)];
            [theGame addChild:vLayer1 z:30];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer2 = [CCSprite spriteWithSpriteFrameName:@"rl2.png"];
            [vLayer2.texture setAliasTexParameters];
            vLayer2.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer2.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer2 z:28];        
            //[self.currentBgArray addObject:vLayer2];
            
            /////////layer 3////////////////////////
            
            CCSprite *vLayer3 = [CCSprite spriteWithSpriteFrameName:@"rl3.png"];
            [vLayer3.texture setAliasTexParameters];
            vLayer3.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer3.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer3 z:26];
            // [self.currentBgArray addObject:vLayer3];
            
            
            
            CCSprite *vLayer4 = [CCSprite spriteWithSpriteFrameName:@"rl4.png"];
            [vLayer4.texture setAliasTexParameters];
            vLayer4.scale = self.scale;
            // vLayer4.anchorPoint = ccp(0.5, 0);
            vLayer4.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer4 z:24];
            //[self.currentBgArray addObject:vLayer4];
            ///////////////////////////
            
            CCSprite *vLayer5 = [CCSprite spriteWithSpriteFrameName:@"rl5.png"];
            [vLayer5.texture setAliasTexParameters];
            vLayer5.scale = self.scale;
            //vLayer5.anchorPoint = ccp(0.5, 0);
            vLayer5.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer5 z:22];
            //[self.currentBgArray addObject:vLayer5];
            
            ///////////
            
            CCSprite *vLayer6 = [CCSprite spriteWithSpriteFrameName:@"rl6.png"];
            [vLayer6.texture setAliasTexParameters];
            vLayer6.scale = self.scale;
            //vLayer6.anchorPoint = ccp(0.5, 0);
            vLayer6.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer6 z:20];
            // [self.currentBgArray addObject:vLayer6]; 
            
            
            CCSprite *vLayer7 = [CCSprite spriteWithSpriteFrameName:@"rl7.png"];
            [vLayer7.texture setAliasTexParameters];
            vLayer7.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer7.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer7 z:18];
            //[self.currentBgArray addObject:vLayer7];
            
            CCSprite *vLayer8 = [CCSprite spriteWithSpriteFrameName:@"rl8.png"];
            [vLayer8.texture setAliasTexParameters];
            vLayer8.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer8.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer8 z:16];
            /*
            CCSprite *vLayer9 = [CCSprite spriteWithSpriteFrameName:@"rl9.png"];
            [vLayer9.texture setAliasTexParameters];
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer9.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer9 z:14];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer10 = [CCSprite spriteWithSpriteFrameName:@"rl10.png"];
            [vLayer10.texture setAliasTexParameters];
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer10.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer10 z:12];        
            //[self.currentBgArray addObject:vLayer2];
             */
            
        }
        if(theGame.currentLevel == 4)//Penguin 10
        {          
            CCSprite *vLayer1 = [CCSprite spriteWithSpriteFrameName:@"pl1.png"];
            [vLayer1.texture setAliasTexParameters];
            vLayer1.scale = self.scale;
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer1.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer1 z:30];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer2 = [CCSprite spriteWithSpriteFrameName:@"pl2.png"];
            [vLayer2.texture setAliasTexParameters];
            vLayer2.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer2.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer2 z:28];        
            //[self.currentBgArray addObject:vLayer2];
            
            /////////layer 3////////////////////////
            
            CCSprite *vLayer3 = [CCSprite spriteWithSpriteFrameName:@"pl3.png"];
            [vLayer3.texture setAliasTexParameters];
            vLayer3.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer3.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer3 z:26];
            // [self.currentBgArray addObject:vLayer3];
            
            
            
            CCSprite *vLayer4 = [CCSprite spriteWithSpriteFrameName:@"pl4.png"];
            [vLayer4.texture setAliasTexParameters];
            vLayer4.scale = self.scale;
            // vLayer4.anchorPoint = ccp(0.5, 0);
            vLayer4.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer4 z:24];
            //[self.currentBgArray addObject:vLayer4];
            ///////////////////////////
            
            CCSprite *vLayer5 = [CCSprite spriteWithSpriteFrameName:@"pl5.png"];
            [vLayer5.texture setAliasTexParameters];
            vLayer5.scale = self.scale;
            //vLayer5.anchorPoint = ccp(0.5, 0);
            vLayer5.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer5 z:22];
            //[self.currentBgArray addObject:vLayer5];
            
            ///////////
            
            CCSprite *vLayer6 = [CCSprite spriteWithSpriteFrameName:@"pl6.png"];
            [vLayer6.texture setAliasTexParameters];
            vLayer6.scale = self.scale;
            //vLayer6.anchorPoint = ccp(0.5, 0);
            vLayer6.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer6 z:20];
            // [self.currentBgArray addObject:vLayer6]; 
            
            
            CCSprite *vLayer7 = [CCSprite spriteWithSpriteFrameName:@"pl7.png"];
            [vLayer7.texture setAliasTexParameters];
            vLayer7.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer7.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer7 z:18];
            //[self.currentBgArray addObject:vLayer7];
            
            
            CCSprite *vLayer8 = [CCSprite spriteWithSpriteFrameName:@"pl8.png"];
            [vLayer8.texture setAliasTexParameters];
            vLayer8.scale = self.scale;
            //vLayer5.anchorPoint = ccp(0.5, 0);
            vLayer8.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer8 z:16];
            //[self.currentBgArray addObject:vLayer5];
            
            ///////////
            
            CCSprite *vLayer9 = [CCSprite spriteWithSpriteFrameName:@"pl9.png"];
            [vLayer9.texture setAliasTexParameters];
            vLayer9.scale = self.scale;
            //vLayer6.anchorPoint = ccp(0.5, 0);
            vLayer9.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer9 z:14];
            // [self.currentBgArray addObject:vLayer6]; 
            
            /*
            CCSprite *vLayer10 = [CCSprite spriteWithSpriteFrameName:@"pl10.png"];
            [vLayer10.texture setAliasTexParameters];
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer10.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer10 z:12];
            //[self.currentBgArray addObject:vLayer7];
             */
           
        }
        if(theGame.currentLevel == 5)
        {          
            CCSprite *vLayer1 = [CCSprite spriteWithSpriteFrameName:@"dl1.png"];
            [vLayer1.texture setAliasTexParameters];
            vLayer1.scale = self.scale;
            //vLayer1.anchorPoint = ccp(0.5, 1);
            vLayer1.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer1 z:30];
            //[self.currentBgArray addObject:vLayer1];
            
            /////////layer 2////////////////////////
            
            CCSprite *vLayer2 = [CCSprite spriteWithSpriteFrameName:@"dl2.png"];
            [vLayer2.texture setAliasTexParameters];
            vLayer2.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer2.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer2 z:28];        
            //[self.currentBgArray addObject:vLayer2];
            
            /////////layer 3////////////////////////
            
            CCSprite *vLayer3 = [CCSprite spriteWithSpriteFrameName:@"dl3.png"];
            [vLayer3.texture setAliasTexParameters];
            vLayer3.scale = self.scale;
            //vLayer2.anchorPoint = ccp(0.5, 0);
            vLayer3.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer3 z:26];
            // [self.currentBgArray addObject:vLayer3];
            
            
            
            CCSprite *vLayer4 = [CCSprite spriteWithSpriteFrameName:@"dl4.png"];
            [vLayer4.texture setAliasTexParameters];
            vLayer4.scale = self.scale;
            // vLayer4.anchorPoint = ccp(0.5, 0);
            vLayer4.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer4 z:24];
            //[self.currentBgArray addObject:vLayer4];
            ///////////////////////////
            
            CCSprite *vLayer5 = [CCSprite spriteWithSpriteFrameName:@"dl5.png"];
            [vLayer5.texture setAliasTexParameters];
            vLayer5.scale = self.scale;
            //vLayer5.anchorPoint = ccp(0.5, 0);
            vLayer5.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer5 z:22];
            //[self.currentBgArray addObject:vLayer5];
            
            ///////////
            
            CCSprite *vLayer6 = [CCSprite spriteWithSpriteFrameName:@"dl6.png"];
            [vLayer6.texture setAliasTexParameters];
            vLayer6.scale = self.scale;
            //vLayer6.anchorPoint = ccp(0.5, 0);
            vLayer6.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];//winSize.width/2,140)];
            [theGame addChild:vLayer6 z:20];
            // [self.currentBgArray addObject:vLayer6]; 
            
            
            CCSprite *vLayer7 = [CCSprite spriteWithSpriteFrameName:@"dl7.png"];
            [vLayer7.texture setAliasTexParameters];
            vLayer7.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer7.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer7 z:18];
            //[self.currentBgArray addObject:vLayer7];
            
            CCSprite *vLayer8 = [CCSprite spriteWithSpriteFrameName:@"dl8.png"];
            [vLayer8.texture setAliasTexParameters];
            vLayer8.scale = self.scale;
            //vLayer3.anchorPoint = ccp(0.5, 0);
            vLayer8.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            [theGame addChild:vLayer8 z:16];
            
                   }
        
        
        NSLog(@"INIT Background");
                
		
    }
    return self;
}

-(void)displayLayers
{
}

-(void)update
{
}

@end
