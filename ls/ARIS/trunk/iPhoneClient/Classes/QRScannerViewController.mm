//
//  CameraViewController.m
//  ARIS
//
//  Created by David Gagnon on 3/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QRScannerViewController.h"
#import "Decoder.h"
#import "TwoDDecoderResult.h"


@implementation QRScannerViewController 

@synthesize moduleName;
@synthesize imagePickerController;
@synthesize scanButton;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	moduleName = @"RESTQRScanner";
	
	
	self.imagePickerController = [[UIImagePickerController alloc] init];
	self.imagePickerController.allowsImageEditing = YES;
	self.imagePickerController.delegate = self;
	
	NSLog(@"QRScannerViewController Loaded");
}

-(void) setModel:(AppModel *)model {
	if(appModel != model) {
		[appModel release];
		appModel = model;
		[appModel retain];
	}	
	NSLog(@"model set for QRScannerViewController");
}

- (IBAction)scanButtonTouchAction: (id) sender{
	NSLog(@"Scan Button Pressed");
	
	self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentModalViewController:self.imagePickerController animated:YES];
	 
}

#pragma mark UIImagePickerControllerDelegate Protocol Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	CGRect cropRect;
	//if ([editInfo objectForKey:UIImagePickerControllerCropRect]) {  //do we have a user specified cropRect?
	//	cropRect = [[editInfo objectForKey:UIImagePickerControllerCropRect] CGRectValue];
	//} else { //No user-specified croprect, so set cropRect to use entire image
		cropRect = CGRectMake(0.0, 0.0, img.size.width, img.size.height);
	//}
	
	//Now to decode
	Decoder *imageDecoder = [[Decoder alloc] init]; //create a decoder
	[imageDecoder setDelegate:self];  //we get told about the scan, 
	[imageDecoder decodeImage:img cropRect:cropRect]; //start the decode. When done, our delegate method will be called.
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark QRCScan delegate methods

- (void)decoder:(Decoder *)decoder didDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset withResult:(TwoDDecoderResult *)twoDResult {
	//get the result
	NSString *result = twoDResult.text;
	//we are done with the scanner, so release it
	[decoder release];
	NSLog(@"QR Scanner: Decode Complete. QR Code ID = %@", result);
	
	//init url
	NSString *baseURL = [appModel getURLStringForModule:@"RESTQRScanner"];
	NSString *fullURL = [ NSString stringWithFormat:@"%@&qrcode_id=%@", baseURL, result];
	NSLog([NSString stringWithFormat:@"Fetching QR Code from : %@", fullURL]);
	
	//setup the xml parser to use a qrparser delegate and the deleage to use this view controller as a delegate
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
	QRScannerParserDelegate *parserDelegate = [[QRScannerParserDelegate alloc] init];
	[parser setDelegate: parserDelegate];
	[parserDelegate setDelegate: self];
	
	//init parser
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
}

- (void)decoder:(Decoder *)decoder decodingImage:(UIImage *)image usingSubset:(UIImage *)subset progress:(NSString *)message {
	NSLog(@"Decoding image");
}

- (void)decoder:(Decoder *)decoder failedToDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset reason:(NSString *)reason {
	NSLog(@"Failed to decode image");
	[decoder release];
}

- (void)decoder:(Decoder *)decoder willDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset {
	NSLog(@"Will decode image");
}

#pragma mark UINavigationControllerDelegate Protocol Methods
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
	//nada
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
	//nada
}

#pragma mark QRScannerParserDelegate Methods
- (void) qrParserDidFinish:(QRCode*)qrcode{
	NSLog(@"QRScannerViewController: Recieved QR Code Message for '%@'", qrcode.label);
	
	//Build the ful URL
	NSString *baseURL;
	if ([qrcode.type isEqualToString:@"Item"])  baseURL = [appModel getURLStringForModule:@"RESTInventory"];
	else baseURL = [appModel getURLStringForModule:@"RESTNodeViewer"];
	
	NSString *URLparams = qrcode.URL;
	NSString *fullURL = [ NSString stringWithFormat:@"%@%@", baseURL, URLparams];
	
	//Load the webview
	NSLog([NSString stringWithFormat:@"Loading genericWebView for: %@ at %@", qrcode.label, fullURL ]);
	
	GenericWebViewController *genericWebViewController = [[GenericWebViewController alloc] initWithNibName:@"GenericWebView" bundle:[NSBundle mainBundle]];
	[genericWebViewController setModel:appModel];
	[genericWebViewController setURL: fullURL];
	[genericWebViewController setToolbarTitle:qrcode.label];
	[self.view addSubview:genericWebViewController.view];		
}


#pragma mark Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
