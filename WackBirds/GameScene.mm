//
//  GameScene.m
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 Wacky Birds. All rights reserved.
//

#import "GameScene.h"

#define STARTING_LIVES 3
#define intervalOne 1
#define intervalHalf .5

@implementation GameScene

-(void)ScoreSubmitted
{}

-(void)ScoreVailedSubmit
{}

-(void)SubmitHighScore
{
       // [OFHighScoreService setHighScore: forLeaderboard:<#(NSString *)#> onSuccess:<#(const OFDelegate &)#> onFailure:<#(const OFDelegate &)#>

}
///END OpenFeint********

- (id) initWithLevel:(int)level levelScore:(int)score {
    self = [super init];
    if (self != nil) {        
		_gameLayer = [[GameLayer alloc]initWithLevel:level levelScore:score];
        [self addChild:_gameLayer z:0 tag:KGameLayer];
		[self addChild:[HUDLayer node] z:1 tag:KHudLayer];		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
	[_gameLayer release];
}

@end


@implementation GameLayer

@synthesize bird = _bird, currentBirds = _currentBirds, currentBgs = _currentBgs, currentBirdLoc = _currentBirdLoc, background = _background;
@synthesize score = _score, currentLevel = _currentLevel, isGameOver = _isGameOver, isLevelOver = _isLevelOver, totalSpawns = _totalSpawns;
@synthesize timer = _timer;
@synthesize countBirdKills = _countBirdKills,countKillBirdTrys = _countKillBirdTrys;
@synthesize isNegativeBird=_isNegativeBird;

@synthesize posBirdsPatArray =_posBirdsPatArray,negBirdsPatArray=_negBirdsPatArray;
@synthesize countIndexBirds =_countIndexBirds, negCountIndexBirds=_negCountIndexBirds;

@synthesize negCurrentIndexBird=_negCurrentIndexBird,currentIndexBird = _currentIndexBird;

@synthesize appdelegate=_appdelegate;
@synthesize roundImage=_roundImage,roundImageDelayCount=_roundImageDelayCount;
@synthesize totalLives=_totalLives;
@synthesize hudLayer=_hudLayer;

@synthesize hitPosAnim = _hitPosAnim, missPosAnim =_missPosAnim;
@synthesize bonusCount=_bonusCount,isBonus=_isBonus;

//sound
@synthesize backgroundSound=_backgroundSound;


-(void)resetHUD
{
	HUDLayer * hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
	for(CCSprite * c in hl.lives)
	{
		[c setVisible:YES];
	}
	//self.currentLevel=0;
	[hl.level setString:@"1"];
    
	self.score=0;
	[hl.score setString:@"0"];
    
   
	for(CCSprite * c in hl.bonuses)
	{
		[c setVisible:NO];
	}
    
	//self.bombs =3;
	//[hl.bombs setString:@"X3"];
	//lives = STARTING_LIVES;
}

-(void)updateHUD:(ccTime *) dt
{
    //Get score. If score is greater than then go to levelOverScene
    
    HUDLayer * hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
    [self setCurrentLevel:self.currentLevel]; 
    //[hl.level setString:[NSString stringWithFormat:@"Level %d",self.currentLevel]];
    //End level set on HUD    
    [hl.level setString:[NSString stringWithFormat:@"Level %d",self.currentLevel]];
    
    //Set Score if you get a bird
    
    //int levelScore = [AppDelegate get].levelScore;
    
    HUDLayer* h2 = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
    [self setScore:self.score]; 
    [h2.score setString:[NSString stringWithFormat:@"Score %d",self.score]];
    
    if( self.timer >0)//todo: set for level 2 
    {
        //set for levels.. 
        
        //Set Score if you get a bird
        HUDLayer * h3 = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
        [self setTimer:self.timer-1]; 
        [h3.timer setString:[NSString stringWithFormat:@"Timer %d",self.timer]];
    }    
}

-(void)resetGameLayer
{
    [self unscheduleAllSelectors];    
    // Remove old Bird Image
    if (_bird != nil) {
        [self removeChild:_bird cleanup:YES];
        self.bird = nil;
    }
    
    // Remove old Bird Image
    if (_background != nil) {
        [self removeChild:_background cleanup:YES];
        self.background = nil;
    }
    
    // Clear out any objects
    for (CCSprite *bird in _currentBirds) {
        [self removeChild:bird cleanup:YES];
    }
    [_currentBirds removeAllObjects];  
    [_currentBgs removeAllObjects];
    
    
    if(self.currentLevel <=10)
    {
        self.totalLives=5;
    }
    else 
        if(self.currentLevel >=11 && self.currentLevel <=20)
        {
            self.totalLives=4;
        }
    else
    {
        self.totalLives=3;
    }
    
    //Todo: change based on which level. get from AppDelegate. 
    //self.timer = 30;
    //self.totalLives=3;
    //_appdelegate.timerLevelCount++;
    [self resume];
        
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

- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        return point;
    }    
}

-(void)loadLevelData:(NSString *)leveldataPath levelKey:(int)levelKey levelValue:(NSString*)levelValue CurrentIndex:(int)timerCountIndex
{       
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:leveldataPath ofType:@"plist"];        
    NSDictionary *  arr = [NSDictionary dictionaryWithContentsOfFile:plistPath];      
    NSMutableArray * level = [arr objectForKey:levelValue];
        
     _posBirdsPatArray = [[NSMutableArray alloc]initWithCapacity:[level count]];
    
    for(NSString *data in level) {
        
        [_posBirdsPatArray addObject:data];
    }      
      
    self.negCurrentIndexBird=0;
    
    if(timerCountIndex == 0)       
        //_bird.birdIndexCount= 0;
        self.currentIndexBird =0;
    
    if(timerCountIndex ==1)
        //_bird.birdIndexCount=50;
        self.currentIndexBird =50;
    
    if(timerCountIndex==2)
        //_bird.birdIndexCount=100;
        self.currentIndexBird=100;
    
    if(timerCountIndex==3)
       // _bird.birdIndexCount=150;
        self.currentIndexBird=150;
    if(timerCountIndex==4)
        //_bird.birdIndexCount=200;
        self.currentIndexBird=200;
           
  
    _countIndexBirds = [_posBirdsPatArray count];    
}

-(void)loadLevelDataNegative:(NSString *)leveldataPath levelKey:(int)levelKey levelValue:(NSString*)levelValue CurrentIndex:(int)timerCountIndex
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:leveldataPath ofType:@"plist"];        
    NSDictionary *  arr = [NSDictionary dictionaryWithContentsOfFile:plistPath];      
    NSMutableArray * level = [arr objectForKey:levelValue];
    
    _negBirdsPatArray = [[NSMutableArray alloc]initWithCapacity:[level count]];
    
    for(NSString *data in level) {
        
        [_negBirdsPatArray addObject:data];
    }    

    _negCountIndexBirds = [_negBirdsPatArray count];   
    
}

-(id)initWithLevel:(int)level levelScore:(int)score
{   self = [super init];
    if( (self=[super init] )) {

        self.currentLevel = level;
        self.score = score;
        
        [self resetHUD];
        [self resetGameLayer];                   
        [self SetAudioForLevel];
        
        [self resetRound];//:level levelScore:score];
                
        //might not be needed.
        //self.isAccelerometerEnabled = YES;
		self.isTouchEnabled = YES;
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
        //////////////
                
         
            _background = [[Background alloc] initWithGame:self]; 
                 
        if(self.currentLevel == 2)
        {      
            //todo: Setup smoke
            //volSmoke is simple smoke that comes from volcano constantly. 
            //volExplode
            
           // smoke = [CCParticleSystemPoint particleWithFile:@"crap.plist"]; 
           // [self addChild:smoke z:9];
           // [smoke setPosition:ccp(110,400)];
            //[smoke setPosition:ccp(110,400)];
            //[smoke stopSystem];
           
        }
      
        int speedInterval = [self GetIntervalBirdSpeed:self.currentLevel];
        [self schedule:@selector(updateHUD:) interval:.80];
    
        [self schedule:@selector(tryPopBirds:) interval:speedInterval];
    }
    return self;
}

-(int)GetIntervalBirdSpeed:(int)level
{
    int speed = 1.0;

    if(level >0 && level <=5)
    {
        speed=1.0;
    
    }else if(level >=6 && level <=10)
    {
        speed=.9;
    }else if(level>=11 && level <= 20)
    {
        speed=.8;
    
    }else if(level >=21 && level <=25)
    {
        speed=.7;
    }
    
    return speed;
}

//initialize speed of birds

//set what the values are for the round speed for animation of birds. 
-(void)initBirdAnimation:(float)rotate move:(float)move scale:(float)scale delay:(float)delay
{
   _bird.rotateAnim = rotate;
    _bird.moveAnim=move;
    _bird.scaleAnim=scale;
    _bird.delayAnim=delay;
}
//
//Sets the speed of the birds animation for the level
//
-(void)initRoundAnimationSpeed
{
    int level = self.currentLevel;
    
    if(level >0 && level <=5)
    {
        [self initBirdAnimation:.1 move:.2 scale:.1 delay:.05];        
    }
    if(level >=6 && level <=10)
    {
        [self initBirdAnimation:.08 move:.15 scale:.08 delay:.05];
        
    }
    if(level >=11 && level <=15)
    {
        [self initBirdAnimation:.05 move:.1 scale:.05 delay:.04];
        
    }
    if(level >=16 && level <=20)
    {
        [self initBirdAnimation:.05 move:.1 scale:.05 delay:.04];
        
    }
    
    if(level >=21 && level <=25)
    {
        [self initBirdAnimation:.05 move:.05 scale:.03 delay:.03];
        
    }   
}

-(void)tryPopBirds:(ccTime*)dt
{
     [AppDelegate get].levelScore = self.score;
    
    //this is used to slow the round image down for 1 cycle. 
    if(_roundImageDelayCount==1)
    {
        _roundImageDelayCount++;
    }
    
    //***IF THE TIMER RUNS OUT ***** A HIGH NUMBER OF SPAWNS 
    if(self.timer <= 0 || totalSpawns >250)
    {     
        
        [AppDelegate get].levelScore = _score;       
        int round = [AppDelegate get].timerLevelCount;
        
        if( round <5)
        {
            [self onExit];
            [self resetRound];
        }
        else 
        {  
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            [delegate loadWinScene];            
        }     
    }  
    else
    {
        if((self.currentIndexBird <= _countIndexBirds || self.negCurrentIndexBird <= _negCountIndexBirds) && _roundImageDelayCount == 2)
        {       
                        
            //positive bird
            NSString *element = [_posBirdsPatArray objectAtIndex:self.currentIndexBird];        
            double myDouble = [element doubleValue];
            int birdValue = ((int)myDouble + (myDouble>0 ? 0.5 : -0.5));
            
            //removes the Round+n image that displays after each round
            if(self.currentIndexBird == 0 || _currentIndexBird == 50 || self.currentIndexBird ==100 || self.currentIndexBird == 150 || _currentIndexBird == 200)
                [self removeChild:roundImage cleanup:YES];
            
            //Positive bird - increases the index location that will be next time the bird pops. 
            self.currentIndexBird++;
            
            if(birdValue == 99)
            {
                //negative bird 
                NSString *element = [_negBirdsPatArray objectAtIndex:self.negCurrentIndexBird];
                double negBirdLoc = [element doubleValue];                
                self.negCurrentIndexBird++;
                
                //sets where the bird location will be from the value 
                _bird.birdLocation = (int)negBirdLoc+ (negBirdLoc>0 ? 0.5 : -0.5);                
                self.isNegativeBird =true;
                [_bird update];                

            }
            if(birdValue != 99)
            {                      
                _bird.birdLocation =   (int)myDouble + (myDouble>0 ? 0.5 : -0.5);
                //the bird is not negative 
                self.isNegativeBird =false;
                [_bird update];                
            }
            if((self.bonusCount == 6 || self.bonusCount == 11) && self.isBonus == true)
            {          
                [[SimpleAudioEngine sharedEngine] playEffect:_bonusSound]; 
                
                HUDLayer* hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
                CCSprite * bonus = [hl.bonuses objectAtIndex:0];
                [bonus setVisible:NO]; 
           
            }
        }
    }
}

-(void)SetAudioForLevel
{
   
    //popout location
    int sound = arc4random() %2 +     1;     
        sound=1;
        
        switch (sound) {
            case 1:
                //Audio Sound Variables
                 _hitPosSound=@"bpopSound.caf";
                 _hitNegSound=@"bcoohSound.caf";
                
               _missPosSound=@"laugh.caf";
                //_missNegSound;
                
               _bonusSound =@"bongoSounds.caf";
               /* if (self.currentLevel == 1 || self.currentLevel == 3 || self.currentLevel == 6 || self.currentLevel==8 
                    || self.currentLevel == 11 || self.currentLevel == 13 || self.currentLevel == 16 || self.currentLevel==18 
                    ||self.currentLevel == 21 || self.currentLevel == 23) 
                {
                                  
                }*/
                NSLog(@"%d", self.currentLevel);
                
                if(self.currentLevel ==1)
                {
                _backgroundSound= @"backgroundBirds.caf";  
                }
                else{           
                    _backgroundSound=@"backgroundWaterBirds.caf";
                }
                
                break;
            case 2:
                break;
            case 3:
                break;
            default:
                break;
        }
        
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:_backgroundSound loop:YES];    
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:.1];

        [[SimpleAudioEngine sharedEngine] preloadEffect:_bonusSound];
        [[SimpleAudioEngine sharedEngine] preloadEffect:_hitNegSound];//@"bcoohSound.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:_hitPosSound];//@"bpopSound.caf"]; 
        [[SimpleAudioEngine sharedEngine] preloadEffect:_missPosSound];//@"bpopSound.caf"]; 
       
}

/* NOTICE - This code needs to be redone using a reusable helper.. */

-(void)resetRound//:(int)level levelScore:(int)score
    {
        NSString *menuPlist = @"menu.plist";
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:menuPlist];
    //CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.jpg"];    
    //float allscale = [AppDelegate get].allScale;    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int timerIndexCount = [AppDelegate get].timerLevelCount;
    switch (timerIndexCount) {
        case 0:           
            
            roundImage = [CCSprite spriteWithSpriteFrameName:@"Round1.png"];
            //[vLayer1.texture setAliasTexParameters];
            roundImage.scale = 2.0;
            roundImage.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            //vLayer1.scale = self.scale;
            [self addChild:roundImage z:50];            
            
            break;
        case 1:            
            roundImage = [CCSprite spriteWithSpriteFrameName:@"Round2.png"];
            //[vLayer1.texture setAliasTexParameters];
            roundImage.scale = 2.0;
            roundImage.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            //vLayer1.scale = self.scale;
            [self addChild:roundImage z:100];
            break;
        case 2:            
            roundImage = [CCSprite spriteWithSpriteFrameName:@"Round3.png"];
            //[vLayer1.texture setAliasTexParameters];
            roundImage.scale = 2.0;
            roundImage.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            //vLayer1.scale = self.scale;
            [self addChild:roundImage z:50];
            break;
        case 3:            
            roundImage = [CCSprite spriteWithSpriteFrameName:@"Round4.png"];
            //[vLayer1.texture setAliasTexParameters];
            roundImage.scale = 2.0;
            roundImage.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            //vLayer1.scale = self.scale;
            [self addChild:roundImage z:50];
            break;
        case 4:   
            
            roundImage = [CCSprite spriteWithSpriteFrameName:@"Round5.png"];
            //[vLayer1.texture setAliasTexParameters];
            roundImage.scale = 2.0;
            roundImage.position = [self convertPoint:ccp(winSize.width/2,winSize.height/2)];
            //vLayer1.scale = self.scale;
            [self addChild:roundImage z:50];
            
            break;
            
        default:
            break;
    }
        _roundImageDelayCount = 1;
 
    //
    // Clear out any objects
    //
 
    if (_hitPosAnim != nil) {        
    self.hitPosAnim = nil;
    }if (_missPosAnim != nil) {        
        self.missPosAnim = nil;
    }
    
    if(_isNegativeBird !=nil)
    {self.isNegativeBird =nil;}
    
    if(_bird.isNegativeBird !=nil)
    {_bird.isNegativeBird =nil;}
    //////////    
    
    if (_bird != nil) {
        [self removeChild:_bird cleanup:YES];
        self.bird = nil;
    }
    
    for (CCSprite *bird in _currentBirds) {
        [self removeChild:bird cleanup:YES];
    }
    [_currentBirds removeAllObjects];
    
    for (CCSprite *bird in _negBirdsPatArray) {
        [self removeChild:bird cleanup:YES];
    }
    [_negBirdsPatArray removeAllObjects];
    for (CCSprite *bird in _posBirdsPatArray) {
        [self removeChild:bird cleanup:YES];
    }
    [_posBirdsPatArray removeAllObjects];
    
   
    // 
    //Add the objects
    //
    _currentBirds = [[NSMutableArray alloc]initWithCapacity:0];
    _posBirdsPatArray = [[NSMutableArray alloc]initWithCapacity:0];
    _negBirdsPatArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _bird = [[Bird alloc] initWithGame:self];
    //[_currentBirds addObject:_bird];
    ////////////////
     
    //
    //Helper Methods
    //
    
    [self initRoundAnimationSpeed];    
    
    if(self.currentLevel == 1) 
    {                  
        [self loadLevelData:@"leveldata"  levelKey:1 levelValue:@"vulture" CurrentIndex:timerIndexCount];
        [self loadLevelDataNegative:@"leveldata"  levelKey:1 levelValue:@"snake" CurrentIndex:timerIndexCount];                      
    }
    if(self.currentLevel == 2)
    {
        [self loadLevelData:@"leveldata"  levelKey:2 levelValue:@"ostrich" CurrentIndex:timerIndexCount];
        [self loadLevelDataNegative:@"leveldata"  levelKey:2 levelValue:@"mongoose" CurrentIndex:timerIndexCount];
        
    }
    if(self.currentLevel == 3)
    {
        [self loadLevelData:@"leveldata"  levelKey:3 levelValue:@"raven" CurrentIndex:timerIndexCount];
        [self loadLevelDataNegative:@"leveldata"  levelKey:1 levelValue:@"bat" CurrentIndex:timerIndexCount];
    }
    if(self.currentLevel == 4)
    {
        [self loadLevelData:@"leveldata"  levelKey:4 levelValue:@"penguin" CurrentIndex:timerIndexCount];
        [self loadLevelDataNegative:@"leveldata"  levelKey:1 levelValue:@"polarbear" CurrentIndex:timerIndexCount];
    }
    if(self.currentLevel == 5)
    {
        [self loadLevelData:@"leveldata"  levelKey:5 levelValue:@"duck" CurrentIndex:timerIndexCount];
        [self loadLevelDataNegative:@"leveldata"  levelKey:1 levelValue:@"gator" CurrentIndex:timerIndexCount];
    }  
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate increaseTimerLevelCount];
   
    self.timer = 15;
    self.bonusCount = 0;
    self.isBonus = false;
    [self resume];
        
 //[NSThread sleepForTimeInterval:1.0f];
}

////Helper Methods//////
-(void)pauseGame
{    
	ccColor4B c = {100,100,0,100};
    
	PauseLayer * p = [[[PauseLayer alloc]initWithColor:c]autorelease];
	[self.parent addChild:p z:99];
	[self onExit];
}

- (void) onExit
{
	if(![AppDelegate get].paused)
	{           
		[AppDelegate get].paused = YES;
        //[self stopAllActions];
       //[self unscheduleAllSelectors];        
		[super onExit];
	}
}

- (void) resume
{
	if(![AppDelegate get].paused)
	{
		return;
	}
	[AppDelegate get].paused =NO;
	[self onEnter];
}

- (void) onEnter
{
	if(![AppDelegate get].paused )
	{
        [AppDelegate get].paused = NO;
		[super onEnter];
	}
}

//////Touch methods//////////

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:NO];//thegame was self
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{ 
    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
        
    for (CCSprite *bird in _currentBirds) 
    {          
        if (bird.userData == FALSE) continue;
        
        if (CGRectContainsPoint(bird.boundingBox, touchLocation)) 
        {   
          //  [[SimpleAudioEngine sharedEngine] playEffect:@"bcooh.caf"];
                        
            CCAnimation *hitAnima = [self animationFromPlist:self.hitPosAnim delay:0.05];
            [[CCAnimationCache sharedAnimationCache] addAnimation:hitAnima name:self.hitPosAnim];            
            [bird stopAllActions];
            CCAnimate *hit = [CCAnimate actionWithAnimation:hitAnima restoreOriginalFrame:NO];
            CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.1 position:ccp(0, -bird.contentSize.height)];
            CCEaseInOut *easeMoveDown = [CCEaseInOut actionWithAction:moveDown rate:3.0];
            
            [bird runAction:[CCSequence actions: hit, easeMoveDown, nil]];
               
                      
            //Negative bird
            if(self.isNegativeBird == true)
            {           
                [[SimpleAudioEngine sharedEngine] playEffect:_hitNegSound];//@"bcoohSound.caf"];
                //Need to reset the bonusCounter
                self.bonusCount = 0;                
                
                HUDLayer* hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
                [self setScore:self.score-10]; 
                [hl.score setString:[NSString stringWithFormat:@"Score %d",_score]];
                [AppDelegate get].levelScore = self.score;                
                //removes the eggs. 
                self.totalLives--;
                                
                //if the user has hit the negative animal more than allow times. 
                if(self.totalLives==0)
                {                                      
                    [AppDelegate get].levelFailed = true;
                    [AppDelegate get].levelScore = self.score;
                    
                    //need to restart level
                    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                    [delegate loadWinScene];
                }
                else
                {
                    CCSprite * live = [hl.lives objectAtIndex:self.totalLives];
                    [live setVisible:NO];   
                }                        
            }            
            
            //positive bird     
            if(self.isNegativeBird == false)
            { 
                [[SimpleAudioEngine sharedEngine] playEffect:_hitPosSound];//@"bpopSound.caf"];
                            
                    //Set Score if you get a bird
                    HUDLayer* hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
                             
                //Set the Bonus score item to visible. 
                self.bonusCount++;
                
                //The score goes to 10 because of getting 5 in a row or 10 in a row. 
                if(self.bonusCount== 5)
                {
                    self.isBonus=true;
                    [self setScore:self.score+10]; 
                    [hl.score setString:[NSString stringWithFormat:@"Score %d",self.score]];  

                    CCSprite * bonus = [hl.bonuses objectAtIndex:0];
                    [bonus setVisible:YES];             
                    
                }
                else
                {
                    [self setScore:self.score+5]; 
                    [hl.score setString:[NSString stringWithFormat:@"Score %d",self.score]];
                
                }
                if(self.bonusCount == 15)
                {
                    self.isBonus=true;
                 
                    [self setScore:self.score+15]; 
                    [hl.score setString:[NSString stringWithFormat:@"Score %d",self.score]];  

                    CCSprite * bonus = [hl.bonuses objectAtIndex:0];
                    [bonus setVisible:YES];   
                }
                else
                {
                    [self setScore:self.score+5]; 
                    [hl.score setString:[NSString stringWithFormat:@"Score %d",self.score]];
                }
                
                 [AppDelegate get].levelScore = self.score; 
                                              
            }                  
            
            bird.userData = FALSE;   
        }
        else
        {
                 
        }          
    }     
    return TRUE;
}
//is called at top of bird animation to set where you can hit bird or not. 
- (void)setTappable:(id)sender {
    CCSprite *bird = (CCSprite *)sender;
   // [bird setUserData:TRUE];      
    [[SimpleAudioEngine sharedEngine] playEffect:_missPosSound];//@"laugh.caf"];
}

- (void)unsetTappable:(id)sender {
    CCSprite *bird = (CCSprite *)sender;
    [bird setUserData:FALSE];        
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[_bird release];
	[_background release];
	[_currentBgs release];
	[_currentBirds release];
	[super dealloc];
}

@end
