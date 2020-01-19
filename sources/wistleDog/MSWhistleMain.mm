//
//  MSWhistleMain.m
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSWhistleMain.h"
#import "Recorder.h"

@implementation MSWhistleMain




-(void)animationReturnColor:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	label_whistle.textColor =[UIColor darkGrayColor];
	cambio=YES;
}


-(void) silvo:(id)aobj
{
	label_whistle.textColor =[UIColor whiteColor];
	label_whistle.alpha=1;
	[self clickWhistle:self];
	if (cambio)
	{
		[UIView beginAnimations:@"start" context:self];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDelegate:self];
		label_whistle.alpha=.95;
		[UIView setAnimationDidStopSelector:@selector(animationReturnColor:finished:context:)];
		[UIView commitAnimations];
	}
	cambio=NO;
	resetsilvo();
}


-(void) timercall:(id)aobj
{
	while (1) 
	{
		if (silvo())
		{
			[self performSelectorOnMainThread:@selector(silvo:) withObject:nil waitUntilDone:YES];  
		}
		
		[NSThread sleepForTimeInterval:.2f]; 
	}
	
	
}



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		theArray = [[NSMutableArray alloc]init ];
		[theArray addObject:@"v15.m4v"];
		[theArray addObject:@"v21.m4v"];
		[theArray addObject:@"v23.m4v"];
		[theArray addObject:@"v25.m4v"];
		[theArray addObject:@"v04.m4v"];
		[theArray addObject:@"v07.m4v"];
		[theArray addObject:@"v09.m4v"];
		[theArray addObject:@"v10.m4v"];
		[theArray addObject:@"v12.m4v"];
		[theArray addObject:@"v13.m4v"];
 
		AVAudioSession *mySession = [AVAudioSession sharedInstance];
		
		NSError *audioSessionError = nil;
		[mySession setCategory: AVAudioSessionCategoryPlayAndRecord
						 error: &audioSessionError];
		
		indice=0;
		running=NO;
		startRecording();
		theThread = [[NSThread alloc] initWithTarget:self selector:@selector(timercall:) object:self];
		[theThread start];
		cambio=YES;
		first=YES;
		 
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	label_whistle.textColor =[UIColor darkGrayColor];
	label_whistle1.textColor =[UIColor darkGrayColor];
	
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return ((interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation ==  UIDeviceOrientationLandscapeLeft));
	
	
	
    

	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	stopRecording();

    [super dealloc];
}


-(void)myMovieFinishedCallback:(NSNotification*)aNotification
{	
	MPMoviePlayerController* thePlayer = [aNotification object];

	[UIView beginAnimations:@"end" context:self];
	 
	[UIView setAnimationDuration:1];
	thePlayer.view.alpha = 0;
	[UIView commitAnimations];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:thePlayer];

    // Release the movie instance created in playMovieAtURL:
	running=NO;
	NSLog(@"start");


}

-(IBAction) clickWhistle:(id)aobj
{
	return;
 if(running)
 {
	 return;
 }

	running=YES;
	NSURL    *movieURL;

	
	NSString *writableDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[theArray objectAtIndex:indice]];
	indice++;

	if (indice ==[theArray count]) 
	{
		indice=0;
	}
	movieURL = [NSURL fileURLWithPath:writableDBPath];
	[movieURL retain];
	
	if (theMovie!=nil)
	{
		[theMovie release];
	}
	
	theMovie =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	theMovie.scalingMode      = MPMovieScalingModeAspectFill;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		theMovie.view.frame = CGRectMake(0, 0, 1024,768 );
	}
	else 
	{
		theMovie.view.frame = CGRectMake(0, 0, 480, 320);
		
	}
	
	CGRect arect =  button_info.frame;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		arect.origin.x = 986;
		arect.origin.y = 19;

	}
	else 
	{
		arect.origin.x = 449;
		arect.origin.y = 12;
		
	}

	button_info.frame = arect;
	
	arect =  label_whistle.frame;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		arect.origin.x = 364;
		arect.origin.y = 721;
		
	}
	else 
	{
		arect.origin.x = 92;
		arect.origin.y = 284;
		
	}
	
	label_whistle.frame = arect;
	
	
	[theMovie.view addSubview:label_whistle];
	[theMovie.view addSubview:button_info];
	
	theMovie.controlStyle =MPMovieControlStyleNone;
	theMovie.view.alpha=.4;
	[self.view addSubview:theMovie.view];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(myMovieFinishedCallback:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:theMovie];	
	
	[theMovie play]; 

	[UIView beginAnimations:@"start" context:self];
	[UIView setAnimationDuration:.5];
	theMovie.view.alpha=1;
	
	[UIView commitAnimations];

}





@end

