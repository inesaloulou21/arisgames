//
//  ItemViewController.m
//  ARIS
//
//  Created by David Gagnon on 4/2/09.
//  Copyright 2009 University of Wisconsin - Madison. All rights reserved.
//

#import "ItemViewController.h"
#import "ARISAppDelegate.h"
#import "AppServices.h"
#import "AsyncMediaPlayerButton.h"
#import "Media.h"
#import "Item.h"
#import "ItemActionViewController.h"
#import "WebPage.h"
#import "WebPageViewController.h"
#import "NpcViewController.h"
#import "NoteEditorViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+Scale.h"

NSString *const kItemDetailsDescriptionHtmlTemplate = 
@"<html>"
@"<head>"
@"	<title>Aris</title>"
@"	<style type='text/css'><!--"
@"	body {"
@"		background-color: #000000;"
@"		color: #FFFFFF;"
@"		font-size: 17px;"
@"		font-family: Helvetia, Sans-Serif;"
@"      a:link {COLOR: #0000FF;}"
@"	}"
@"	--></style>"
@"</head>"
@"<body>%@</body>"
@"</html>";

@implementation ItemViewController

@synthesize item;
@synthesize inInventory;
@synthesize mode;
@synthesize itemImageView;
@synthesize itemWebView;
@synthesize activityIndicator;
@synthesize itemDescriptionView;;
@synthesize textBox;
@synthesize scrollView;
@synthesize saveButton;

- (id) init
{
    if ((self = [super initWithNibName:@"ItemViewController" bundle:nil]))
    {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
		mode = kItemDetailsViewing;
    }
    return self;
}

- (id) initWithItem:(Item *)i
{
    self = [self init];
    self.item = [[InGameItem alloc] initWithItem:i qty:1];

    return self;
}

- (id) initWithInGameItem:(InGameItem *)i
{
    self = [self init];
    self.item = i;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Show waiting Indicator in own thread so it appears on time
	//[NSThread detachNewThreadSelector: @selector(showWaitingIndicator:) toTarget:[RootViewController sharedRootViewController] withObject: @"Loading..."];	
	//[[RootViewController sharedRootViewController]showWaitingIndicator:NSLocalizedString(@"LoadingKey",@"") displayProgressBar:NO];
    
	self.itemWebView.delegate = self;
    self.itemDescriptionView.delegate = self;
    
	//Setup the Toolbar Buttons
	dropButton.title = NSLocalizedString(@"ItemDropKey", @"");
	pickupButton.title = NSLocalizedString(@"ItemPickupKey", @"");
	deleteButton.title = NSLocalizedString(@"ItemDeleteKey",@"");
	detailButton.title = NSLocalizedString(@"ItemDetailKey", @"");
	
	if (inInventory == YES)
    {
		dropButton.width = 75.0;
		deleteButton.width = 75.0;
		detailButton.width = 140.0;
		
		[toolBar setItems:[NSMutableArray arrayWithObjects: dropButton, deleteButton, detailButton,  nil] animated:NO];
        
		if (!item.item.isDroppable)   dropButton.enabled   = NO;
		if (!item.item.isDestroyable) deleteButton.enabled = NO;
	}
	else
    {
		pickupButton.width = 150.0;
		detailButton.width = 150.0;
        
		[toolBar setItems:[NSMutableArray arrayWithObjects: pickupButton,detailButton, nil] animated:NO];
	}
	
	//Create a close button
	self.navigationItem.leftBarButtonItem = 
	[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"BackButtonKey",@"")
									 style: UIBarButtonItemStyleBordered
									target:self 
									action:@selector(backButtonTouchAction:)];    
	//Set Up General Stuff
	NSString *htmlDescription = [NSString stringWithFormat:kItemDetailsDescriptionHtmlTemplate, item.item.idescription];
	[itemDescriptionView loadHTMLString:htmlDescription baseURL:nil];
    
	Media *media = [[AppModel sharedAppModel] mediaForMediaId:item.item.mediaId];
        
	if ([media.type isEqualToString: kMediaTypeImage] && media.url)
    {
		[itemImageView loadImageFromMedia:media];
        itemImageView.contentMode = UIViewContentModeScaleAspectFit;
	}
	else if (([media.type isEqualToString:kMediaTypeVideo] || [media.type isEqualToString: kMediaTypeAudio]) && media.url)
    {        
        AsyncMediaPlayerButton *mediaButton = [[AsyncMediaPlayerButton alloc] initWithFrame:CGRectMake(8, 0, 304, 244) media:media presentingController:[RootViewController sharedRootViewController] preloadNow:NO];
        //mediaArea.frame = CGRectMake(0, 0, 300, 240);
        [self.scrollView addSubview:mediaButton];
        //mediaArea.frame = CGRectMake(0, 0, 300, 240);
        
        /*
		//Setup the Button
        mediaPlaybackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
        [mediaPlaybackButton addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchUpInside];
        [mediaPlaybackButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
		[mediaPlaybackButton setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        
        //Create movie player object
        mMoviePlayer = [[ARISMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:media.url]];
        mMoviePlayer.moviePlayer.shouldAutoplay = NO;
        [mMoviePlayer.moviePlayer prepareToPlay];
        
        //Setup the overlay
        UIImageView *playButonOverlay = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"play_button.png"]];
        playButonOverlay.center = mediaPlaybackButton.center;
        [mediaPlaybackButton addSubview:playButonOverlay];
        [self.scrollView addSubview:mediaPlaybackButton];
        */
	}
	else
		NSLog(@"ItemDetailsVC: Error Loading Media ID: %d. It etiher doesn't exist or is not of a valid type.", item.item.mediaId);
    
    self.itemWebView.hidden = YES;
	//Stop Waiting Indicator
	//[[RootViewController sharedRootViewController] removeWaitingIndicator];
	[self updateQuantityDisplay];
    if ([self.item.item.type isEqualToString:@"URL"] && self.item.item.url && (![self.item.item.url isEqualToString: @"0"]) &&(![self.item.item.url isEqualToString:@""]))
    {
        //Config the webView
        self.itemWebView.allowsInlineMediaPlayback = YES;
        self.itemWebView.mediaPlaybackRequiresUserAction = NO;
        
        NSString *urlAddress = [self.item.item.url stringByAppendingString: [NSString stringWithFormat: @"?playerId=%d&gameId=%d",[AppModel sharedAppModel].playerId,[AppModel sharedAppModel].currentGame.gameId]];
        
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        //Load the request in the UIWebView.
        [itemWebView loadRequest:requestObj];
    }
    else itemWebView.hidden = YES;
    if([self.item.item.type isEqualToString: @"NOTE"])
    {
        UIBarButtonItem *hideKeyboardButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"HideKeyboardKey", @"") style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)];      
        self.navigationItem.rightBarButtonItem = hideKeyboardButton;
        saveButton.frame = CGRectMake(0, 335, 320, 37);
        textBox.text = item.item.idescription;
        [self.scrollView addSubview:textBox];
        [self.scrollView addSubview:saveButton];
        self.textBox.userInteractionEnabled = NO;
        [saveButton removeFromSuperview];
        self.navigationItem.rightBarButtonItem = nil;        
    }
}

- (void)updateQuantityDisplay
{
	if (item.qty > 1) self.title = [NSString stringWithFormat:@"%@ x%d",item.item.name,item.qty];
	else self.title = item.item.name;
}

- (IBAction)backButtonTouchAction:(id)sender
{
    [delegate displayObjectViewControllerWasDismissed:self];
}

-(IBAction)playMovie:(id)sender
{
	[self presentMoviePlayerViewControllerAnimated:mMoviePlayer];
}

- (IBAction)dropButtonTouchAction:(id)sender
{
	NSLog(@"ItemDetailsVC: Drop Button Pressed");
	mode = kItemDetailsDropping;
	if(self.item.qty > 1)
    {
        ItemActionViewController *itemActionVC = [[ItemActionViewController alloc]initWithNibName:@"ItemActionViewController" bundle:nil];
        itemActionVC.mode = mode;
        itemActionVC.item = item;
        itemActionVC.delegate = self;
        itemActionVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
        [[self navigationController] pushViewController:itemActionVC animated:YES];
        [self updateQuantityDisplay];
        
    }
    else 
        [self doActionWithMode:mode quantity:1];
}

- (IBAction) deleteButtonTouchAction:(id)sender
{
	NSLog(@"ItemDetailsVC: Destroy Button Pressed");
	mode = kItemDetailsDestroying;
	if(self.item.qty > 1)
    {
        ItemActionViewController *itemActionVC = [[ItemActionViewController alloc]initWithNibName:@"ItemActionViewController" bundle:nil];
        itemActionVC.mode = mode;
        itemActionVC.item = item;
        itemActionVC.delegate = self;
        
        itemActionVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
        [[self navigationController] pushViewController:itemActionVC animated:YES];
        [self updateQuantityDisplay];
    }
    else 
        [self doActionWithMode:mode quantity:1];
}

- (IBAction)pickupButtonTouchAction:(id)sender
{
	NSLog(@"ItemDetailsViewController: pickupButtonTouched");
	mode = kItemDetailsPickingUp;
    if(self.item.qty > 1)
    {
        ItemActionViewController *itemActionVC = [[ItemActionViewController alloc] initWithNibName:@"ItemActionViewController" bundle:nil];
        itemActionVC.mode = mode;
        itemActionVC.item = item.item;
        itemActionVC.itemInInventory = item;
        itemActionVC.delegate = self;
        
        itemActionVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
        [[self navigationController] pushViewController:itemActionVC animated:YES];
        [self updateQuantityDisplay];
    }
    else
        [self doActionWithMode:mode quantity:1];
}

-(void)doActionWithMode:(ItemDetailsModeType)itemMode quantity:(int)quantity
{
    ARISAppDelegate* appDelegate = (ARISAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate playAudioAlert:@"drop" shouldVibrate:YES];
		
	//Do the action based on the mode of the VC
	if(mode == kItemDetailsDropping)
    {
		NSLog(@"ItemDetailsVC: Dropping %d",quantity);
		[[AppServices sharedAppServices] updateServerDropItemHere:item.item.itemId qty:quantity];
		[[AppModel sharedAppModel].currentGame.inventoryModel removeItemFromInventory:item.item qtyToRemove:quantity];
    }
	else if(mode == kItemDetailsDestroying)
    {
		NSLog(@"ItemDetailsVC: Destroying %d",quantity);
		[[AppServices sharedAppServices] updateServerDestroyItem:self.item.item.itemId qty:quantity];
		[[AppModel sharedAppModel].currentGame.inventoryModel removeItemFromInventory:item.item qtyToRemove:quantity];
	}
	else if(mode == kItemDetailsPickingUp)
    {
        NSString *errorMessage;
        
		//Determine if this item can be picked up
		InGameItem *itemInInventory  = [[AppModel sharedAppModel].currentGame.inventoryModel inventoryItemForId:item.item.itemId];
		if(itemInInventory && itemInInventory.qty + quantity > item.item.maxQty && item.item.maxQty != -1)
        {
			[appDelegate playAudioAlert:@"error" shouldVibrate:YES];
			
			if (itemInInventory.qty < item.item.maxQty)
            {
				quantity = item.item.maxQty - itemInInventory.qty;
                
                if([AppModel sharedAppModel].currentGame.inventoryModel.weightCap != 0)
                {
                    while((quantity*item.item.weight + [AppModel sharedAppModel].currentGame.inventoryModel.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryModel.weightCap){
                        quantity--;
                    }
                }
				errorMessage = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"ItemAcionCarryThatMuchKey", @""),quantity,NSLocalizedString(@"PickedUpKey", @"")];
			}
			else if (item.item.maxQty == 0)
            {
				errorMessage = NSLocalizedString(@"ItemAcionCannotPickUpKey", @"");
				quantity = 0;
			}
            else
            {
				errorMessage = NSLocalizedString(@"ItemAcionCannotCarryMoreKey", @"");
				quantity = 0;
			}
            
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ItemAcionInventoryOverLimitKey", @"")
															message:errorMessage
														   delegate:self cancelButtonTitle:NSLocalizedString(@"OkKey", @"") otherButtonTitles:nil];
			[alert show];
		}
        else if (((quantity*item.item.weight +[AppModel sharedAppModel].currentGame.inventoryModel.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryModel.weightCap)&&([AppModel sharedAppModel].currentGame.inventoryModel.weightCap != 0))
        {
            while ((quantity*item.item.weight + [AppModel sharedAppModel].currentGame.inventoryModel.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryModel.weightCap)
                quantity--;

            errorMessage = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"ItemAcionTooHeavyKey", @""),quantity,NSLocalizedString(@"PickedUpKey", @"")];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ItemAcionInventoryOverLimitKey", @"")
															message:errorMessage
														   delegate:self cancelButtonTitle:NSLocalizedString(@"OkKey", @"") otherButtonTitles:nil];
			[alert show];
        }
        
		if (quantity > 0) 
        {
			//[[AppServices sharedAppServices] updateServerPickupItem:self.item.itemId fromLocation:self.item.locationId qty:quantity];
			//[[AppModel sharedAppModel].currentGame.locationsModel modifyQuantity:-quantity forLocationId:self.item.locationId];
			item.qty -= quantity; //the above line does not give us an update, only the map
        }
	}
	
	[self updateQuantityDisplay];
	
	if (item.qty < 1) pickupButton.enabled = NO;
	else              pickupButton.enabled = YES;
}

#pragma mark MPMoviePlayerController Notification Handlers

- (void)movieLoadStateChanged:(NSNotification*) aNotification
{
	MPMovieLoadState state = [(MPMoviePlayerController *) aNotification.object loadState];
	
	if(state & MPMovieLoadStateUnknown)
		NSLog(@"ItemDetailsViewController: Unknown Load State");
    if(state & MPMovieLoadStatePlaythroughOK)
		NSLog(@"ItemDetailsViewController: Playthrough OK Load State");
    if(state & MPMovieLoadStateStalled)
		NSLog(@"ItemDetailsViewController: Stalled Load State");
	if(state & MPMovieLoadStatePlayable)
    {
		NSLog(@"ItemDetailsViewController: Playable Load State");
        //Create a thumbnail for the button
        if (![mediaPlaybackButton backgroundImageForState:UIControlStateNormal]) 
        {
            UIImage *videoThumb = [mMoviePlayer.moviePlayer thumbnailImageAtTime:(NSTimeInterval)1.0 timeOption:MPMovieTimeOptionExact];            
            UIImage *videoThumbSized = [videoThumb scaleToSize:CGSizeMake(320, 240)];        
            [mediaPlaybackButton setBackgroundImage:videoThumbSized forState:UIControlStateNormal];
        }
	} 
}

- (void)movieFinishedCallback:(NSNotification*) aNotification
{
	NSLog(@"ItemDetailsViewController: movieFinishedCallback");
	[self dismissMoviePlayerViewControllerAnimated];
}

#pragma mark Zooming delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
	return itemImageView;
}

- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (float) scale
{
	NSLog(@"got a scrollViewDidEndZooming. Scale: %f", scale);
	CGAffineTransform transform = CGAffineTransformIdentity;
	transform = CGAffineTransformScale(transform, scale, scale);
	itemImageView.transform = transform;
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [touches anyObject];	
    if([touch tapCount] == 2)
    {
		CGAffineTransform transform = CGAffineTransformIdentity;
		transform = CGAffineTransformScale(transform, 1.0, 1.0);
		itemImageView.transform = transform;
    }
}

#pragma mark Animate view show/hide

- (void)showView:(UIView *)aView
{
	CGRect superFrame = [aView superview].bounds;
	CGRect viewFrame = [aView frame];
	viewFrame.origin.y = superFrame.origin.y + superFrame.size.height - aView.frame.size.height - toolBar.frame.size.height;
    viewFrame.size.height = aView.frame.size.height;
	[UIView beginAnimations:nil context:NULL]; //we animate the transition
	[aView setFrame:viewFrame];
	[UIView commitAnimations]; //run animation
}

- (void)hideView:(UIView *)aView 
{
	CGRect superFrame = [aView superview].bounds;
	CGRect viewFrame = [aView frame];
	viewFrame.origin.y = superFrame.origin.y + superFrame.size.height;
	[UIView beginAnimations:nil context:NULL]; //we animate the transition
	[aView setFrame:viewFrame];
	[UIView commitAnimations]; //run animation
}

- (void)toggleDescription:(id)sender 
{
	ARISAppDelegate* appDelegate = (ARISAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate playAudioAlert:@"swish" shouldVibrate:NO];
	
	if(descriptionShowing) { [self hideView:self.itemDescriptionView]; descriptionShowing = NO;  }
    else                   { [self showView:self.itemDescriptionView]; descriptionShowing = YES; }
}

#pragma mark WebViewDelegate 

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(webView == self.itemWebView)
    {
        if([[[request URL] absoluteString] hasPrefix:@"aris://closeMe"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return NO;
        }  
        else if([[[request URL] absoluteString] hasPrefix:@"aris://refreshStuff"])
        {
            [[AppServices sharedAppServices] fetchAllPlayerLists];
            return NO;
        }
    }
    else if(![[[request URL]absoluteString] isEqualToString:@"about:blank"])
    {
        WebPageViewController *webPageViewController = [[WebPageViewController alloc] initWithNibName:@"WebPageViewController" bundle: [NSBundle mainBundle]];
        WebPage *temp = [[WebPage alloc]init];
        temp.url = [[request URL]absoluteString];
        webPageViewController.webPage = temp;
        webPageViewController.delegate = self;
        [self.navigationController pushViewController:webPageViewController animated:NO];
            
        return NO;
    }
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView == self.itemWebView)
    {
        self.itemWebView.hidden = NO;
        [self dismissWaitingIndicator];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if(webView == self.itemWebView)[self showWaitingIndicator];
}

-(void)showWaitingIndicator
{
    [self.activityIndicator startAnimating];
}

-(void)dismissWaitingIndicator
{
    [self.activityIndicator stopAnimating];
}

#pragma mark Note functions

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.textBox.text isEqualToString:@"Write note here..."])
        [self.textBox setText:@""];
    self.textBox.frame = CGRectMake(0, 0, 320, 230);
}

-(void)hideKeyboard
{
    [self.textBox resignFirstResponder];
    self.textBox.frame = CGRectMake(0, 0, 320, 335);
}

#pragma mark Memory Management

- (void)dealloc
{
    NSLog(@"Item Details View: Dealloc");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    itemDescriptionView.delegate = nil;
    [itemDescriptionView stopLoading];
    itemWebView.delegate = nil;
    [itemWebView stopLoading];
}

@end
