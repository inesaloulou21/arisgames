//
//  BogusSelectGameViewController.m
//  ARIS
//
//  Created by David J Gagnon on 6/8/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "BogusSelectGameViewController.h"
#import "ARISAppDelegate.h"


@implementation BogusSelectGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"BogusTitleKey", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"game.png"];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"NewGameSelected" object:nil]];
    
    ARISAppDelegate *appDelegate = (ARISAppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate tabBarController].selectedIndex = 0;
    [appDelegate showGameSelectionTabBarAndHideOthers];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.navigationController popToRootViewControllerAnimated:NO];

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end