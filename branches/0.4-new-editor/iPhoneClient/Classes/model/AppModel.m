//
//  AppModel.m
//  ARIS
//
//  Created by Ben Longoria on 2/17/09.
//  Copyright 2009 University of Wisconsin. All rights reserved.
//

#import "AppModel.h"
#import "ARISAppDelegate.h"
#import "Media.h"
#import "NodeOption.h"
#import "Quest.h"
#import "JSONConnection.h"
#import "JSONResult.h"
#import "JSON.h"

static NSString *const nearbyLock = @"nearbyLock";
static NSString *const locationsLock = @"locationsLock";
static const int kDefaultCapacity = 10;

@implementation AppModel

@synthesize serverName, baseAppURL, jsonServerBaseURL, loggedIn;
@synthesize username, password, playerId, currentModule;
@synthesize site, gameId, gameList, locationList, playerList;
@synthesize playerLocation, inventory, questList, networkAlert, mediaList;

@dynamic nearbyLocationsList;

#pragma mark Init/dealloc
-(id)init {
    if (self = [super init]) {
		//Init USerDefaults
		defaults = [NSUserDefaults standardUserDefaults];
		mediaList = [[NSMutableDictionary alloc] initWithCapacity:kDefaultCapacity];
	}
			 
    return self;
}

- (void)dealloc {
	[mediaList release];
	[gameList release];
	[baseAppURL release];
	[username release];
	[password release];
	[currentModule release];
	[site release];
    [super dealloc];
}

-(void)loadUserDefaults {
	NSLog(@"Model: Loading User Defaults");
	
	//Load the base App URL
	self.baseAppURL = [defaults stringForKey:@"baseAppURL"];
	
	//Make sure it has a trailing slash (needed in some places)
	int length = [self.baseAppURL length];
	unichar lastChar = [self.baseAppURL characterAtIndex:length-1];
	NSString *lastCharString = [ NSString stringWithCharacters:&lastChar length:1 ];
	if (![lastCharString isEqualToString:@"/"]) self.baseAppURL = [[NSString alloc] initWithFormat:@"%@/",self.baseAppURL];
	
	NSURL *url = [NSURL URLWithString:self.baseAppURL];
	self.serverName = [NSString stringWithFormat:@"http://%@:%d", [url host], 
					   ([url port] ? [[url port] intValue] : 80)];
	
	self.gameId = [defaults integerForKey:@"gameId"];
	self.loggedIn = [defaults boolForKey:@"loggedIn"];
	
	if (loggedIn == YES) {
		if (![baseAppURL isEqualToString:[defaults stringForKey:@"lastBaseAppURL"]]) {
			self.loggedIn = NO;
			NSLog(@"Model: Server URL changed since last execution. Throw out Defaults and use URL: '%@' Site: '%@' GameId: '%d'", baseAppURL, site, gameId);
		}
		else {
			self.username = [defaults stringForKey:@"username"];
			self.password = [defaults stringForKey:@"password"];
			self.playerId = [defaults integerForKey:@"playerId"];
			NSLog(@"Model: Defaults Found. Use URL: '%@' User: '%@' Password: '%@' PlayerId: '%d' GameId: '%d' Site: '%@'", 
				  baseAppURL, username, password, playerId, gameId, site);
		}
	}
	else NSLog(@"Model: Player was not logged in, Initing with Defaults");

	
	self.jsonServerBaseURL = [NSString stringWithFormat:@"%@%@",
						 baseAppURL, @"json.php/aris"];
	
	NSLog(@"AppModel: jsonServerURL is %@",jsonServerBaseURL);
}


-(void)clearUserDefaults {
	NSLog(@"Model: Clearing User Defaults");
	
	[defaults removeObjectForKey:@"loggedIn"];	
	[defaults removeObjectForKey:@"username"];
	[defaults removeObjectForKey:@"password"];
	[defaults removeObjectForKey:@"playerId"];
	[defaults removeObjectForKey:@"gameId"];
	//Don't clear the baseAppURL
}

-(void)saveUserDefaults {
	NSLog(@"Model: Saving User Defaults");
	
	[defaults setBool:loggedIn forKey:@"loggedIn"];
	[defaults setObject:username forKey:@"username"];
	[defaults setObject:password forKey:@"password"];
	[defaults setInteger:playerId forKey:@"playerId"];
	[defaults setInteger:gameId forKey:@"gameId"];
	[defaults setObject:baseAppURL forKey:@"lastBaseAppURL"];
	[defaults setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"appVerison"];
}

-(void)initUserDefaults {	
	
	//Load the settings bundle data into an array
	NSString *pathStr = [[NSBundle mainBundle] bundlePath];
	NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
	NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
	NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
	NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
	
	//Find the Defaults
	NSString *baseAppURLDefault;
	NSDictionary *prefItem;
	for (prefItem in prefSpecifierArray)
	{
		NSString *keyValueStr = [prefItem objectForKey:@"Key"];
		id defaultValue = [prefItem objectForKey:@"DefaultValue"];
		
		if ([keyValueStr isEqualToString:@"baseAppURL"])
		{
			baseAppURLDefault = defaultValue;
		}
		//More defaults would go here
	}
	
	// since no default values have been set (i.e. no preferences file created), create it here
	NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys: 
								 baseAppURLDefault,  @"baseAppURL", 
								 nil];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
	[[NSUserDefaults standardUserDefaults] synchronize];
}




#pragma mark Communication with Server
- (BOOL)login {
	NSLog(@"AppModel: Login Requested");
	NSArray *arguments = [NSArray arrayWithObjects:self.username, self.password, nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc] initWithArisJSONServer:jsonServerBaseURL 
																	andServiceName: @"players" 
																	andMethodName:@"login"
																	andArguments:arguments]; 

	JSONResult *jsonResult = [jsonConnection performSynchronousRequest];
	
	if (!jsonResult) {
		self.loggedIn = NO;
		return NO;
	}
	
	//handle login response
	int returnCode = jsonResult.returnCode;
	NSLog(@"AppModel: Login Result Code: %d", returnCode);
	if(returnCode == 0) {
		self.loggedIn = YES;
		loggedIn = YES;
		playerId = [((NSDecimalNumber*)jsonResult.data) intValue];
	}
	else {
		self.loggedIn = NO;	
	}

	return self.loggedIn;
}

- (BOOL)registerNewUser:(NSString*)userName password:(NSString*)pass 
			  firstName:(NSString*)firstName lastName:(NSString*)lastName email:(NSString*)email {
	NSLog(@"AppModel: New User Registration Requested");
	//createPlayer($strNewUserName, $strPassword, $strFirstName, $strLastName, $strEmail)
	NSArray *arguments = [NSArray arrayWithObjects:userName, pass, firstName, lastName, email, nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc] initWithArisJSONServer:jsonServerBaseURL 
																	 andServiceName: @"players" 
																	  andMethodName:@"createPlayer"
																	   andArguments:arguments]; 
	
	JSONResult *jsonResult = [jsonConnection performSynchronousRequest];
	
	if (!jsonResult) {
		NSLog(@"AppModel registerNewUser: No result Data, return");
		return NO;
	}
	
    BOOL success;
	
	int returnCode = jsonResult.returnCode;
	if (returnCode == 0) {
		NSLog(@"AppModel: Result from new user request successfull");
		success = YES;
	}
	else { 
		NSLog(@"AppModel: Result from new user request unsuccessfull");
		success = NO;
	}
	return success;
	
}

- (void)updateServerNodeViewed: (int)nodeId {
	NSLog(@"Model: Node %d Viewed, update server", nodeId);
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  [NSString stringWithFormat:@"%d",nodeId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"nodeViewed" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)updateServerItemViewed: (int)itemId {
	NSLog(@"Model: Item %d Viewed, update server", itemId);
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects:
						  [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  [NSString stringWithFormat:@"%d",itemId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"itemViewed" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)updateServerGameSelected{
	NSLog(@"Model: Game %d Selected, update server", gameId);
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: 
						  [NSString stringWithFormat:@"%d",self.playerId],
						  [NSString stringWithFormat:@"%d",playerId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"updatePlayerLastGame" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}



- (void)resetPlayerEvents {
	NSLog(@"Model: Clearing Player Events");
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"resetEvents" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)resetPlayerItems {
	NSLog(@"Model: Clearing Player Items");
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"resetItems" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)updateServerPickupItem: (int)itemId fromLocation: (int)locationId {
	NSLog(@"Model: Informing the Server the player picked up item");
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  [NSString stringWithFormat:@"%d",itemId],
						  [NSString stringWithFormat:@"%d",locationId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"pickupItemFromLocation" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)updateServerDropItemHere: (int)itemId {
	NSLog(@"Model: Informing the Server the player dropped an item");
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  [NSString stringWithFormat:@"%d",itemId],
						  [NSString stringWithFormat:@"%f",playerLocation.coordinate.latitude],
						  [NSString stringWithFormat:@"%f",playerLocation.coordinate.longitude],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"dropItem" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)updateServerDestroyItem: (int)itemId {
	NSLog(@"Model: Informing the Server the player destroyed an item");
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  [NSString stringWithFormat:@"%d",itemId],
						  nil];
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:@"players" 
																	 andMethodName:@"destroyItem" 
																	  andArguments:arguments];
	[jsonConnection performSynchronousRequest]; 
}

- (void)createItemForImage: (UIImage *)image{
	NSLog(@"Model: creating a new Item for an image");
	//Upload the file to get it's name
	//Create the media record, add the item to the game and add this item to the players inventory
}

- (void)updateServerLocationAndfetchNearbyLocationList {
	@synchronized (nearbyLock) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		NSLog(@"Model: updating player position on server and determining nearby Locations");
		
		if (!loggedIn) {
			NSLog(@"Model: Player Not logged in yet, skip the location update");	
			return;
		}
		
		//init a fresh nearby location list array
		if(nearbyLocationsList != nil) {
			[nearbyLocationsList release];
		}
		nearbyLocationsList = [[NSMutableArray alloc] initWithCapacity:5];
		
		//Update the server with the new Player Location
		NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.playerId],
							  [NSString stringWithFormat:@"%f",playerLocation.coordinate.latitude],
							  [NSString stringWithFormat:@"%f",playerLocation.coordinate.longitude],
							  nil];
		JSONConnection *jsonConnection = [[JSONConnection alloc] initWithArisJSONServer:self.jsonServerBaseURL 
																		 andServiceName:@"players" 
																		  andMethodName:@"updatePlayerLocation" 
																		   andArguments:arguments];
		[jsonConnection performSynchronousRequest]; 
		
		//Rebuild nearbyLocationList
		//We could just do this in the getter
		NSEnumerator *locationsListEnumerator = [locationList objectEnumerator];
		Location *location;
		while (location = [locationsListEnumerator nextObject]) {
			//check if the location is close to the player
			if ([playerLocation getDistanceFrom:location.location] < location.error)
				[nearbyLocationsList addObject:location];
		}
		
		//Tell the rest of the app that the nearbyLocationList is fresh
		NSNotification *nearbyLocationListNotification = 
		[NSNotification notificationWithName:@"ReceivedNearbyLocationList" object:nearbyLocationsList];
		[[NSNotificationCenter defaultCenter] postNotification:nearbyLocationListNotification];
		[pool drain];
	}
}


#pragma mark Fetch selectors
- (id) fetchFromService:(NSString *)aService usingMethod:(NSString *)aMethod 
			   withArgs:(NSArray *)arguments usingParser:(SEL)aSelector 
{
	NSLog(@"JSON://%@/%@/%@", aService, aMethod, arguments);
	
	JSONConnection *jsonConnection = [[JSONConnection alloc]initWithArisJSONServer:self.jsonServerBaseURL 
																	andServiceName:aService
																	 andMethodName:aMethod
																	  andArguments:arguments];
	JSONResult *jsonResult = [jsonConnection performSynchronousRequest]; 
	
	if (!jsonResult) {
		NSLog(@"\tFailed.");
		return nil;
	}
	
	return [self performSelector:aSelector withObject:jsonResult.data];
}


-(Item *)fetchItem:(int)itemId{
	NSLog(@"Model: Fetch Requested for Item %d", itemId);
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",itemId],
						  nil];

	return [self fetchFromService:@"items" usingMethod:@"getItem" withArgs:arguments 
					  usingParser:@selector(parseItemFromDictionary:)];
}

-(Node *)fetchNode:(int)nodeId{
	NSLog(@"Model: Fetch Requested for Node %d", nodeId);
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",nodeId],
						  nil];
	
	return [self fetchFromService:@"nodes" usingMethod:@"getNode" withArgs:arguments
					  usingParser:@selector(parseNodeFromDictionary:)];
}

-(Npc *)fetchNpc:(int)npcId{
	NSLog(@"Model: Fetch Requested for Npc %d", npcId);
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",npcId],
						  [NSString stringWithFormat:@"%d",self.playerId],
						  nil];
	return [self fetchFromService:@"npcs" usingMethod:@"getNpcWithConversationsForPlayer"
						 withArgs:arguments usingParser:@selector(parseNpcFromDictionary:)];
}

- (void)fetchGameList {
	NSLog(@"AppModel: Fetching Game List.");
	self.gameList = [self fetchFromService:@"games" usingMethod:@"getGames"
						 withArgs:nil usingParser:@selector(parseGameListFromArray:)];
	
	//Tell everyone
	NSLog(@"AppModel: Finished Building the Game List");
	NSNotification *notification = [NSNotification notificationWithName:@"ReceivedGameList" object:self userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)fetchLocationList {
	@synchronized (locationsLock) {
		NSLog(@"AppModel: Fetching Locations from Server");	
		if (!loggedIn) {
			NSLog(@"AppModel: Player Not logged in yet, skip the location fetch");	
			return;
		}
				
		NSArray *arguments = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.gameId],
							  [NSString stringWithFormat:@"%d",self.playerId], 
							  nil];
		
		//init location list array
		if(locationList != nil) {
			[locationList release];
		}
		locationList = [NSMutableArray array];
		[locationList retain];
		
		self.locationList = [self fetchFromService:@"locations" usingMethod:@"getLocationsForPlayer"
									  withArgs:arguments usingParser:@selector(parseLocationListFromArray:)];
		
		//Tell everyone
		NSDictionary *dictionary = [NSDictionary dictionaryWithObject:self.gameList forKey:@"gameList"];
		NSLog(@"AppModel: Finished fetching locations from server");
		NSNotification *notification = 
		[NSNotification notificationWithName:@"ReceivedLocationList" object:self userInfo:dictionary];
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	}
}




- (void)fetchMediaList {
	NSArray *arguments = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",self.gameId], nil];
	
	self.mediaList = [self fetchFromService:@"media" usingMethod:@"getMedia"
									  withArgs:arguments usingParser:@selector(parseMediaListFromArray:)];
	
}


- (void)fetchInventory {
	NSLog(@"Model: Inventory Fetch Requested");
	//init inventory array
	if(inventory != nil) {
		NSLog(@"*** Releasing inventory ***");
		[inventory release];
	}
	
	inventory = [NSMutableArray array];
	[inventory retain];
	
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",self.playerId],
						  nil];
	self.inventory = [self fetchFromService:@"items" usingMethod:@"getItemsForPlayer"
								   withArgs:arguments usingParser:@selector(parseInventoryFromArray:)];
	
	NSNotification *notification = [NSNotification notificationWithName:@"ReceivedInventory" object:self userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}


-(NSObject<QRCodeProtocol> *)fetchQRCode:(NSString*)QRcodeId{
	NSLog(@"Model: Fetch Requested for QRCodeId: %@", QRcodeId);
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%@",QRcodeId],
						  [NSString stringWithFormat:@"%d",self.playerId],
						  nil];
	
	return [self fetchFromService:@"qrcodes" usingMethod:@"getQRCodeObjectForPlayer"
				  withArgs:arguments usingParser:@selector(parseQRCodeObjectFromDictionary:)];
	
}	




-(void)fetchQuestList {
	NSLog(@"Model: Fetch Requested for Quest");
	
	//Call server service
	NSArray *arguments = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.gameId],
						  [NSString stringWithFormat:@"%d",playerId],
						  nil];
	
	self.questList = [self fetchFromService:@"quests" usingMethod:@"getQuestsForPlayer"
				  withArgs:arguments usingParser:@selector(parseQuestListFromDictionary:)];
	
	//Sound the alarm
	NSNotification *notification = [NSNotification notificationWithName:@"ReceivedQuestList" object:self userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	
}







#pragma mark Parsers
-(Item *)parseItemFromDictionary: (NSDictionary *)itemDictionary{	
	Item *item = [[Item alloc] init];
	item.itemId = [[itemDictionary valueForKey:@"item_id"] intValue];
	item.name = [itemDictionary valueForKey:@"name"];
	item.description = [itemDictionary valueForKey:@"description"];
	item.mediaId = [[itemDictionary valueForKey:@"media_id"] intValue];
	item.iconMediaId = [[itemDictionary valueForKey:@"icon_media_id"] intValue];
	item.dropable = [[itemDictionary valueForKey:@"dropable"] boolValue];
	item.destroyable = [[itemDictionary valueForKey:@"destroyable"] boolValue];
	NSLog(@"\tadded item %@", item.name);
	
	return item;	
}

-(Node *)parseNodeFromDictionary: (NSDictionary *)nodeDictionary{
	//Build the node
	Node *node = [[Node alloc] init];
	node.nodeId = [[nodeDictionary valueForKey:@"node_id"] intValue];
	node.name = [nodeDictionary valueForKey:@"title"];
	node.text = [nodeDictionary valueForKey:@"text"];
	node.mediaId = [[nodeDictionary valueForKey:@"media_id"] intValue];
	
	//Add options here
	int optionNodeId;
	NSString *text;
	NodeOption *option;
	
	if ([nodeDictionary valueForKey:@"opt1_node_id"] != [NSNull null] && [[nodeDictionary valueForKey:@"opt1_node_id"] intValue] > 0) {
		optionNodeId= [[nodeDictionary valueForKey:@"opt1_node_id"] intValue];
		text = [nodeDictionary valueForKey:@"opt1_text"]; 
		option = [[NodeOption alloc] initWithText:text andNodeId: optionNodeId];
		[node addOption:option];
	}
	if ([nodeDictionary valueForKey:@"opt2_node_id"] != [NSNull null] && [[nodeDictionary valueForKey:@"opt2_node_id"] intValue] > 0) {
		optionNodeId = [[nodeDictionary valueForKey:@"opt2_node_id"] intValue];
		text = [nodeDictionary valueForKey:@"opt2_text"]; 
		option = [[NodeOption alloc] initWithText:text andNodeId: optionNodeId];
		[node addOption:option];
	}
	if ([nodeDictionary valueForKey:@"opt3_node_id"] != [NSNull null] && [[nodeDictionary valueForKey:@"opt3_node_id"] intValue] > 0) {
		optionNodeId = [[nodeDictionary valueForKey:@"opt3_node_id"] intValue];
		text = [nodeDictionary valueForKey:@"opt3_text"]; 
		option = [[NodeOption alloc] initWithText:text andNodeId: optionNodeId];
		[node addOption:option];
	}
	
	return node;	
}

-(Npc *)parseNpcFromDictionary: (NSDictionary *)npcDictionary {
	Npc *npc = [[Npc alloc] init];
	npc.npcId = [[npcDictionary valueForKey:@"npc_id"] intValue];
	npc.name = [npcDictionary valueForKey:@"name"];
	npc.greeting = [npcDictionary valueForKey:@"text"];
	npc.description = [npcDictionary valueForKey:@"description"];
	npc.mediaId = [[npcDictionary valueForKey:@"media_id"] intValue];
	
	NSArray *conversationOptions = [npcDictionary objectForKey:@"conversationOptions"];
	NSEnumerator *conversationOptionsEnumerator = [conversationOptions objectEnumerator];
	NSDictionary *conversationDictionary;
	while (conversationDictionary = [conversationOptionsEnumerator nextObject]) {	
		//Make the Node Option and add it to the Npc
		int optionNodeId = [[conversationDictionary valueForKey:@"node_id"] intValue];
		NSString *text = [conversationDictionary valueForKey:@"text"]; 
		NodeOption *option = [[NodeOption alloc] initWithText:text andNodeId: optionNodeId];
		[npc addOption:option];
	}
	return npc;	
}

-(NSArray *)parseGameListFromArray: (NSArray *)gameListArray{
	NSMutableArray *tempGameList = [[NSMutableArray alloc] init];
	
	NSEnumerator *gameListEnumerator = [gameListArray objectEnumerator];	
	NSDictionary *gameDictionary;
	while (gameDictionary = [gameListEnumerator nextObject]) {
		//create a new game
		Game *game = [[Game alloc] init];
		game.gameId = [[gameDictionary valueForKey:@"game_id"] intValue];
		game.name = [gameDictionary valueForKey:@"name"];
		NSString *prefix = [gameDictionary valueForKey:@"prefix"];
		//parse out the trailing _ in the prefix
		game.site = [prefix substringToIndex:[prefix length] - 1];
		NSLog(@"Model: Adding Game: %@", game.name);
		[tempGameList addObject:game]; 
	}
	
	return tempGameList;

}

-(NSArray *)parseLocationListFromArray: (NSArray *)locationsArray{

	//Build the location list
	NSMutableArray *tempLocationsList = [[NSMutableArray alloc] init];
	NSEnumerator *locationsEnumerator = [locationsArray objectEnumerator];	
	NSDictionary *locationDictionary;
	while (locationDictionary = [locationsEnumerator nextObject]) {
		//create a new location
		Location *location = [[Location alloc] init];
		location.locationId = [[locationDictionary valueForKey:@"location_id"] intValue];
		location.name = [locationDictionary valueForKey:@"name"];
		location.iconMediaId = [[locationDictionary valueForKey:@"icon_media_id"] intValue];
		location.location = [[CLLocation alloc] initWithLatitude:[[locationDictionary valueForKey:@"latitude"] doubleValue]
													   longitude:[[locationDictionary valueForKey:@"longitude"] doubleValue]];
		location.error = [[locationDictionary valueForKey:@"error"] doubleValue];
		location.objectType = [locationDictionary valueForKey:@"type"];
		location.objectId = [[locationDictionary valueForKey:@"type_id"] intValue];
		location.hidden = [[locationDictionary valueForKey:@"hidden"] boolValue];
		location.forcedDisplay = [[locationDictionary valueForKey:@"force_view"] boolValue];
		location.qty = [[locationDictionary valueForKey:@"item_qty"] intValue];
		
		NSLog(@"Model: Adding Location: %@", location.name);
		[tempLocationsList addObject:location];
		[location release];
	}
	
	return tempLocationsList;
	
}


-(NSMutableDictionary *)parseMediaListFromArray: (NSArray *)mediaListArray{

	NSMutableDictionary *tempMediaList = [[NSMutableDictionary alloc] init];
	NSEnumerator *enumerator = [((NSArray *)mediaListArray) objectEnumerator];
	NSDictionary *dict;
	while (dict = [enumerator nextObject]) {
		NSInteger uid = [[dict valueForKey:@"media_id"] intValue];
		NSString *fileName = [dict valueForKey:@"file_name"];
		
		NSString *type = [dict valueForKey:@"type"];
		
		if (uid < 1) {
			NSLog(@"AppModel fetchMediaList: Invalid media id: %d", uid);
			continue;
		}
		if ([fileName length] < 1) {
			NSLog(@"AppModel fetchMediaList: Empty fileName string for media #%d.", uid);
			continue;
		}
		if ([type length] < 1) {
			NSLog(@"AppModel fetchMediaList: Empty type for media #%d", uid);
			continue;
		}
		
		fileName = [NSString stringWithFormat:@"%@gamedata/%d/%@", baseAppURL, gameId, fileName];
		NSLog(@"AppModel fetchMediaList: Full URL: %@", fileName);
		
		Media *media = [[Media alloc] initWithId:uid andUrlString:fileName ofType:type];
		[tempMediaList setObject:media forKey:[NSNumber numberWithInt:uid]];
		[media release];
	}
	
	return tempMediaList;
}


-(NSArray *)parseInventoryFromArray: (NSArray *)inventoryArray{
	NSMutableArray *tempInventory = [[NSMutableArray alloc] init];
	NSEnumerator *inventoryEnumerator = [((NSArray *)inventoryArray) objectEnumerator];	
	NSDictionary *itemDictionary;
	while (itemDictionary = [inventoryEnumerator nextObject]) {
		Item *item = [[Item alloc] init];
		item.itemId = [[itemDictionary valueForKey:@"item_id"] intValue];
		item.name = [itemDictionary valueForKey:@"name"];
		item.description = [itemDictionary valueForKey:@"description"];
		item.mediaId = [[itemDictionary valueForKey:@"media_id"] intValue];
		item.iconMediaId = [[itemDictionary valueForKey:@"icon_media_id"] intValue];
		item.dropable = [[itemDictionary valueForKey:@"dropable"] boolValue];
		item.destroyable = [[itemDictionary valueForKey:@"destroyable"] boolValue];
		NSLog(@"Model: Adding Item: %@", item.name);
		[tempInventory addObject:item]; 
		[item release];
	}

	return tempInventory;
	
}


-(NSObject<QRCodeProtocol> *)parseQRCodeObjectFromDictionary: (NSDictionary *)qrCodeObjectDictionary {

	NSString *type = [qrCodeObjectDictionary valueForKey:@"type"];
	NSLog(@"QRCode Type: %@",type);

	if ([type isEqualToString:@"Node"]) return [self parseNodeFromDictionary:qrCodeObjectDictionary];
	if ([type isEqualToString:@"Item"]) return [self parseItemFromDictionary:qrCodeObjectDictionary];
	if ([type isEqualToString:@"Npc"]) return [self parseNpcFromDictionary:qrCodeObjectDictionary];

	return nil;
}



-(NSMutableDictionary *)parseQuestListFromDictionary: (NSDictionary *)questListDictionary{

	//parse out the active quests into quest objects
	NSMutableArray *activeQuestObjects = [[NSMutableArray alloc] init];
	NSArray *activeQuests = [questListDictionary objectForKey:@"active"];
	NSEnumerator *activeQuestsEnumerator = [activeQuests objectEnumerator];
	NSDictionary *activeQuest;
	while (activeQuest = [activeQuestsEnumerator nextObject]) {
		//We have a quest, parse it into a quest abject and add it to the activeQuestObjects array
		Quest *quest = [[Quest alloc] init];
		quest.questId = [[activeQuest objectForKey:@"quest_id"] intValue];
		quest.name = [activeQuest objectForKey:@"name"];
		quest.description = [activeQuest objectForKey:@"description"];
		quest.mediaId = [[activeQuest objectForKey:@"mediaURL"] intValue];
		[activeQuestObjects addObject:quest];
	}

	//parse out the completed quests into quest objects	
	NSMutableArray *completedQuestObjects = [[NSMutableArray alloc] init];
	NSArray *completedQuests = [questListDictionary objectForKey:@"completed"];
	NSEnumerator *completedQuestsEnumerator = [completedQuests objectEnumerator];
	NSDictionary *completedQuest;
	while (completedQuest = [completedQuestsEnumerator nextObject]) {
		//We have a quest, parse it into a quest abject and add it to the completedQuestObjects array
		Quest *quest = [[Quest alloc] init];
		quest.questId = [[completedQuest objectForKey:@"quest_id"] intValue];
		quest.name = [completedQuest objectForKey:@"name"];
		quest.description = [completedQuest objectForKey:@"text_when_complete"];
		quest.mediaId = [[completedQuest objectForKey:@"mediaURL"] intValue];
		[completedQuestObjects addObject:quest];
	}

	//Package the two object arrays in a Dictionary
	NSMutableDictionary *tmpQuestList = [[NSMutableDictionary alloc] init];
	[tmpQuestList setObject:activeQuestObjects forKey:@"active"];
	[tmpQuestList setObject:completedQuestObjects forKey:@"completed"];

	return tmpQuestList;
}


#pragma mark Syncronizers

- (NSMutableArray *)nearbyLocationsList {
	NSMutableArray *result = nil;
	@synchronized (nearbyLock) {
		result = [nearbyLocationsList retain];
	}
	return result;
}

- (void)setNearbyLocationList:(NSMutableArray *)source {
	@synchronized (nearbyLock) {
		nearbyLocationsList = [source copy];
	}
}

- (NSMutableArray *)locationList {
	NSMutableArray *result = nil;
	@synchronized (locationsLock) {
		result = [locationList retain];
	}
	return result;
}

- (void)setLocationList:(NSMutableArray *)source {
	@synchronized (locationsLock) {
		locationList = [source copy];
	}
}


- (NSMutableArray *)playerList {
	NSMutableArray *result = nil;
	@synchronized (locationsLock) {
		result = [playerList retain];
	}
	return result;
}

- (void)setPlayerList:(NSMutableArray *)source {
	@synchronized (locationsLock) {
		playerList = [source copy];
	}
}

@end
