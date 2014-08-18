//
//  AppDelegate.m
//  wackybirds
//
//  Created by AARON on 7/9/11.
//  Copyright Wacky Birds 2011. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "LoadSplashScene.h"


@implementation AppDelegate

@synthesize window,paused;
@synthesize currentLevelIndex = _curLevelIndex;
@synthesize gameScene = _gameScene;
@synthesize levelScore=_levelScore,percentageHit;
@synthesize allScale = _allScale;
@synthesize levelOverScene = _levelOverScene;
//test
@synthesize levelCount = _levelCount;
@synthesize gameOverScene = _gameOverScene;
@synthesize levels = _levels;
@synthesize timerLevelCount=_timerLevelCount;
@synthesize loadingRound=_loadingRound;
@synthesize levelFullScore=_levelFullScore;

@synthesize highLevelScore=_highLevelScore;
@synthesize levelFailed=_levelFailed;


- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
    {
		CCLOG(@"Retina Display Not supported");
        _allScale = 1.0;
        
    }
    else
    {
        CCLOG(@"Retina Display is supported");
        _allScale = 2.0;
        
    }	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	//[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	//[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// Removes the startup flicker
	[self removeStartupFlicker];
    
    //Aaron- Load Levels into array
    self.levels = [[[NSMutableArray alloc] init] autorelease];
    
    
    GameScene *level1 = [[[GameScene alloc] initWithLevel:1 levelScore:self.levelScore]autorelease]; 
    //GameScene *level2 = [[[GameScene alloc] initWithLevel:2] autorelease];
   // GameScene *level3 = [[[GameScene alloc] initWithLevel:3] autorelease];
    //GameScene *level4 = [[[GameScene alloc] initWithLevel:4] autorelease];
   // GameScene *level5 = [[[GameScene alloc] initWithLevel:5] autorelease];    
    
    [_levels addObject:level1];  
   // [_levels addObject:level2];  
   // [_levels addObject:level3];  
    //[_levels addObject:level4];  
   // [_levels addObject:level5]; 
    
    self.levelOverScene = [LevelOverScene node];
       
    
    self.currentLevelIndex = 1;

    
	//[self InitOFdata];
    self.timerLevelCount = 0;
    
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [LoadSplashScene node]];
    
}
/////Launch OF /////

-(void)InitOFdata
{
    [[CCDirector sharedDirector] pause];
    [[CCDirector sharedDirector] stopAnimation];
     
}

////End of Launch OF//////

/////Helper Methods//////////////////////////

- (void)nextLevel:(int)level
{   //Will determine if the level index is at end of array count. 
    if(self.currentLevelIndex >= [_levels count])
    {
        self.currentLevelIndex = 0;
        self.gameOverScene = [GameOverScene node];           
        [[CCDirector sharedDirector]replaceScene:_gameOverScene];
    }
    else
    {
        //self.levelScore =0;
        self.currentLevelIndex= self.currentLevelIndex + 1;
        self.gameScene = [GameScene node];   
        self.gameScene = [[GameScene alloc]initWithLevel:self.currentLevelIndex levelScore:self.levelScore];              
        [[CCDirector sharedDirector]replaceScene:_gameScene];   
    }    
}

-(void)increaseTimerLevelCount
{
self.timerLevelCount++;
}

-(void)nextRound
{
   // NSLog(@"round currentLevelIndex: %d currentLevelIndex ", self.currentLevelIndex );
    self.timerLevelCount++;
    
    LoadingRound * gs = [LoadingRound node];
    [[CCDirector sharedDirector]replaceScene:gs];
        
}

-(void)loadLoadingScene
{
    //todo: need to get the current level variable to get correct loading. 
    //using 
    MenuScene * gs = [MenuScene node];    
	[[CCDirector sharedDirector]replaceScene:gs];  
    
}

-(void)saveScoreForLevel:(int)score currentLevel:(int)level//(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(level ==1)
    {
		[usrDef setInteger:score forKey:@"1score"];
        [usrDef setBool:true forKey:@"2ready"]; 
        //once saved need to assign to the high score variable..
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"1score"];
    }     
    if(level ==2)
    {
		[usrDef setInteger:score forKey:@"2score"];
        [usrDef setBool:true forKey:@"3ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"2score"];
    }    
    if(level ==3)
    {
		[usrDef setInteger:score forKey:@"3score"];
        [usrDef setBool:true forKey:@"4ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"3score"];
    }
    if(level ==4)
    {
		[usrDef setInteger:score forKey:@"4score"];
        [usrDef setBool:true forKey:@"5ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"4score"];
    }
    if(level ==5)
    {
		[usrDef setInteger:score forKey:@"5score"];
        [usrDef setBool:true forKey:@"6ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"5score"];
    }
    if(level ==6)
    {
		[usrDef setInteger:score forKey:@"6score"];
        [usrDef setBool:true forKey:@"7ready"]; 
        //once saved need to assign to the high score variable..
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"6score"];
    }     
    if(level ==7)
    {
		[usrDef setInteger:score forKey:@"7score"];
        [usrDef setBool:true forKey:@"8ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"7score"];
    }    
    if(level ==8)
    {
		[usrDef setInteger:score forKey:@"8score"];
        [usrDef setBool:true forKey:@"9ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"8score"];
    }
    if(level ==9)
    {
		[usrDef setInteger:score forKey:@"9score"];
        [usrDef setBool:true forKey:@"10ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"9score"];
    }
    if(level ==10)
    {
		[usrDef setInteger:score forKey:@"10score"];
        [usrDef setBool:true forKey:@"11ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"10score"];
    }
    if(level ==11)
    {
		[usrDef setInteger:score forKey:@"11score"];
        [usrDef setBool:true forKey:@"12ready"]; 
        //once saved need to assign to the high score variable..
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"11score"];
    }     
    if(level ==12)
    {
		[usrDef setInteger:score forKey:@"12score"];
        [usrDef setBool:true forKey:@"13ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"12score"];
    }    
    if(level ==13)
    {
		[usrDef setInteger:score forKey:@"13score"];
        [usrDef setBool:true forKey:@"14ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"13score"];
    }
    if(level ==14)
    {
		[usrDef setInteger:score forKey:@"14score"];
        [usrDef setBool:true forKey:@"15ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"14score"];
    }
    if(level ==15)
    {
		[usrDef setInteger:score forKey:@"15score"];
        [usrDef setBool:true forKey:@"16ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"15score"];
    }
    if(level ==16)
    {
		[usrDef setInteger:score forKey:@"16score"];
        [usrDef setBool:true forKey:@"17ready"]; 
        //once saved need to assign to the high score variable..
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"16score"];
    }     
    if(level ==17)
    {
		[usrDef setInteger:score forKey:@"17score"];
        [usrDef setBool:true forKey:@"18ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"17score"];
    }    
    if(level ==18)
    {
		[usrDef setInteger:score forKey:@"18score"];
        [usrDef setBool:true forKey:@"19ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"18score"];
    }
    if(level ==19)
    {
		[usrDef setInteger:score forKey:@"19score"];
        [usrDef setBool:true forKey:@"20ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"19score"];
    }
    if(level ==20)
    {
		[usrDef setInteger:score forKey:@"20score"];
        [usrDef setBool:true forKey:@"21ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"20score"];
    }
    if(level ==21)
    {
		[usrDef setInteger:score forKey:@"21score"];
        [usrDef setBool:true forKey:@"22ready"]; 
        //once saved need to assign to the high score variable..
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"21score"];
    }     
    if(level ==22)
    {
		[usrDef setInteger:score forKey:@"22score"];
        [usrDef setBool:true forKey:@"23ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"22score"];
    }    
    if(level ==23)
    {
		[usrDef setInteger:score forKey:@"23score"];
        [usrDef setBool:true forKey:@"24ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"23score"];
    }
    if(level ==24)
    {
		[usrDef setInteger:score forKey:@"24score"];
        [usrDef setBool:true forKey:@"25ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"24score"];
    }
    if(level ==25)
    {
		[usrDef setInteger:score forKey:@"25score"];
        //[usrDef setBool:true forKey:@"6ready"];
        self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"25score"];
    }   
}

-(void)getHighScoreForLevel:(int)level//(CCMenuItemToggle *)sender
{	
	if(level ==1)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"1score"];         
    }    
    if(level ==2)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"2score"];
    }    
    if(level ==3)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"3score"];
    }
    if(level ==4)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"4score"];		
    }
    if(level ==5)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"5score"];		
    }
    if(level ==6)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"6score"];         
    }    
    if(level ==7)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"7score"];
    }    
    if(level ==8)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"8score"];
    }
    if(level ==9)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"9score"];		
    }
    if(level ==10)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"10score"];		
    }
    
    if(level ==11)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"11score"];         
    }    
    if(level ==12)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"12score"];
    }    
    if(level ==13)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"13score"];
    }
    if(level ==14)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"14score"];		
    }
    if(level ==15)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"15score"];		
    }
    if(level ==16)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"16score"];         
    }    
    if(level ==17)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"17score"];
    }    
    if(level ==18)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"18score"];
    }
    if(level ==19)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"19score"];		
    }
    if(level ==20)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"20score"];		
    }
    if(level ==21)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"21score"];         
    }    
    if(level ==22)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"22score"];
    }    
    if(level ==23)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"23score"];
    }
    if(level ==24)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"24score"];		
    }
    if(level ==25)
    {self.highLevelScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"25score"];		
    }
}

-(void)restartLevel:(int)level 
{
    self.timerLevelCount++;
    
    GameScene * gs = [[GameScene alloc]initWithLevel:level levelScore:0];
    [[CCDirector sharedDirector]replaceScene:gs];
    
}

- (void)loadWinScene 
{
    
    NSString *menuPlist = @"menu.plist";
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:menuPlist];
       
    //Get the high score  -- saves to self.highschore
    [self getHighScoreForLevel:self.currentLevelIndex];
     
    //NOTES: I'll need to instanciate levelover and go into it and set i think 
    
    int levelScore = self.levelScore;
    //int total = percentageHit;
    int OldhighScore = self.highLevelScore;
    
    if(OldhighScore < levelScore && self.levelFailed != true)
    {
        [self saveScoreForLevel:levelScore currentLevel:self.currentLevelIndex];
    }    
       
     [_levelOverScene.layer.highScore setString:[NSString stringWithFormat:@"%d",self.highLevelScore]];
     [_levelOverScene.layer.scoreLbl setString:[NSString stringWithFormat:@"%d",self.levelScore]];
                 
    //egg for the top of the win/lose menu
    [_levelOverScene.layer.LevelOverNumber initWithSpriteFrameName:[NSString stringWithFormat:@"EggL%d.png",self.currentLevelIndex]];
    [_levelOverScene.layer.LevelOverNumber  setPosition:ccp(160,400)];    
        
     //sets the images
    [_levelOverScene.layer.menuBackground initWithSpriteFrameName:@"MenuBackground.png"];
    [_levelOverScene.layer.menuBackground setPosition:ccp(160,240)];
    [_levelOverScene.layer.menuBackground setScale:self.allScale];
    
    //check to see if the current score is better than stored score
    if(levelScore > OldhighScore && self.levelFailed != true)
    {      
        //ClearedLevel image
    [_levelOverScene.layer.menuWinLose initWithSpriteFrameName:@"ClearedLevel.png"];
        [_levelOverScene.layer.menuWinLose setPosition:ccp(160,240)];
        [_levelOverScene.layer.menuWinLose setScale:self.allScale];
        
        //New Image
        [_levelOverScene.layer.newWin initWithSpriteFrameName:@"NewLevelScore.png"];
        [_levelOverScene.layer.newWin setPosition:ccp(50,240)];
        [_levelOverScene.layer.newWin setScale:self.allScale];

    }
    else  
    // !New *display but display all.. 
    if(self.highLevelScore >= levelScore && self.levelFailed != true)
    {
        [_levelOverScene.layer.menuWinLose initWithSpriteFrameName:@"FailedScore.png"];
        [_levelOverScene.layer.menuWinLose setPosition:ccp(160,240)];
        [_levelOverScene.layer.menuWinLose setScale:self.allScale];    
    }
       
    //means they hit 3 negative birds...
    if(self.levelFailed == true)
    {
        [_levelOverScene.layer.menuWinLose initWithSpriteFrameName:@"FailedLives.png"];
        [_levelOverScene.layer.menuWinLose setPosition:ccp(160,240)];
        [_levelOverScene.layer.menuWinLose setScale:self.allScale];
        self.levelFailed = false;
    }

    [[CCDirector sharedDirector] replaceScene:_levelOverScene]; 
    
    self.timerLevelCount = 0;
}

-(void)loadLevelNumberEgg
{
    int level = [AppDelegate get].currentLevelIndex; 
     
    [_levelOverScene.layer.LevelOverNumber initWithSpriteFrameName:[NSString stringWithFormat:@"EggL%d.png",level]];
   
    /*
    switch (level) {
        case 1:
            
            [_levelOverScene.layer.title setString:@"EggL5.png"];
            //_levelOverScene.layer.LevelOverNumber = [CCSprite spriteWithFile:@"EggL5.png"];
            break;
        case 2:
            [_levelOverScene.layer.title setString:@"EggL5.png"];
            //_levelOverScene.layer.LevelOverNumber = [CCSprite spriteWithFile:@"EggL5.png"];
            //_levelOverScene.layer.LevelOverNumber = [CCSprite spriteWithFile:@"EggL5.png"];
            break;
            
        default:
            break;
    }*/
    
    if(level >0)
    {
        //[self addChild:self.LevelOverNumber z:3];        
        //self.LevelOverNumber.position = [self convertPoint:ccp(winSize.width/2,400)];
    }
}

- (GameScene *)currentLevel 
{
    return [GameScene objectAtIndex:_currentLevelIndex];
}

+(AppDelegate *) get {
	
	return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)applicationWillResignActive:(UIApplication *)application {   
    
    CCScene * current = [[CCDirector sharedDirector] runningScene];
	if([current isKindOfClass:[GameScene class]])
	{
		if(![AppDelegate get].paused)
		{
			GameLayer * layer = (GameLayer *)[current getChildByTag:KGameLayer];
			[layer pauseGame];
		}
	}
	[[CCDirector sharedDirector] pause]; 
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
