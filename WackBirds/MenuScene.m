//
//  MainMenuScene.m
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

// Import the interfaces
#import "MenuScene.h"
#import "LoopingMenu.h"
#import "CCScrollLayer.h"

// MenuScene implementation
@implementation MenuScene

/*
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuScene *layer = [MenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

*/

- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[MenuLayer node]];
		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end

@implementation MenuLayer
@synthesize birdSprite=_birdSprite,scale=_scale;

//test
@synthesize MenuItemArray=_MenuItemArray;

- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        return point;
    }    
}

- (CCAnimation *)animationFromPlist:(NSString *)animPlist delay:(float)delay {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:animPlist ofType:@"plist"];
    NSArray *animImages = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *animFrames = [NSMutableArray array];
    for(NSString *animImage in animImages) {
        [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:animImage]];
    }
    return [CCAnimation animationWithFrames:animFrames delay:delay];
    
}

-(void)popMenuBird:(ccTime*) dt//:(CCSprite *)bird currentLevel:(int)level 
{
    //popout location
    int test = arc4random() %3 + 1; 
    int angle = 0;
    int moveAngle = 0;
    int downAngle=0;
    switch (test) {
        case 1:  
            
            self.birdSprite = [CCSprite spriteWithSpriteFrameName:@"MenuP.png"];
            [self.birdSprite.texture setAliasTexParameters];
            self.birdSprite.scale = 2;
            self.birdSprite.rotation = -30;            
            self.birdSprite.position = [self convertPoint:ccp(98,395)];        
            [self addChild:self.birdSprite z:12];
            moveAngle=-30; //the angle on the triangle line
            downAngle=-30;
            angle = self.birdSprite.contentSize.height;
            
            break;
        case 2:  
            self.birdSprite = [CCSprite spriteWithSpriteFrameName:@"MenuO.png"];
            [self.birdSprite.texture setAliasTexParameters];
            self.birdSprite.scale = 2; 
            
            self.birdSprite.position = [self convertPoint:ccp(167,405)];
            [self addChild:self.birdSprite z:12];
            moveAngle =0;
            downAngle=0;
            angle = self.birdSprite.contentSize.height;
            
            break;
        case 3:  
            self.birdSprite = [CCSprite spriteWithSpriteFrameName:@"MenuV.png"];
            [self.birdSprite.texture setAliasTexParameters];
            self.birdSprite.scale = 2;
            self.birdSprite.rotation = 30;            
            self.birdSprite.position = [self convertPoint:ccp(237,398)];        
            [self addChild:self.birdSprite z:12];
            moveAngle=30;
            downAngle=30;
            angle = self.birdSprite.contentSize.height;
            break;
        case 4:  
            self.birdSprite = [CCSprite spriteWithSpriteFrameName:@"MenuD.png"];
            [self.birdSprite.texture setAliasTexParameters];
            self.birdSprite.scale = 2;
            self.birdSprite.position = [self convertPoint:ccp(124,320)];
            self.birdSprite.rotation = -30;
            [self addChild:self.birdSprite z:12];
            moveAngle=-30;
            downAngle=-30;
            angle = -self.birdSprite.contentSize.height;
            break;
        case 5:  
            self.birdSprite= [CCSprite spriteWithSpriteFrameName:@"MenuR.png"];
            [self.birdSprite.texture setAliasTexParameters];
            self.birdSprite.scale = 2;
            self.birdSprite.rotation = 90;
            self.birdSprite.position = [self convertPoint:ccp(218,320)];
            [self addChild:self.birdSprite z:12];
            moveAngle=90;
            downAngle=-180;
            angle = self.birdSprite.contentSize.height;
            break;
                 
        default:
            break;
    }
    
    
    
    
   // NSString * menuv = @"menuV";                  
     
    CCRotateTo *rotateUP = [CCRotateTo actionWithDuration:.2 angle:moveAngle];
    CCEaseOut *rotateOut = [CCEaseOut actionWithAction:rotateUP  rate:3.0];
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.2 position:ccp(moveAngle, angle)]; // 1
    CCEaseInOut *easeMoveUp = [CCEaseInOut actionWithAction:moveUp rate:3.0]; // 2
    CCAction *easeMoveDown = [easeMoveUp reverse]; // 3
    CCRotateTo *rotateDown = [CCRotateTo actionWithDuration:.2 angle:downAngle];
    CCEaseIn *rotateIn = [CCEaseIn actionWithAction:rotateDown  rate:3.0];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.5]; // 4
    
    [self.birdSprite runAction:[CCSequence actions:rotateOut, easeMoveUp, delay, rotateIn, easeMoveDown, nil]]; // 5
    
   
    
       
}

// on "init" you need to initialize your instance
-(id) init
{

	if( (self=[super init] )) {
		
        //NSString *dlSheet = @"duckLevel.pvr.ccz";
        NSString *menuPlist = @"menu.plist";
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:menuPlist];
        //CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.jpg"];
        
        float allscale = [AppDelegate get].allScale;
        NSLog(@" my scale : %f", allscale); 
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        //AppDelegate *delegate = [[UIApplication sharedApplication] delegate];        
                     
        CCSprite *menuBg = [CCSprite spriteWithSpriteFrameName:@"MenuBackground.png"];
        //[vLayer1.texture setAliasTexParameters];
        menuBg.scale = 2.0;
        menuBg.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
        //vLayer1.scale = self.scale;
        [self addChild:menuBg z:10];

        CCSprite *eggback = [CCSprite spriteWithSpriteFrameName:@"MenuEggBack.png"];
        [eggback.texture setAliasTexParameters];
        eggback.scale = allscale;
        eggback.position = [self convertPoint:ccp(winSize.width/2,360)];        
        [self addChild:eggback z:11];
        
        CCSprite *eggtop = [CCSprite spriteWithSpriteFrameName:@"MenuEggTop.png"];
        [eggtop.texture setAliasTexParameters];
        eggtop.scale = allscale;
        eggtop.position = [self convertPoint:ccp(winSize.width/2,360)];        
        [self addChild:eggtop z:13];
           
        CCLayer *p2 = [[CCLayer alloc] init];CCLayer *p3 = [[CCLayer alloc] init];CCLayer *p4 = [[CCLayer alloc] init];CCLayer *p5 = [[CCLayer alloc] init];
        CCLayer *p6 = [[CCLayer alloc] init];CCLayer *p7 = [[CCLayer alloc] init];CCLayer *p8 = [[CCLayer alloc] init];CCLayer *p9 = [[CCLayer alloc] init];CCLayer *p10 = [[CCLayer alloc] init];        
        CCLayer *p11 = [[CCLayer alloc] init];CCLayer *p12 = [[CCLayer alloc] init];CCLayer *p13 = [[CCLayer alloc] init]; CCLayer *p14 = [[CCLayer alloc] init];CCLayer *p15 = [[CCLayer alloc] init];
        CCLayer *p16 = [[CCLayer alloc] init];CCLayer *p17 = [[CCLayer alloc] init];CCLayer *p18 = [[CCLayer alloc] init];CCLayer *p19 = [[CCLayer alloc] init];CCLayer *p20 = [[CCLayer alloc] init];
         CCLayer *p21 = [[CCLayer alloc] init];CCLayer *p22 = [[CCLayer alloc] init];CCLayer *p23 = [[CCLayer alloc] init]; CCLayer *p24 = [[CCLayer alloc] init];CCLayer *p25 = [[CCLayer alloc] init];
        
        CCMenuItemImage * item2;CCMenuItemImage * item3;CCMenuItemImage * item4;CCMenuItemImage * item5;  
        CCMenuItem * item6;CCMenuItem * item7;CCMenuItem * item8;CCMenuItem * item9;CCMenuItem * item10;CCMenuItem * item11;CCMenuItem * item12;CCMenuItem * item13;CCMenuItem * item14;CCMenuItem * item15;
        CCMenuItem * item16;CCMenuItem * item17;CCMenuItem * item18;CCMenuItem * item19;CCMenuItem * item20;CCMenuItem * item21;CCMenuItem * item22;CCMenuItem * item23;CCMenuItem * item24;CCMenuItem * item25;
        
        
         int eggL1=1;int eggL2;int eggL3; int eggL4;int eggL5;        
         int eggL6; int eggL7;int eggL8; int eggL9;int eggL10;int eggL11; int eggL12;int eggL13; int eggL14;int eggL15;
         int eggL16; int eggL17;int eggL18; int eggL19;int eggL20;int eggL21; int eggL22;int eggL23; int eggL24;int eggL25;
        
        NSString *eggType; 
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
          
        /////////////////////////////////////////////////
        // PAGE 1
        ////////////////////////////////////////////////
        // create a blank layer for page 1
        CCLayer *p1 = [[CCLayer alloc] init];              
        CCMenuItemImage *image = [CCMenuItemImage itemFromNormalImage:@"EggL1.png" selectedImage:@"EggL1.png" target:self selector:@selector(SelectLevel:)];                                  
        CCMenu *menu1 = [CCMenu menuWithItems: image, nil];
        menu1.position = ccp(winSize.width/2, winSize.height/2);        
        // add menu to page 1
        [p1 addChild:menu1 z:51];
        
        /////////////////////////////////////////////////
        // PAGE 2
        ////////////////////////////////////////////////
		if([usrDef boolForKey:@"2ready"] == YES)
        {
			eggL2 = 2;
            eggType = @"EggL2.png";
            
            item2 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu2 = [CCMenu menuWithItems: item2, nil];            
            menu2.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p2 addChild:menu2 z:51];
        }
            else 
            {   eggL2 = 0;
                eggType = @"EggLock.png";
                item2 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
                item2.position =  ccp( winSize.width /2 , winSize.height/2 );
                [p2 addChild:item2];
            }
        
        /////////////////////////////////////////////////
        // PAGE 3
        ////////////////////////////////////////////////

        if([usrDef boolForKey:@"3ready"] == YES)
        {
			eggL3 = 3;
            eggType = @"EggL3.png";
            item3 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu3 = [CCMenu menuWithItems: item3, nil];  
            menu3.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p3 addChild:menu3 z:51];
        }
            else 
            {   eggL3 = 0;
                eggType = @"EggLock.png";   
                item3 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
                item3.position =  ccp( winSize.width /2 , winSize.height/2 );
                [p3 addChild:item3];
            }
        /////////////////////////////////////////////////
        // PAGE 4
        ////////////////////////////////////////////////

        if([usrDef boolForKey:@"4ready"] == YES)
        { 
			eggL4 = 4;
            eggType = @"EggL4.png";
            item4 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu4 = [CCMenu menuWithItems: item4, nil];  
            menu4.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p4 addChild:menu4 z:51];
        }
            else 
            {   eggL4 = 0;
                eggType = @"EggLock.png"; 
                item4 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
                item4.position =  ccp( winSize.width /2 , winSize.height/2 );
                [p4 addChild:item4];
            }
        /////////////////////////////////////////////////
        // PAGE 5
        ////////////////////////////////////////////////

        if([usrDef boolForKey:@"5ready"] == YES)
        {
			eggL5 = 5;
            eggType = @"EggL5.png";
            item5 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu5 = [CCMenu menuWithItems: item5, nil];  
            menu5.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p5 addChild:menu5 z:51];

        }
            else 
            {   eggL5 = 0;
                eggType = @"EggLock.png";  
                item5 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
                item5.position =  ccp( winSize.width /2 , winSize.height/2 );
                [p5 addChild:item5];
            } 
        
        /////////////////////////////////////////////////
        // PAGE 6
        ////////////////////////////////////////////////
		if([usrDef boolForKey:@"6ready"] == YES)
        {
			eggL6 = 6;
            eggType = @"EggL6.png";
            
            item6 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu6 = [CCMenu menuWithItems: item6, nil];            
            menu6.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p6 addChild:menu6 z:51];
        }
        else 
        {   eggL6 = 0;
            eggType = @"EggLock.png";
            item6 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
            item6.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p6 addChild:item6];
        }
        /////////////////////////////////////////////////
        // PAGE 7
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"7ready"] == YES)
        {
			eggL7 = 7;
            eggType = @"EggL7.png";
            item7 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu7 = [CCMenu menuWithItems: item7, nil];            
            menu7.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p7 addChild:menu7 z:51];
        }
        else 
        {   eggL7 = 0;eggType = @"EggLock.png";
            item7 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];  
            item7.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p7 addChild:item7];
        }
        /////////////////////////////////////////////////
        // PAGE 8
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"8ready"] == YES)
        {
			eggL8 = 8;
            eggType = @"EggL8.png";
            item8 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu8 = [CCMenu menuWithItems: item8, nil];            
            menu8.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p8 addChild:menu8 z:51];
        }
        else 
        {   eggL8 = 0;
            eggType = @"EggLock.png";   
            item8 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item8.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p8 addChild:item8];
        }
        /////////////////////////////////////////////////
        // PAGE 9
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"9ready"] == YES)
        { 
			eggL9 = 9;
            eggType = @"EggL9.png";
            item9 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu9 = [CCMenu menuWithItems: item9, nil];            
            menu9.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p9 addChild:menu9 z:51];
        }
        else 
        {   eggL9 = 0;
            eggType = @"EggLock.png"; 
            item9 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item9.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p9 addChild:item9];
        }
        /////////////////////////////////////////////////
        // PAGE 10
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"10ready"] == YES)
        {
			eggL10 = 10;
            eggType = @"EggL10.png";
            item10 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu10 = [CCMenu menuWithItems: item10, nil];            
            menu10.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p10 addChild:menu10 z:51];
        }
        else 
        {   eggL10 = 0;
            eggType = @"EggLock.png";  
            item10 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];  
            item10.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p10 addChild:item10];
        }
        /////////////////////////////////////////////////
        // PAGE 11
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"11ready"] == YES)
        {
			eggL11 = 11;
            eggType = @"EggL11.png";
            
            item11 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu11 = [CCMenu menuWithItems: item11, nil];            
            menu11.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p11 addChild:menu11 z:51];
        }
        else 
        {   eggL11 = 0;
            eggType = @"EggLock.png";
            item11 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
            item11.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p11 addChild:item11];
        }

        
        /////////////////////////////////////////////////
        // PAGE 12
        ////////////////////////////////////////////////
		if([usrDef boolForKey:@"12ready"] == YES)
        {
			eggL12 = 12;
            eggType = @"EggL12.png";
            
            item12 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu12 = [CCMenu menuWithItems: item12, nil];            
            menu12.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p12 addChild:menu12 z:51];
        }
        else 
        {   eggL12 = 0;
            eggType = @"EggLock.png";
            item12 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
            item12.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p12 addChild:item12];
        }
         
         
        
        /////////////////////////////////////////////////
        // PAGE 13
        ////////////////////////////////////////////////
        
        if([usrDef boolForKey:@"13ready"] == YES)
        {
			eggL13 = 13;
            eggType = @"EggL13.png";
            item13 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu13 = [CCMenu menuWithItems: item13, nil];  
            menu13.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p13 addChild:menu13 z:51];
        }
        else 
        {   eggL13 = 0;
            eggType = @"EggLock.png";   
            item13 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item13.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p13 addChild:item13];
        }
        /////////////////////////////////////////////////
        // PAGE 14
        ////////////////////////////////////////////////
        
        if([usrDef boolForKey:@"14ready"] == YES)
        { 
			eggL14 = 14;
            eggType = @"EggL14.png";
            item14 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu14 = [CCMenu menuWithItems: item14, nil];  
            menu14.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p14 addChild:menu14 z:51];
        }
        else 
        {   eggL14 = 0;
            eggType = @"EggLock.png"; 
            item14 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item14.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p14 addChild:item14];
        }
        
        /////////////////////////////////////////////////
        // PAGE 15
        ////////////////////////////////////////////////
        
        if([usrDef boolForKey:@"15ready"] == YES)
        {
			eggL15 = 5;
            eggType = @"EggL15.png";
            item15 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu15 = [CCMenu menuWithItems: item15, nil];  
            menu15.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p15 addChild:menu15 z:51];
            
        }
        else 
        {   eggL15 = 0;
            eggType = @"EggLock.png";  
            item15 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item15.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p15 addChild:item15];
        } 
        
        /////////////////////////////////////////////////
        // PAGE 16
        ////////////////////////////////////////////////
		if([usrDef boolForKey:@"16ready"] == YES)
        {
			eggL16 = 16;
            eggType = @"EggL16.png";
            
            item16 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu16 = [CCMenu menuWithItems: item16, nil];            
            menu16.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p16 addChild:menu16 z:51];
        }
        else 
        {   eggL16 = 0;
            eggType = @"EggLock.png";
            item16 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
            item16.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p16 addChild:item16];
        }
        /////////////////////////////////////////////////
        // PAGE 17
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"17ready"] == YES)
        {
			eggL17 = 17;
            eggType = @"EggL17.png";
            item17 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu17 = [CCMenu menuWithItems: item17, nil];            
            menu17.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p17 addChild:menu17 z:51];
        }
        else 
        {   eggL17 = 0;eggType = @"EggLock.png";
            item17 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];  
            item17.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p17 addChild:item17];
        }
        /////////////////////////////////////////////////
        // PAGE 18
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"18ready"] == YES)
        {
			eggL18 = 18;
            eggType = @"EggL18.png";
            item18 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu18 = [CCMenu menuWithItems: item18, nil];            
            menu18.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p18 addChild:menu18 z:51];
        }
        else 
        {   eggL18 = 0;
            eggType = @"EggLock.png";   
            item18 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item18.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p18 addChild:item18];
        }
        /////////////////////////////////////////////////
        // PAGE 19
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"19ready"] == YES)
        { 
			eggL19 = 19;
            eggType = @"EggL19.png";
            item19 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu19 = [CCMenu menuWithItems: item19, nil];            
            menu19.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p19 addChild:menu19 z:51];
        }
        else 
        {   eggL19 = 0;
            eggType = @"EggLock.png"; 
            item19 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item19.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p19 addChild:item19];
        }
        /////////////////////////////////////////////////
        // PAGE 20
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"20ready"] == YES)
        {
			eggL20 = 20;
            eggType = @"EggL20.png";
            item20 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu20 = [CCMenu menuWithItems: item20, nil];            
            menu20.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p20 addChild:menu20 z:51];
        }
        else 
        {   eggL20 = 0;
            eggType = @"EggLock.png";  
            item20 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];  
            item20.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p20 addChild:item20];
        }

        /////////////////////////////////////////////////
        // PAGE 21
        ////////////////////////////////////////////////
        if([usrDef boolForKey:@"21ready"] == YES)
        {
			eggL21 = 21;
            eggType = @"EggL21.png";
            
            item21 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu21 = [CCMenu menuWithItems: item21, nil];            
            menu21.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p21 addChild:menu21 z:51];
        }
        else 
        {   eggL21 = 0;
            eggType = @"EggLock.png";
            item21 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
            item21.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p21 addChild:item21];
        }
        
        
        /////////////////////////////////////////////////
        // PAGE 22
        ////////////////////////////////////////////////
		if([usrDef boolForKey:@"22ready"] == YES)
        {
			eggL22 = 22;
            eggType = @"EggL22.png";
            
            item22 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu22 = [CCMenu menuWithItems: item22, nil];            
            menu22.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p22 addChild:menu22 z:51];
        }
        else 
        {   eggL22 = 0;
            eggType = @"EggLock.png";
            item22 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)]; 
            item22.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p22 addChild:item22];
        }
        
        /////////////////////////////////////////////////
        // PAGE 23
        ////////////////////////////////////////////////
        
        if([usrDef boolForKey:@"23ready"] == YES)
        {
			eggL23 = 23;
            eggType = @"EggL23.png";
            item23 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu23 = [CCMenu menuWithItems: item23, nil];  
            menu23.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p23 addChild:menu23 z:51];
        }
        else 
        {   eggL23 = 0;
            eggType = @"EggLock.png";   
            item23 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item23.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p23 addChild:item23];
        }
        /////////////////////////////////////////////////
        // PAGE 24
        ////////////////////////////////////////////////
        
        if([usrDef boolForKey:@"24ready"] == YES)
        { 
			eggL24 = 24;
            eggType = @"EggL24.png";
            item24 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu24 = [CCMenu menuWithItems: item24, nil];  
            menu24.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p24 addChild:menu24 z:51];
        }
        else 
        {   eggL24 = 0;
            eggType = @"EggLock.png"; 
            item24 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item24.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p24 addChild:item24];
        }
        /////////////////////////////////////////////////
        // PAGE 25
        ////////////////////////////////////////////////
        
        if([usrDef boolForKey:@"25ready"] == YES)
        {
			eggL25 = 25;
            eggType = @"EggL25.png";
            item25 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            CCMenu *menu25 = [CCMenu menuWithItems: item25, nil];  
            menu25.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p25 addChild:menu25 z:51];
            
        }
        else 
        {   eggL25 = 0;
            eggType = @"EggLock.png";  
            item25 = [CCMenuItemImage itemFromNormalImage:eggType selectedImage:eggType target: self selector: @selector(SelectLevel:)];
            item25.position =  ccp( winSize.width /2 , winSize.height/2 );
            [p25 addChild:item25];
        } 

        
        /////////////////////////////////////////////////
        // Credits
        ////////////////////////////////////////////////
        CCLayer *creditPage = [[CCLayer alloc] init];        
        CCLabelBMFont *tlabel = [CCLabelBMFont labelWithString:@"Credits" fntFile:@"wackyBirdFntData.fnt"];
        //tlabel.scale = 2.0;
        CCMenuItemLabel *titem = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(GoToCredits:)];
        CCMenu *menu = [CCMenu menuWithItems: titem, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2);
        
        // add menu to page 2
        [creditPage addChild:menu z:51];

     

        
        //need to uncomment
        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: p1,p2,p3,p4,p5,p6,p7,p8,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,creditPage,nil] widthOffset: 150];
        
        // finally add the scroller to your scene
        [self addChild:scroller z:51];       
        
        
        //////shows the high score//////////////
        /*
        CCMenuItem *highscore = [CCMenuItemFont itemFromString:@"Highest Score: 234"];   
        
        CCMenu *highMenu = [CCMenu menuWithItems:highscore,nil]; 
        
		highMenu.position = ccp(200, 160);     
        
		[highMenu alignItemsHorizontallyWithPadding:90];
		[self addChild:highMenu z:51];
         */
         ////////////////////
                
        
        //settings
        CCMenuItemImage * settings = [CCMenuItemImage itemFromNormalImage:@"miniGearEggBtn.png"
                                                          selectedImage:@"miniGearEggBtn.png" 
                                                         disabledImage:@"miniGearEggBtn.png" target:self   selector:@selector(GetSettingsMenu:)];
        settings.scale = 2.0;           
        CCMenu * dMenu = [CCMenu menuWithItems:settings, nil];        
        dMenu.position =  ccp(60, 80);
        [self addChild:dMenu z:100];       
        //end   
        
        //Help button
        CCMenuItemImage * helpButton = [CCMenuItemImage itemFromNormalImage:@"miniHelpEggBtn.png"
                                                            selectedImage:@"miniHelpEggBtn.png" 
                                                            disabledImage:@"miniHelpEggBtn.png" target:self   selector:@selector(GetHelpMenu:)];
        helpButton.scale = 2.0;        
        CCMenu * helpMenu = [CCMenu menuWithItems:helpButton, nil];        
        helpMenu.position =  ccp(260, 80);
        [self addChild:helpMenu z:100];
        //
        
        
        [image setTag:eggL1];
        [item2 setTag:eggL2];
        [item3 setTag:eggL3];    
        [item4 setTag:eggL4];
        [item5 setTag:eggL5];
        [item6 setTag:eggL6];
        [item7 setTag:eggL7];
        [item8 setTag:eggL8];    
        [item9 setTag:eggL9];
        [item10 setTag:eggL10];
        [item11 setTag:eggL11];
        [item12 setTag:eggL12];
        [item13 setTag:eggL13];    
        [item14 setTag:eggL14];
        [item15 setTag:eggL15];
        
        [item16 setTag:eggL16];
        [item17 setTag:eggL17];
        [item18 setTag:eggL18];    
        [item19 setTag:eggL19];
        [item20 setTag:eggL20];
        [item21 setTag:eggL21];
        [item22 setTag:eggL22];
        [item23 setTag:eggL23];    
        [item24 setTag:eggL24];
        [item25 setTag:eggL25];
        
               
		[self schedule:@selector(popMenuBird:) interval:1];
	}
	return self;
}

-(void)SelectLevel:(CCMenuItemImage *)btn
{
    int level = btn.tag;
    [AppDelegate get].currentLevelIndex = level;
    if(level != 0)
    {
        LoadingLevelScene * gs = [LoadingLevelScene node];
        [[CCDirector sharedDirector]replaceScene:gs];
    }
}

-(void)GoToCredits:(id)sender
{
	GameOverScene * gs = [GameOverScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}

-(void)GetHelpMenu:(id)sender
{    
	GameOverScene * gs = [GameOverScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
}

-(void)GetSettingsMenu:(id)sender
{    
	GameOverScene * gs = [GameOverScene node];
	[[CCDirector sharedDirector]replaceScene:gs];
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end
