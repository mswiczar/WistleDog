//
//  wistleDogAppDelegate.m
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "wistleDogAppDelegate.h"
#import "MSWhistleMain.h"

@implementation wistleDogAppDelegate

@synthesize window;
@synthesize is_ipod,is_simulator;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	[[GANTracker sharedTracker] startTrackerWithAccountID:TRAKERGOOGLE
										   dispatchPeriod:5
												 delegate:nil];
	is_ipod =(([[[UIDevice currentDevice]model]isEqualToString:@"iPod touch"]) || ([[[UIDevice currentDevice]model]isEqualToString:@"iPad"]));
	is_simulator = [[[UIDevice currentDevice]model]isEqualToString:@"iPhone Simulator"];
	[self trackpage:@"/StartApp"];
	
	
    // Override point for customization after application launch.
	MSWhistleMain * themain =[[MSWhistleMain alloc] initWithNibName:@"MSWhistleMain" bundle:nil];
	thenavigationMain = [[UINavigationController alloc] initWithRootViewController:themain];
	thenavigationMain.navigationBarHidden=YES;
	[themain release];
    [self.window addSubview:thenavigationMain.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	[[GANTracker sharedTracker]stopTracker ];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	[[GANTracker sharedTracker] startTrackerWithAccountID:TRAKERGOOGLE
										   dispatchPeriod:5
												 delegate:nil];
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [thenavigationMain release];
	[window release];
	
    [super dealloc];
}

-(void) trackpage:(NSString*) thestr
{
	
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:thestr
										 withError:&error]) {
		// Handle error here
		// NSLog(@"Error");
		
		
		
		
	}
}


@end
