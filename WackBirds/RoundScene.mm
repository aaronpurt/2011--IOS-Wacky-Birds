//
//  GameScene.m
//  Whack-em
//
//  Created by AARON on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RoundScene.h"

//#import "OFLeaderboardService.h"
//#import "OFAchievement.h"
//#import "OFAchievementService.h"
//#import "OFHighScoreService.h"
//#import "OpenFeint.h"

#define STARTING_LIVES 3
#define intervalOne 1
#define intervalHalf .5


@implementation RoundScene


///OpenFeint********


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
		_gameLayer = [[RoundLayer alloc]initWithLevel:level levelScore:score];
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

@synthesize hitAnim = _hitAnim, missAnim =_missAnim;

@synthesize posBirdsPatArray =_posBirdsPatArray,negBirdsPatArray=_negBirdsPatArray;
@synthesize countIndexBirds =_countIndexBirds, negCountIndexBirds=_negCountIndexBirds;
@synthesize negCurrentIndexBird=_negCurrentIndexBird,currentIndexBird = _currentIndexBird;

//test for appdelegate
@synthesize appdelegate=_appdelegate;
//@synthesize timerCountIndex=_timerCountIndex;



-(void)resetHUD
{
	HUDLayer * hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
	//for(CCSprite * c in hl.lives)
	//{
	//	[c setVisible:YES];
	//}
	self.currentLevel=0;
	[hl.level setString:@"Level 1"];
    
	self.score=0;
	[hl.score setString:@"Score 0"];
    
    
	//self.bombs =3;
	//[hl.bombs setString:@"X3"];
	//lives = STARTING_LIVES;
}

-(void)updateHUD:(ccTime *) dt
{
    //Get score. If score is greater than then go to levelOverScene
    
    HUDLayer * hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
    [self setCurrentLevel:self.currentLevel]; 
    [hl.level setString:[NSString stringWithFormat:@"Level %d",self.currentLevel]];
    //End level set on HUD    
    
    //Set Score if you get a bird
    
    int levelScore = [AppDelegate get].levelScore;
    
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
    
   
    //Todo: change based on which level. get from AppDelegate. 
    self.timer = 15;
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
       
    if(timerCountIndex == 0)       
        _bird.birdIndexCount= 0;
    if(timerCountIndex ==1)
        _bird.birdIndexCount=50;
    if(timerCountIndex==2)
        _bird.birdIndexCount=100;
    if(timerCountIndex==3)
        _bird.birdIndexCount=150;
    if(timerCountIndex==4)
        _bird.birdIndexCount=200;
           
  
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
    
        [self resetGameLayer];                   
                
        self.currentLevel = level;
        self.score = score;
        
         int timerIndexCount = [AppDelegate get].timerLevelCount;
              
                
        //might not be needed.
        //self.isAccelerometerEnabled = YES;
		self.isTouchEnabled = YES;
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
        //////////////
                
         
            _background = [[Background alloc] initWithGame:self]; 
           _currentBirds = [[NSMutableArray alloc]initWithCapacity:1];
 
        
        _bird = [[Bird alloc] initWithGame:self];
        [_currentBirds addObject:_bird];
        //[_bird release];
       
        if(self.currentLevel == 2)
        {            
            //volSmoke is simple smoke that comes from volcano constantly. 
            //volExplode
            
           // smoke = [CCParticleSystemPoint particleWithFile:@"crap.plist"]; 
           // [self addChild:smoke z:9];
           // [smoke setPosition:ccp(110,400)];
            //[smoke setPosition:ccp(110,400)];
            //[smoke stopSystem];
           
        }
        
        
        
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
              
       // [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"whack.caf" loop:YES];
        
        [self schedule:@selector(updateBird:) interval:.5];
        if(timerIndexCount >= 0)        
            [self schedule:@selector(tryPopBirds:) interval:.9];
        if(timerIndexCount >= 1)        
            [self schedule:@selector(tryPopBirds:) interval:.8];
        [self schedule:@selector(updateHUD:) interval:.5];
        
        
    }
    return self;
}


-(void)tryPopBirds:(ccTime*)dt
{
      
       if(self.currentIndexBird <= _countIndexBirds || self.negCurrentIndexBird <= _negCountIndexBirds)
       {          
                     
           NSString *element = [_posBirdsPatArray objectAtIndex:self.currentIndexBird];        
           double myDouble = [element doubleValue];
           int test = ((int)myDouble + (myDouble>0 ? 0.5 : -0.5));
                           
           if(test == 99)
           {
               NSString *element = [_negBirdsPatArray objectAtIndex:self.negCurrentIndexBird];
               double negBirdLoc = [element doubleValue];
               _bird.birdIndexCount++; 
               _bird.negBirdIndexCount++;
               _bird.birdLocation = (int)negBirdLoc+ (negBirdLoc>0 ? 0.5 : -0.5);
               _bird.isNegativeBird = true;
               //NSLog(@"Game %d : %d : %d : %d", _bird.birdLocation, _bird.birdIndexCount, _bird.negBirdIndexCount, _bird.isNegativeBird);
              
             
               [_bird update];
           
           }else
           {                              
               _bird.birdIndexCount++;               
               _bird.birdLocation =   (int)myDouble + (myDouble>0 ? 0.5 : -0.5);
               _bird.isNegativeBird = false;
              [_bird update];
           }
       } 
}


-(void)updateBird:(ccTime *) dt
{
   //Get score. If score is greater than then go to levelOverScene
    if(isLevelOver) return;    
    
    //***IF THE TIMER RUNS OUT ***** A HIGH NUMBER OF SPAWNS 
    if(self.timer <= 0 || totalSpawns >250)
    {     
        
        [AppDelegate get].levelScore = _score;       
        int round = [AppDelegate get].timerLevelCount;
        
           if( round <6)
           {
               //
               
               AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
               [delegate nextRound];
           }
        else 
            {
        
            //[self onExit];
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            [delegate loadWinScene];
        
            }
        
       // LoseLevelScene * gs = [LoseLevelScene node];
       // [[CCDirector sharedDirector]replaceScene:gs];        
    }    
        
       
       
        
        if(!self.currentLevel == 0)
        {
                      
            if(self.score <= 30 )
            { 
                //test
                self.totalSpawns++;
            }
            else
            {
                
                //bring up quick opaiq screen get that from a method. 
                //Set the new index location to start at. 
                //pause animations for 2 seconds. and restart them
                
               
                
                
                [AppDelegate get].levelScore = self.score;
            
                float decimalPercentage = 0;
                if(self.countBirdKills >= 0 && self.countKillBirdTrys >= 0)
                {                               
                    decimalPercentage = self.countBirdKills * 100;                
                    decimalPercentage = decimalPercentage / self.totalSpawns;            
                    [AppDelegate get].percentageHit  = decimalPercentage;                
                }
                else
                {                    
                    [AppDelegate get].percentageHit  = -1;
                }
                            
            }  
        }
       
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
        //[AppDelegate get].paused = NO;
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
    
    
    
     //NSLog(@"touched Bird"); 
    
    for (CCSprite *bird in _currentBirds) 
    {              
        
        if (bird.userData == FALSE) continue;
        
        if (CGRectContainsPoint(bird.boundingBox, touchLocation)) 
        {            
            [[SimpleAudioEngine sharedEngine] playEffect:@"ow.caf"];
            
            if(self.isNegativeBird == true || _bird.isNegativeBird == true)
            {
                               
                _countBirdKills = _countBirdKills - 1;
                
                
                
                HUDLayer* hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
                [self setScore:self.score-10]; 
                [hl.score setString:[NSString stringWithFormat:@"Score %d",_score]];
                [AppDelegate get].levelScore = self.score;
            }
            //else                
            if(self.isNegativeBird == false || _bird.isNegativeBird == false)
            { //Set Score if you get a bird
                HUDLayer* hl = (HUDLayer *)[self.parent getChildByTag:KHudLayer];
                [self setScore:self.score+5]; 
                [hl.score setString:[NSString stringWithFormat:@"Score %d",self.score]];  
                
                [AppDelegate get].levelScore = self.score;
                //increase kills
                 _countBirdKills = _countBirdKills+1;
               
            }                  
            
            bird.userData = FALSE;   
                     
            NSLog(@"self.hitAnim  %@ _hitAnim is: %@ ", self.hitAnim, _hitAnim);
            
            
            CCAnimation *hitAnima = [self animationFromPlist:self.hitAnim delay:0.05];
            [[CCAnimationCache sharedAnimationCache] addAnimation:hitAnima name:self.hitAnim];            
            [bird stopAllActions];
            CCAnimate *hit = [CCAnimate actionWithAnimation:hitAnima restoreOriginalFrame:NO];
            CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.1 position:ccp(0, -bird.contentSize.height)];
            CCEaseInOut *easeMoveDown = [CCEaseInOut actionWithAction:moveDown rate:3.0];
            
            [bird runAction:[CCSequence actions: hit, easeMoveDown, nil]];  
            
            
            
        }
        else
        {
            _countKillBirdTrys = _countKillBirdTrys+1;        
        }        
    }     
    return TRUE;
}

- (void)setTappable:(id)sender {
    CCSprite *bird = (CCSprite *)sender;
    //[bird setUserData:TRUE];      
    [[SimpleAudioEngine sharedEngine] playEffect:@"laugh.caf"];
}

- (void)unsetTappable:(id)sender {
    CCSprite *bird = (CCSprite *)sender;
    [bird setUserData:FALSE];        
}


///////Set Rectangle shape around bird////////////////
-(CGRect)myRect:(CCSprite *)sp
{
	CGRect rect = CGRectMake(sp.position.x-sp.textureRect.size.width/2,sp.position.y-sp.textureRect.size.height/2,sp.textureRect.size.width,sp.textureRect.size.height);
	return rect;
}
//////////////////

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[_bird release];
	[_background release];
	//[_currentBgs release];
	[_currentBirds release];
	[super dealloc];
}

@end
