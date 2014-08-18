//
//  Bird.m
//  Whack-em
//
//  Created by AARON on 6/7/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "Bird.h"
#import "SimpleAudioEngine.h"

@implementation Bird

@synthesize birdSprite=_birdSprite,theGame=_theGame,negBirdSprite=_negBirdSprite;
@synthesize xB=_xB,yB=_yB,zB=_zB;
@synthesize scale=_scale, birdBeginScale=_birdBeginScale, birdAngle=_birdAngle,birdLocation = _birdLocation,birdIndexCount=_birdIndexCount;
@synthesize tongueAnim = _tongueAnim;

//test
@synthesize negBirdIndexCount = _negBirdIndexCount,isNegativeBird=_isNegativeBird;
@synthesize rotateAnim=_rotateAnim,scaleAnim=_scaleAnim,moveAnim=_moveAnim,delayAnim=_delayAnim;


//is used to convert to be able to be in good view on Ipad
- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        //return ccp(point.x*2,point.y*2); 
        return point;
    }    
}


-(void)resetBirds
{       
    self.xB = -1,self.yB = -1,self.zB = -1;   
    
    if(self.birdSprite != nil)
    {
        [self removeChild:self.birdSprite cleanup:YES];
        self.birdSprite = nil;
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

- (id) initWithGame:(GameLayer *)game {
    self = [super init];
    if (self != nil) {
		
        [self resetBirds];         
		self.theGame = game;       
        
        NSString *pBirdSheet = @"positiveBirds.pvr.ccz";
        NSString *pBirdPlist = @"positiveBirds.plist";
        NSString *nBirdSheet = @"negativeBirds.pvr.ccz";
        NSString *nBirdPlist = @"negativeBirds.plist";
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
        {         
            pBirdSheet = @"positiveBirds-hd.pvr.ccz";
            pBirdPlist = @"positiveBirds-hd.plist";
            nBirdSheet = @"negativeBirds-hd.pvr.ccz";
            nBirdPlist = @"negativeBirds-hd.plist"; 
        }           
      
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:pBirdPlist];   
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:nBirdPlist]; 
		
        [self initBirds]; 

    }
    return self;
}

-(void)loadBirdType:(NSString *)birdName hitImg:(NSString *)hit missImg:(NSString *)miss 
{
}

-(void)loadBirdData:(NSString *)birdName hitImg:(NSString *)hit missImg:(NSString *)miss // bScale:(int)bscale xLoc:(float)bx yLoc:(float)by zLoc:(float)bz bAngle:(int)bAngle
{
    self.birdSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithString:birdName]];
    self.theGame.missPosAnim = miss;
    self.theGame.hitPosAnim = hit;  
  }


-(void) beginScale:(int)beginScale scale:(int)scale x:(int) x  y:(int)y z:(int)z angle:(int)angle
{
    self.birdBeginScale = beginScale;
    self.scale = scale;
    self.xB = x;
    self.yB = y;
    self.zB = z;                                        
    self.birdAngle = angle;  
    
    [self.birdSprite.texture setAliasTexParameters];   
    self.birdSprite.scale = self.scale;         
    self.birdSprite.position = [self convertPoint:ccp(self.xB , self.yB)];                      
    [self.theGame addChild:self.birdSprite z:self.zB]; 
    
    //Todo: Goes to the Bird manager.. 
    [self.theGame.currentBirds   addObject:self.birdSprite]; 
}

-(void) badBird:(NSString *)bad  good:(NSString *)good  
{
    if(self.theGame.isNegativeBird == true)
    {
        [self loadBirdData:bad hitImg:@"hitAnimS" missImg:@"missAnimS" ];        
    }
    else
    {
        self.birdSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithString:good]];
        self.theGame.missPosAnim=@"missAnimV";
        self.theGame.hitPosAnim=@"hitAnimV";
    }
}

-(void)initBirds
{   
   // NSLog(@"bird Loc: %@", self.birdLocation);   
    switch (self.theGame.currentLevel) {
        case 1:
        case 6:
		case 11:
		case 16:
		case 21:
            [self badBird:@"snake_1.png" good:@"vulture_1.png"];
                                  
			switch (self.birdLocation) 
			{				
				case 1:								
					[self beginScale:0 scale:.98 x:60 y:-5 z:27 angle:0]; 
					break;
				case 2:     
					[self beginScale:0 scale:.99 x:260 y:-5 z:27 angle:0]; 
					break;
				case 3:    
					[self beginScale:0 scale:.95 x:120 y:25 z:25 angle:0]; 
					break;
				case 4:    
					[self beginScale:0 scale:.84 x:90 y:140 z:23 angle:0]; 
					
					break;
				case 5:    
					[self beginScale:0 scale:.84 x:260 y:140 z:23 angle:0]; 
					
					break;
				case 6: 
					[self beginScale:0 scale:.80 x:160 y:195 z:21 angle:0]; 
					break;                   
				default:
				break;
			}
            break;  
			
        case 2:
		case 7:
		case 12:
		case 17:
		case 22:		
            [self badBird:@"ostrich_1.png" good:@"mongoose_1.png"];
            
            switch (self.birdLocation) 
            {
            case 1: 
                [self beginScale:.80 scale:.98 x:160 y:20 z:27 angle:0]; 
                break;
            case 2:  
                    [self beginScale:.60 scale:.85 x:100 y:120 z:23 angle:0]; 
                break;
            case 3:   
                [self beginScale:.60 scale:.60 x:220 y:100 z:23 angle:0]; 

                break;
            case 4:  
                [self beginScale:.40 scale:.50 x:125 y:180 z:19 angle:0]; 
                break;
            case 5:  
                [self beginScale:.40 scale:.50 x:200 y:170 z:19 angle:0]; 
                break;
            case 6: 
                [self beginScale:.30 scale:.30 x:160 y:200 z:15 angle:0]; 

                break;                                 
            default:
                break;
			}            
            break;
        case 3:
        case 8:
		case 13:
		case 18:
		case 23:
             [self badBird:@"bat_1.png" good:@"raven_1.png"];
                   
			switch (self.birdLocation) 
			{
            case 1: 
                [self beginScale:.80 scale:70 x:60 y:25 z:15 angle:0]; 
                break;
            case 2:  
                [self beginScale:0 scale:.235 x:80 y:25 z:15 angle:-40];                           
                break;
            case 3:   
               [self beginScale:0 scale:.70 x:150 y:200 z:23 angle:0]; 
                break;
            case 4:  
                [self beginScale:0 scale:.60 x:30 y:260 z:21 angle:30]; 
                break;                    
            case 5: 
               [self beginScale:0 scale:.30 x:270 y:220 z:21 angle:-20]; 
                break;
            case 6: 
               [self beginScale:0 scale:.60 x:95 y:300 z:19 angle:20]; 
                break;
            case 7: 
                [self beginScale:0 scale:.60 x:225 y:280 z:19 angle:-40];                  
                break;                                 
            default:
                break;
			}            
            
            break;
        case 4:
		case 9:
		case 14:
		case 19:
		case 24:
			[self badBird:@"polar_1.png" good:@"penguin_1.png"];
            
            switch (self.birdLocation) 
			{
            case 1: 
                 [self beginScale:0 scale:1.2 x:160 y:-80 z:29 angle:0];    
                break;
            case 2:  
                 [self beginScale:0 scale:.95 x:100 y:80 z:25 angle:0];                  
                break;
            case 3: 
                 [self beginScale:0 scale:.95 x:220 y:80 z:25 angle:0]; 
                break;
            case 4: 
                 [self beginScale:0 scale:.80 x:50 y:180 z:21 angle:0]; 
                break;                
            case 5:  
                 [self beginScale:0 scale:.80 x:160 y:180 z:21 angle:0];                 
                break;
            case 6:   
                 [self beginScale:0 scale:.80 x:270 y:180 z:21 angle:0]; 
                break;              
            case 7: 
                 [self beginScale:0 scale:.60 x:110 y:230 z:17 angle:0]; 
                break;
            case 8:  
                 [self beginScale:0 scale:.60 x:210 y:230 z:17 angle:0];  
                break; 
            default:
                break;
			}                        
            break;
        case 5:	
		case 10:
		case 15:
		case 20:
		case 25:		
			[self badBird:@"gator_1.png" good:@"polar_1.png"];
               
            switch (self.birdLocation) 
			{
				case 1:                 
					[self beginScale:0 scale:.90 x:160 y:30 z:27 angle:0];  
					break;
				case 2:  
					 [self beginScale:0 scale:.80 x:80 y:120 z:25 angle:0];
					break;                
				case 3:   
					 [self beginScale:0 scale:.80 x:250 y:120 z:25 angle:0];
					break;
				case 4:  
					[self beginScale:0 scale:.75 x:160 y:180 z:23 angle:0];
					break;                
				case 5: 
					[self beginScale:0 scale:.750 x:80 y:220 z:21 angle:0];                
					break;
				case 6: 
					 [self beginScale:0 scale:.75 x:250 y:220 z:21 angle:0];
					break;              
				case 7:   
					 [self beginScale:0 scale:.60 x:170 y:260 z:19 angle:0];
					break;

				default:
					break;        
            }        
            break;       
    }    
}


- (void)setTappable:(id)sender {
    CCSprite *bird = (CCSprite *)sender;    
    [bird setUserData:TRUE];
    [[SimpleAudioEngine sharedEngine] playEffect:@"laugh.caf"];
}

- (void)unsetTappable:(id)sender {
    CCSprite *bird = (CCSprite *)sender;
    [bird setUserData:FALSE];    
    //goes on when the bird is below ground. 
}
//not used. currently. 
- (void)animationDone {
    
    //also release the animation if it's a class variable, which I have
     [_tongueAnim release];
    
	[self stopAllActions];
	//[self removeChild:_birdSprite cleanup:YES];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
}


-(void)popVultureLevelBird:(CCSprite *)bird currentLevel:(int)level
{
         
    [self initBirds];
    
    // Create animations          
    CCAnimation *laughAnim = [self animationFromPlist:self.theGame.missPosAnim delay:_delayAnim];    //.1  
    [[CCAnimationCache sharedAnimationCache] addAnimation:laughAnim name:self.theGame.missPosAnim]; 
    
    if(_birdAngle != 0)
    {  
        CCRotateTo *rotateUP = [CCRotateTo actionWithDuration:_rotateAnim angle:self.birdAngle];
        CCEaseOut *rotateOut = [CCEaseOut actionWithAction:rotateUP  rate:3.0];
        
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.5];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];
        //POP bird
        
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3)]; // 1
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0]; // 2
        
        
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:YES];      
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ]; // 4
        
        
        CCRotateTo *rotateDown = [CCRotateTo actionWithDuration:_moveAnim angle:self.birdAngle];
        CCEaseIn *rotateIn = [CCEaseIn actionWithAction:rotateDown  rate:3.0];
        
        
        [self.birdSprite runAction:[CCSequence actions:rotateOut,midScale, easeMoveUp,  setTappable,fullScale, laugh,unsetTappable, rotateIn,downScale, easeMoveDown, nil]]; // 5
        
    }
    else
    {
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.scale];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];
        
        
        //POP bird
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3) ];
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0];      
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:NO];    
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ];  
        CCMoveBy *moveDown = [CCMoveBy  actionWithDuration:_moveAnim position:ccp(0, -120)];      
        
        [self.birdSprite runAction:[CCSequence actions:midScale, moveUp,easeMoveUp,setTappable, fullScale, laugh,unsetTappable,easeMoveDown, moveDown ,downScale, nil]]; 
        
    }
    
     
}

-(void)popOstrichLevelBird:(CCSprite *)bird currentLevel:(int)level
{
    [self initBirds];
    
    // Create animations          
    CCAnimation *laughAnim = [self animationFromPlist:self.theGame.missPosAnim delay:_delayAnim];    //.1  
    [[CCAnimationCache sharedAnimationCache] addAnimation:laughAnim name:self.theGame.missPosAnim]; 
    
    if(_birdAngle != 0)
    {  
        CCRotateTo *rotateUP = [CCRotateTo actionWithDuration:_rotateAnim angle:self.birdAngle];
        CCEaseOut *rotateOut = [CCEaseOut actionWithAction:rotateUP  rate:3.0];
        
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.5];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];
        //POP bird
        
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3)]; // 1
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0]; // 2
        
        
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:YES];      
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ]; // 4
        
        
        CCRotateTo *rotateDown = [CCRotateTo actionWithDuration:_moveAnim angle:self.birdAngle];
        CCEaseIn *rotateIn = [CCEaseIn actionWithAction:rotateDown  rate:3.0];
        
        
        [self.birdSprite runAction:[CCSequence actions:rotateOut,midScale, easeMoveUp,  setTappable,fullScale, laugh,unsetTappable, rotateIn,downScale, easeMoveDown, nil]]; // 5
        
    }
    else
    {
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.birdBeginScale];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.scale];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.birdBeginScale];
        
        
        //POP bird
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3) ];
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0];      
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:NO];    
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ];  
        CCMoveBy *moveDown = [CCMoveBy  actionWithDuration:_moveAnim position:ccp(0, -120)];      
        
        [self.birdSprite runAction:[CCSequence actions:midScale, moveUp,easeMoveUp,setTappable, fullScale, laugh,unsetTappable,easeMoveDown, moveDown ,downScale, nil]]; 
        
    }

}
-(void)popRavenLevelBird:(CCSprite *)bird currentLevel:(int)level
{[self initBirds];
    
    [self initBirds];
    
    // Create animations          
    CCAnimation *laughAnim = [self animationFromPlist:self.theGame.missPosAnim delay:_delayAnim];    //.1  
    [[CCAnimationCache sharedAnimationCache] addAnimation:laughAnim name:self.theGame.missPosAnim]; 
    
    if(_birdAngle != 0)
    {  
        CCRotateTo *rotateUP = [CCRotateTo actionWithDuration:_rotateAnim angle:self.birdAngle];
        CCEaseOut *rotateOut = [CCEaseOut actionWithAction:rotateUP  rate:3.0];
        
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.5];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];
        //POP bird
        
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3)]; // 1
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0]; // 2
        
        
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:NO];      
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ]; // 4
        
        
        CCRotateTo *rotateDown = [CCRotateTo actionWithDuration:_moveAnim angle:self.birdAngle];
        CCEaseIn *rotateIn = [CCEaseIn actionWithAction:rotateDown  rate:3.0];
        
        
        [self.birdSprite runAction:[CCSequence actions:rotateOut,midScale, easeMoveUp,  setTappable,fullScale, laugh,unsetTappable, rotateIn,downScale, easeMoveDown, nil]]; // 5
        
    }
    else
    {
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.scale];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];
        
        
        //POP bird
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3) ];
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0];      
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:NO];    
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ];  
        CCMoveBy *moveDown = [CCMoveBy  actionWithDuration:_moveAnim position:ccp(0, -120)];      
        
        [self.birdSprite runAction:[CCSequence actions:midScale, moveUp,easeMoveUp,setTappable, fullScale, laugh,unsetTappable,easeMoveDown, moveDown ,downScale, nil]]; 
        
    }
}
-(void)popPenguinLevelBird:(CCSprite *)bird currentLevel:(int)level
{    
      
    [self initBirds];
    
    // Create animations          
    CCAnimation *laughAnim = [self animationFromPlist:self.theGame.missPosAnim delay:_delayAnim];    //.1  
    [[CCAnimationCache sharedAnimationCache] addAnimation:laughAnim name:self.theGame.missPosAnim]; 
    
    if(_birdAngle != 0)
    {  
        CCRotateTo *rotateUP = [CCRotateTo actionWithDuration:_rotateAnim angle:self.birdAngle];
        CCEaseOut *rotateOut = [CCEaseOut actionWithAction:rotateUP  rate:3.0];
        
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.5];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];
        //POP bird
        
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3)]; // 1
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0]; // 2
        
        
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:YES];      
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ]; // 4
        
        
        CCRotateTo *rotateDown = [CCRotateTo actionWithDuration:_moveAnim angle:self.birdAngle];
        CCEaseIn *rotateIn = [CCEaseIn actionWithAction:rotateDown  rate:3.0];
        
        
        [self.birdSprite runAction:[CCSequence actions:rotateOut,midScale, easeMoveUp,  setTappable,fullScale, laugh,unsetTappable, rotateIn,downScale, easeMoveDown, nil]]; // 5
        
    }
    else
    {
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.scale];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];
        
        
        //POP bird
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3) ];
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0];      
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:NO];    
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ];  
        CCMoveBy *moveDown = [CCMoveBy  actionWithDuration:_moveAnim position:ccp(0, -120)];      
        
        [self.birdSprite runAction:[CCSequence actions:midScale, moveUp,easeMoveUp,setTappable, fullScale, laugh,unsetTappable,easeMoveDown, moveDown ,downScale, nil]]; 
        
    }
}
-(void)popDuckLevelBird:(CCSprite *)bird currentLevel:(int)level
{
      
    [self initBirds];
    
    // Create animations          
    CCAnimation *laughAnim = [self animationFromPlist:self.theGame.missPosAnim delay:_delayAnim];    //.1  
    [[CCAnimationCache sharedAnimationCache] addAnimation:laughAnim name:self.theGame.missPosAnim]; 
    
    if(_birdAngle != 0)
    {  
        CCRotateTo *rotateUP = [CCRotateTo actionWithDuration:_rotateAnim angle:self.birdAngle];
        CCEaseOut *rotateOut = [CCEaseOut actionWithAction:rotateUP  rate:3.0];
        
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.5];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.3];
        //POP bird
        
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3)]; // 1
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0]; // 2
        
        
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:YES];      
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ]; // 4
        
        
        CCRotateTo *rotateDown = [CCRotateTo actionWithDuration:_moveAnim angle:self.birdAngle];
        CCEaseIn *rotateIn = [CCEaseIn actionWithAction:rotateDown  rate:3.0];
        
        
        [self.birdSprite runAction:[CCSequence actions:rotateOut,midScale, easeMoveUp,  setTappable,fullScale, laugh,unsetTappable, rotateIn,downScale, easeMoveDown, nil]]; // 5
        
    }
    else
    {
        CCScaleTo *midScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];        
        CCScaleTo *fullScale = [CCScaleTo actionWithDuration:_scaleAnim scale:self.scale];
        CCScaleTo *downScale = [CCScaleTo actionWithDuration:_scaleAnim scale:.6];
        
        
        //POP bird
        CCMoveBy *moveUp = [CCMoveBy actionWithDuration:_moveAnim position:ccp(self.birdAngle, bird.contentSize.height/3) ];
        CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)]; 
        
        CCEaseInOut *easeMoveUp = [CCEaseInOut  actionWithAction:moveUp rate:3.0];      
        CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:NO];    
        CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];    
        CCAction *easeMoveDown = [easeMoveUp reverse ];  
        CCMoveBy *moveDown = [CCMoveBy  actionWithDuration:_moveAnim position:ccp(0, -120)];      
        
        [self.birdSprite runAction:[CCSequence actions:midScale, moveUp,easeMoveUp,setTappable, fullScale, laugh,unsetTappable,easeMoveDown, moveDown ,downScale, nil]]; 
        
    }
}

-(void)popBird:(CCSprite *) bird
{       
    switch(self.theGame.currentLevel)    
    {    
        case 1:           
            [self popVultureLevelBird:bird currentLevel:self.theGame.currentLevel];          
            break;
        case 2:
            [self popOstrichLevelBird:bird currentLevel:self.theGame.currentLevel];
            break;
        case 3:
            [self popRavenLevelBird:bird currentLevel:self.theGame.currentLevel];
            break;
        case 4:
            [self popPenguinLevelBird:bird currentLevel:self.theGame.currentLevel];
            break;
        case 5:
            [self popDuckLevelBird:bird currentLevel:self.theGame.currentLevel];
            break;
        default:
            break;       
    
    }
        
}


-(void)update
{
       // NSLog(@"bird %d : %d : %d : %d", self.birdLocation, self.birdIndexCount, self.negBirdIndexCount, self.isNegativeBird);    
    
    //todo: remove the index of currently select bird from next two random pops. 
    if (self.birdSprite != nil ) 
    {   
          [self popBird:self.birdSprite];       
        
    }         
            
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

	// don't forget to call "super dealloc"
	[_birdSprite release];
	//[_theGame release];
	//[hitAnim release];
    //[laughAnim release];
	[_currentBirds release];
	[super dealloc];
}




@end
