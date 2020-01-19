//
//  MSWhistleMain.h
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface MSWhistleMain : UIViewController {
	IBOutlet UIImageView *theimageBG;
	IBOutlet UILabel     *label_whistle;
	IBOutlet UILabel     *label_whistle1;

	IBOutlet UIButton    *button_info;
	MPMoviePlayerController*	theMovie;
	NSMutableArray * theArray;
	NSUInteger indice;
	BOOL running;
	NSThread * theThread;
	BOOL cambio;
	BOOL first;
}

-(IBAction) clickWhistle:(id)aobj;

@end
