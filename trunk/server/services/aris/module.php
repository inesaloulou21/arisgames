<?php
require_once('config.class.php');
require_once('returnData.class.php');

abstract class Module
{
	//constants for player_log table enums
	const kLOG_LOGIN = 'LOGIN';
	const kLOG_MOVE = 'MOVE';
	const kLOG_PICKUP_ITEM = 'PICKUP_ITEM';
	const kLOG_DROP_ITEM = 'DROP_ITEM';
	const kLOG_DESTROY_ITEM = 'DESTROY_ITEM';
	const kLOG_VIEW_ITEM = 'VIEW_ITEM';
	const kLOG_VIEW_NODE = 'VIEW_NODE';
	const kLOG_VIEW_NPC = 'VIEW_NPC';
	const kLOG_VIEW_MAP = 'VIEW_MAP';
	const kLOG_VIEW_QUESTS = 'VIEW_QUESTS';
	const kLOG_VIEW_INVENTORY = 'VIEW_INVENTORY';
	const kLOG_ENTER_QRCODE = 'ENTER_QRCODE';
	const kLOG_UPLOAD_MEDIA_ITEM = 'UPLOAD_MEDIA_ITEM';
	
	//constants for gameID_requirements table enums
	const kREQ_PLAYER_HAS_ITEM = 'PLAYER_HAS_ITEM';
	const kREQ_PLAYER_DOES_NOT_HAVE_ITEM = 'PLAYER_DOES_NOT_HAVE_ITEM';
	const kREQ_PLAYER_VIEWED_ITEM = 'PLAYER_VIEWED_ITEM';
	const kREQ_PLAYER_HAS_NOT_VIEWED_ITEM = 'PLAYER_HAS_NOT_VIEWED_ITEM';
	const kREQ_PLAYER_VIEWED_NODE = 'PLAYER_VIEWED_NODE';
	const kREQ_PLAYER_HAS_NOT_VIEWED_NODE = 'PLAYER_HAS_NOT_VIEWED_NODE';
	const kREQ_PLAYER_VIEWED_NPC = 'PLAYER_VIEWED_NPC';
	const kREQ_PLAYER_HAS_NOT_VIEWED_NPC = 'PLAYER_HAS_NOT_VIEWED_NPC';
	const kREQ_PLAYER_HAS_UPLOADED_MEDIA_ITEM = 'PLAYER_HAS_UPLOADED_MEDIA_ITEM';
	const kREQ_PLAYER_HAS_COMPLETED_QUEST = 'PLAYER_HAS_COMPLETED_QUEST';
	
	const kRESULT_DISPLAY_NODE = 'Node';
	const kRESULT_DISPLAY_QUEST = 'QuestDisplay';
	const kRESULT_COMPLETE_QUEST = 'QuestComplete';
	const kRESULT_DISPLAY_LOCATION = 'Location';

	//constants for player_state_changes table enums
	const kPSC_GIVE_ITEM = 'GIVE_ITEM';
	const kPSC_TAKE_ITEM = 'TAKE_ITEM';	
	

	
	public function Module()
	{
		$this->conn = mysql_connect(Config::dbHost, Config::dbUser, Config::dbPass);
      	mysql_select_db (Config::dbSchema);
      	mysql_query("set names utf8");
		mysql_query("set charset set utf8");
	}	
	
	/**
     * Fetch the prefix of a game
     * @returns a prefix string without the trailing _
     */
	public function getPrefix($intGameID) {	
		//Lookup game information
		$query = "SELECT * FROM games WHERE game_id = '{$intGameID}'";
		NetDebug::trace($query);
		$rsResult = @mysql_query($query);
		if (mysql_num_rows($rsResult) < 1) return FALSE;
		$gameRecord = mysql_fetch_array($rsResult);
		return substr($gameRecord['prefix'],0,strlen($row['prefix'])-1);
		
	}
	
	/**
     * Fetch the GameID from a prefix
     * @returns a gameID int
     */
	public function getGameIdFromPrefix($strPrefix) {	
		//Lookup game information
		$query = "SELECT * FROM games WHERE prefix= '{$strPrefix}_'";
		$rsResult = @mysql_query($query);
		if (mysql_num_rows($rsResult) < 1) return FALSE;
		$gameRecord = mysql_fetch_array($rsResult);
		return $gameRecord['game_id'];
		
	}	
	
	
	
    /**
     * Adds the specified item to the specified player.
     */
     protected function giveItemToPlayer($strGamePrefix, $intItemID, $intPlayerID, $qtyToGive=1) {
		Module::adjustQtyForPlayerItem($strGamePrefix, $intItemID, $intPlayerID, $qtyToGive);
    }
	
	
	/**
     * Removes the specified item from the user.
     */ 
    protected function takeItemFromPlayer($strGamePrefix, $intItemID, $intPlayerID, $qtyToTake=1) {
		Module::adjustQtyForPlayerItem($strGamePrefix, $intItemID, $intPlayerID, -$qtyToTake);
    }
 

     protected function removeItemFromAllPlayerInventories($strGamePrefix, $intItemID ) {
		$query = "DELETE FROM {$strGamePrefix}_player_items 
					WHERE item_id = $intItemID";
    	$result = @mysql_query($query);
    	NetDebug::trace($query . mysql_error());    
    }
 
    /**
    * Updates the qty a player has of an item
    */ 
    protected function adjustQtyForPlayerItem($strGamePrefix, $intItemID, $intPlayerID, $amountOfAdjustment) {
		
		//Get any existing record
		$query = "SELECT * FROM {$strGamePrefix}_player_items 
					WHERE player_id = $intPlayerID AND item_id = $intItemID LIMIT 1";
    	$result = @mysql_query($query);
    	NetDebug::trace($query . mysql_error());

    	if ($existingPlayerItem = @mysql_fetch_object($result)) {
    		NetDebug::trace("We have an existing record for that player and item");

 			//Check if this change will make the qty go to < 1, if so delete the record
 			$newQty = $existingPlayerItem->qty + $amountOfAdjustment;
 			if ($newQty < 1) {
 				NetDebug::trace("Adjustment would result in a qty of $newQty so delete the record");
 				$query = "DELETE FROM {$strGamePrefix}_player_items 
					WHERE player_id = $intPlayerID AND item_id = $intItemID";
    			NetDebug::trace($query);
    			@mysql_query($query);
    		}
    		else {
 				//Update the qty
 				NetDebug::trace("Updating Qty to $newQty");
 				$query = "UPDATE {$strGamePrefix}_player_items 
 							SET qty = $newQty
							WHERE player_id = $intPlayerID AND item_id = $intItemID";
    			NetDebug::trace($query);
    			@mysql_query($query);
 			}
    	}
    	else if ($amountOfAdjustment > 0) {
    		//Create a record
    		NetDebug::trace("Creating a new player_item record");

    		$query = "INSERT INTO {$strGamePrefix}_player_items 
										  (player_id, item_id, qty) VALUES ($intPlayerID, $intItemID, $amountOfAdjustment)
										  ON duplicate KEY UPDATE item_id = $intItemID";
			NetDebug::trace($query);
			@mysql_query($query);
    	}
    	else NetDebug::trace("Decrementing the qty of an item the player does not have. Ignored.");
    	
    }
    
	
	/**
     * Decrement the item_qty at the specified location by the specified amount, default of 1
     */ 
    protected function decrementItemQtyAtLocation($strGamePrefix, $intLocationID, $intQty = 1) {
   		//If this location has a null item_qty, decrementing it will still be a null
		$query = "UPDATE {$strGamePrefix}_locations 
					SET item_qty = item_qty-{$intQty}
					WHERE location_id = '{$intLocationID}' AND item_qty > 0";
   		NetDebug::trace($query);	
    	@mysql_query($query);    	
	}
	
	
	/**
     * Adds an item to Locations at the specified latitude, longitude
     */ 
    protected function giveItemToWorld($strGamePrefix, $intItemID, $floatLat, $floatLong, $intQty = 1) {
		//Find any items on the map nearby
		$clumpingRangeInMeters = 10;
		
		$query = "SELECT *,((ACOS(SIN($floatLat * PI() / 180) * SIN(latitude * PI() / 180) + 
					COS($floatLat * PI() / 180) * COS(latitude * PI() / 180) * 
					COS(($floatLong - longitude) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) * 1609.344
				AS `distance` FROM `{$strGamePrefix}_locations` HAVING `distance`<= {$clumpingRangeInMeters} ORDER BY `distance` ASC"; 	
    	$result = @mysql_query($query);
    	NetDebug::trace($query . mysql_error());  
    	
    	if ($closestLocationWithinClumpingRange = @mysql_fetch_object($result)) {
    		//We have a match
    		NetDebug::trace("An item exists nearby, adding to that location");   	

    		$query = "UPDATE {$strGamePrefix}_locations
    				SET item_qty = item_qty + {$intQty}";
			NetDebug::trace($query);   	
			@mysql_query($query);
    	}
		else {
			NetDebug::trace("No item exists nearby, creating a new location");   	

			$itemName = $this->getItemName($strGamePrefix, $intItemID);
			$error = 100; //Use 100 meters
			$icon_media_id = $this->getItemIconMediaId($strGamePrefix, $intItemID); //Set the map icon = the item's icon
			
			$query = "INSERT INTO {$strGamePrefix}_locations (name, type, type_id, icon_media_id, latitude, longitude, error, item_qty)
											  VALUES ('{$itemName}','Item','{$intItemID}', '{$icon_media_id}', '{$floatLat}','{$floatLong}', '{$error}','{$intQty}')";
			NetDebug::trace($query);   	
			@mysql_query($query);
    	}
    }
	
	protected function metersBetweenLatLngs($lat1, $lon1, $lat2, $lon2) { 

		$theta = $lon1 - $lon2; 
		$dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta)); 
		$dist = acos($dist); 
		$dist = rad2deg($dist); 
		$miles = $dist * 60 * 1.1515;
	 	$unit = strtoupper($unit);
		return ($miles * 1609.344); //convert to meters
	}
	
    
    /**
    * Checks if a record Exists
    **/
    protected function recordExists($strPrefix, $strTable, $intRecordID){
    	$key = substr($strTable, 0, strlen($strTable)-1);
    	$query = "SELECT * FROM {$strPrefix}_{$strTable} WHERE {$key} = $intRecordID";
    	$rsResult = @mysql_query($query);
		if (mysql_error()) return FALSE;
		if (mysql_num_rows($rsResult) < 1) return FALSE;
		return true;
    }
	
	/**
    * Looks up an item name
    **/
    protected function getItemName($strPrefix, $intItemID){
    	$query = "SELECT name FROM {$strPrefix}_items WHERE item_id = $intItemID";
    	$rsResult = @mysql_query($query);		
		$row = @mysql_fetch_array($rsResult);	
		return $row['name'];
    }
    
 	/**
    * Looks up an item icon media id
    **/
    protected function getItemIconMediaId($strPrefix, $intItemID){
    	$query = "SELECT name FROM {$strPrefix}_items WHERE item_id = $intItemID";
    	$rsResult = @mysql_query($query);		
		$row = @mysql_fetch_array($rsResult);	
		return $row['icon_media_id'];
    }   
		
	/** 
	 * playerHasLog
	 *
     * Checks if the specified user has the specified log event in the game
	 *
     * @return boolean
     */
    protected function playerHasLog($strPrefix, $intPlayerID, $strEventType, $strEventDetail) {
		
		$intGameID = Module::getGameIdFromPrefix($strPrefix);

		$query = "SELECT * FROM player_log 
					WHERE player_id = '{$intPlayerID}' AND
						game_id = '{$intGameID}' AND
						event_type = '{$strEventType}' AND
						event_detail_1 = '{$strEventDetail}' AND
						deleted = 0";
		NetDebug::trace($query);
		
		$rsResult = @mysql_query($query);
		
		if (mysql_num_rows($rsResult) > 0) return true;
		else return false;
    }
    

	/** 
	 * playerHasItem
	 *
     * Checks if the specified user has the specified item in the specified game.
     * @return boolean
     */
    protected function playerHasItem($intGameID, $intPlayerID, $intItemID) {
    	$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return FALSE;
    
		$query = "SELECT * FROM {$prefix}_player_items 
									  WHERE player_id = '{$intPlayerID}' 
									  AND item_id = '{$intItemID}'";
		
		$rsResult = @mysql_query($query);
		
		if (mysql_num_rows($rsResult) > 0) return true;
		else return false;
    }		
    
    
	/** 
	 * itemQtyInPlayerInventory
	 *
     * Checks if the specified user has the specified item in the specified game.
     * @return qty a player has of a given item
     */
    protected function itemQtyInPlayerInventory($intGameID, $intPlayerID, $intItemID) {
    	$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return FALSE;
    
		$query = "SELECT * FROM {$prefix}_player_items 
									  WHERE player_id = '{$intPlayerID}' 
									  AND item_id = '{$intItemID}'";
		
		$rsResult = @mysql_query($query);
		$playerItem = mysql_fetch_object($rsResult);
		
		return $playerItem->qty;
    }	    
    
	/** 
	 * playerHasUploadedMedia
	 *
     * Checks if the specified user has uploaded media near the specified location.
     * @return boolean
     */
    protected function playerHasUploadedMediaItemWithinDistence($intGameID, $intPlayerID, $dblLatitude, $dblLongitude, $dblDistenceInMeters) {
    	$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return FALSE;

		$query = "SELECT {$prefix}_items.*
					FROM player_log, {$prefix}_items
					WHERE 
						player_log.player_id = '{$intPlayerID}' AND
						player_log.game_id = '{$intGameID}' AND
						player_log.event_type = '". Module::kLOG_UPLOAD_MEDIA_ITEM ."' AND
						player_log.event_detail_1 = {$prefix}_items.item_id AND
						
						(((acos(sin(({$dblLatitude}*pi()/180)) * sin((origin_latitude*pi()/180))+cos(({$dblLatitude}*pi()/180)) * 
						cos((origin_latitude*pi()/180)) * 
						cos((({$dblLongitude} - origin_longitude)*pi()/180))))*180/pi())*60*1.1515*1.609344*1000) < {$dblDistenceInMeters}";						
						
		NetDebug::trace($query);
		$rsResult = @mysql_query($query);
		if (@mysql_num_rows($rsResult) > 0) return true;
		else return false;

    }	    
    
	/** 
	 * objectMeetsRequirements
	 *
     * Checks all requirements for the specified object for the specified user
     * @return boolean
     */	
	protected function objectMeetsRequirements ($strPrefix, $intPlayerID, $strObjectType, $intObjectID) {		
		NetDebug::trace("Checking Requirements for {$strObjectType}:{$intObjectID} for playerID:$intPlayerID in gameID:$strPrefix");

		//Fetch the requirements
		$query = "SELECT * FROM {$strPrefix}_requirements 
					WHERE content_type = '{$strObjectType}' AND content_id = '{$intObjectID}'";
		$rsRequirments = @mysql_query($query);
		
		$andsMet = FALSE;
		$requirementsExist = FALSE;
		while ($requirement = mysql_fetch_array($rsRequirments)) {
			$requirementsExist = TRUE;
			NetDebug::trace("Requirement for {$strObjectType}:{$intObjectID} is {$requirement['requirement']}:{$requirement['requirement_detail_1']}");
			//Check the requirement
			
			$requirementMet = FALSE;
			
			switch ($requirement['requirement']) {
				//Log related
				case Module::kREQ_PLAYER_VIEWED_ITEM:
					$requirementMet = Module::playerHasLog($strPrefix, $intPlayerID, Module::kLOG_VIEW_ITEM, 
						$requirement['requirement_detail_1']);
					break;
				case Module::kREQ_PLAYER_HAS_NOT_VIEWED_ITEM:
					$requirementMet = !Module::playerHasLog($strPrefix, $intPlayerID, Module::kLOG_VIEW_ITEM, 
						$requirement['requirement_detail_1']);
					break;
				case Module::kREQ_PLAYER_VIEWED_NODE:
					$requirementMet = Module::playerHasLog($strPrefix, $intPlayerID, Module::kLOG_VIEW_NODE, 
						$requirement['requirement_detail_1']);
					break;
				case Module::kREQ_PLAYER_HAS_NOT_VIEWED_NODE:
					$requirementMet =  !Module::playerHasLog($strPrefix, $intPlayerID, Module::kLOG_VIEW_NODE, 
						$requirement['requirement_detail_1']);
					break;
				case Module::kREQ_PLAYER_VIEWED_NPC:
					$requirementMet = Module::playerHasLog($strPrefix, $intPlayerID, Module::kLOG_VIEW_NPC, 
						$requirement['requirement_detail_1']);
					break;
				case Module::kREQ_PLAYER_HAS_NOT_VIEWED_NPC:
					$requirementMet = !Module::playerHasLog($strPrefix, $intPlayerID, Module::kLOG_VIEW_NPC, 
						$requirement['requirement_detail_1']);
					break;					
				//Inventory related	
				case Module::kREQ_PLAYER_HAS_ITEM:
					$requirementMet = Module::playerHasItem($strPrefix, $intPlayerID, 
						$requirement['requirement_detail_1']);
					break;
				case Module::kREQ_PLAYER_DOES_NOT_HAVE_ITEM:
					$requirementMet = !Module::playerHasItem($strPrefix, $intPlayerID, 
						$requirement['requirement_detail_1']);
					break;
				//Data Collection
				case Module::kREQ_PLAYER_HAS_UPLOADED_MEDIA_ITEM:
					$requirementMet = Module::playerHasUploadedMediaItemWithinDistence($strPrefix, $intPlayerID, 
						$requirement['requirement_detail_1'], $requirement['requirement_detail_2'], 
						$requirement['requirement_detail_3']);
					break;
				case Module::kREQ_PLAYER_HAS_COMPLETED_QUEST:
					$requirementMet = Module::objectMeetsRequirements ($strPrefix, $intPlayerID, Module::kRESULT_COMPLETE_QUEST, 
						$requirement['requirement_detail_1']);
					break;	
			}//switch
			if ($requirement['boolean_operator'] == "AND" && $requirementMet == FALSE) {
				NetDebug::trace("An AND requirement was not met. Requirements Failed.");
				return FALSE;
			}

			if ($requirement['boolean_operator'] == "AND" && $requirementMet == TRUE) {
				NetDebug::trace("An AND requirement was met. Remembering");
				$andsMet = TRUE;
			}
			
			if ($requirement['boolean_operator'] == "OR" && $requirementMet == TRUE){
				NetDebug::trace("An OR requirement was met. Requirements Passed.");
				return TRUE;
			}
			
			if ($requirement['boolean_operator'] == "AND" && $requirementMet == FALSE) $requirementsMet = FALSE;

		}//while
		NetDebug::trace("At the end of all the requirements for this object and any AND were passed, no ORs were passed.");
		//So no ORs were met, and possibly all ands were met
		if (!$requirementsExist) {
			NetDebug::trace("No requirements exist. Requirements Passed.");
			return TRUE;
		}
		if ($andsMet) {
			NetDebug::trace("All AND requirements exist. Requirements Passed.");
			return TRUE;
		}
		else {
			NetDebug::trace("At end. Requirements Not Passed.");			
			return FALSE;
		}
	}	
	
	
	/** 
	 * applyPlayerStateChanges
	 *
     * Applies any state changes for the given object
     * @return boolean. True if a change was made, false otherwise
     */	
	protected function applyPlayerStateChanges($strPrefix, $intPlayerID, $strEventType, $strEventDetail) {	
		
		$changeMade = FALSE;
		
		//Fetch the state changes
		$query = "SELECT * FROM {$strPrefix}_player_state_changes 
									  WHERE event_type = '{$strEventType}'
									  AND event_detail = '{$strEventDetail}'";
		NetDebug::trace($query);

		$rsStateChanges = @mysql_query($query);
		
		while ($stateChange = mysql_fetch_array($rsStateChanges)) {
			NetDebug::trace("State Change Found");

			//Check the requirement
			switch ($stateChange['action']) {
				case Module::kPSC_GIVE_ITEM:
					//echo 'Running a GIVE_ITEM';
					Module::giveItemToPlayer($strPrefix, $stateChange['action_detail'], $intPlayerID,$stateChange['action_amount']);
					$changeMade = TRUE;
					break;
				case Module::kPSC_TAKE_ITEM:
					//echo 'Running a TAKE_ITEM';
					Module::takeItemFromPlayer($strPrefix, $stateChange['action_detail'], $intPlayerID,$stateChange['action_amount']);
					$changeMade = TRUE;
					break;
			}
		}//stateChanges loop
		
		return $changeMade;
	}
		
	/**
     * Add a row to the player log
     * @returns true on success
     */
	protected function appendLog($intPlayerID, $intGameID, $strEventType, $strEventDetail1=null, $strEventDetail2=null)
	{
			
		$query = "INSERT INTO player_log 
					(player_id, game_id, event_type, event_detail_1,event_detail_2) 
				  VALUES 
				  	({$intPlayerID},{$intGameID},'{$strEventType}','{$strEventDetail1}','{$strEventDetail2}')";
		
		@mysql_query($query);
		
		NetDebug::trace($query);

		
		if (mysql_error()) {
			NetDebug::trace(mysql_error());
			return false;
		}
		
		else return true;
	}		
	
	
	
	
	
}