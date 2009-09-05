<?php
require_once("module.php");

class Npcs extends Module
{
	
	/**
     * Fetch all Npcs
     * @returns the npc rs
     */
	public function getNpcs($intGameID)
	{
		
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");
		
		$query = "SELECT * FROM {$prefix}_npcs";
		
		$rsResult = @mysql_query($query);
		
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
		return new returnData(0, $rsResult);	
		
	}
	
	/**
     * Fetch a specific npc
     * @returns a single npc
     */
	public function getNpc($intGameID, $intNpcID)
	{
		
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");
		
		$query = "SELECT * FROM {$prefix}_npcs WHERE npc_id = {$intNpcID} LIMIT 1";
		
		$rsResult = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");

		$npc = @mysql_fetch_object($rsResult);
		
		if (!$npc) return new returnData(2, NULL, "invalid npc id");
		
		$npc->mediaURL = Config::gamedataWWWPath . "/{$prefix}/" . Config::gameMediaSubdir . $npc->media;
		
		return new returnData(0, $npc);		
	}


	/**
     * Fetch a specific npc with the conversation options that meet the requirements
     * @returns a single npc
     */
	public function getNpcWithConversationsForPlayer($intGameID, $intNpcID, $intPlayerID)
	{
		
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");
		
		//get the npc
		$npcReturnData = Npcs::getNpc($intGameID, $intNpcID);
		if ($npcReturnData->returnCode > 0) return $npcReturnData;
		$npc = $npcReturnData->data;
		
		//get the options for this npc and player
		$conversationsReturnData = Npcs::getConversationsForPlayer($intGameID, $intNpcID, $intPlayerID);
		if ($npcReturnData->returnCode > 0) return $optionsReturnData;
		$conversationsArray = $conversationsReturnData->data;

		$npc->conversationOptions = $conversationsArray;
		
		return new returnData(0, $npc);
		
	}


	/**
     * Create a NPC
     * @returns the new npcID on success
     */
	public function createNpc($intGameID, $strName, $strDescription, $strGreeting, $strMedia)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");
		
		$query = "INSERT INTO {$prefix}_npcs 
					(name, description, text, media)
					VALUES ('{$strName}', '{$strDescription}', '{$strGreeting}','{$strMedia}')";
		
		NetDebug::trace("createNpc: Running a query = $query");	
		
		@mysql_query($query);
		
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
		return new returnData(0, mysql_insert_id());		
	}

	
	
	/**
     * Update a specific NPC
     * @returns true if a record was updated, false if it was not
     */
	public function updateNpc($intGameID, $intNpcID, 
								$strName, $strDescription, $strGreeting, $strMedia)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");		
		
		$query = "UPDATE {$prefix}_npcs 
					SET name = '{$strName}', description = '{$strDescription}',
					text = '{$strGreeting}', media = '{$strMedia}'
					WHERE npc_id = '{$intNpcID}'";
		
		NetDebug::trace("updateNpc: Running a query = $query");	
		
		@mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
	
		if (mysql_affected_rows()) return new returnData(0, TRUE);
		else return new returnData(0, FALSE);

	}
	
	
	/**
     * Delete a specific NPC
     * @returns a single node
     */
	public function deleteNpc($intGameID, $intNpcID)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");		
		
		$query = "DELETE FROM {$prefix}_npcs WHERE npc_id = {$intNpcID}";
		
		$rsResult = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
		
		if (mysql_affected_rows()) return new returnData(0);
		else return new returnData(2, 'invalid npc id');
		
	}	
	

	/**
     * Create a conversation option for the NPC to link to a node
     * @returns the new conversationID on success
     */
	public function createConversation($intGameID, $intNpcID, $intNodeID, $strText)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");		
		
		$query = "INSERT INTO {$prefix}_npc_conversations 
					(npc_id, node_id, text)
					VALUES ('{$intNpcID}', '{$intNodeID}', '{$strText}')";
		
		NetDebug::trace("createConversation: Running a query = $query");	
		
		@mysql_query($query);
		
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
		
		return new returnData(0, mysql_insert_id());		
	}
	
	
	
	
	/**
     * Fetch the conversations for a given NPC
     * @returns a recordset of conversations
     */
	public function getConversations($intGameID, $intNpcID) {
		
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");		
		
		$query = "SELECT * FROM {$prefix}_npc_conversations WHERE npc_id = '{$intNpcID}'";
		
		//NetDebug::trace("getConversations: Running a query = $query");	

		$rsResult = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");

		return new returnData(0, $rsResult);		
		
	}	
	
	/**
     * Fetch the conversations for a given NPC
     * @returns a recordset of conversations
     */
	public function getConversationsForPlayer($intGameID, $intNpcID, $intPlayerID) {
		
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");		
		
		$conversationsReturnData = Npcs::getConversations($intGameID, $intNpcID);	
		if ($conversationsReturnData->returnCode != 0) return $conversationsReturnData;
		
		$conversations = $conversationsReturnData->data;

		$conversationsWithRequirementsMet = array();
		while ($conversation = mysql_fetch_object($conversations)) {
			//Check the requirements are met
			
			//Add it to the result
			$conversationsWithRequirementsMet[] = $conversation;
		}
		
		return new returnData(0, $conversationsWithRequirementsMet);

	}	
	
	/**
     * Update Conversation
     * @returns true if a record was updated, false if no changes were made (could be becasue conversation id is invalid)
     */
	public function updateConversation($intGameID, $intConverationID, $intNewNPC, $intNewNode, $strNewText)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");
		
		$query = "UPDATE {$prefix}_npc_conversations 
		SET npc_id = '{$intNewNPC}', node_id = '{$intNewNode}', text = '{$strNewText}'
		WHERE conversation_id = {$intConverationID}";
		
		$rsResult = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
	
		if (mysql_affected_rows()) return new returnData(0, TRUE);
		else return new returnData(0, FALSE);
		
	}	
	

	/**
     * Get a list of objects that refer to the specified npc
     * @returns a list of object types and ids
     */
	public function getReferrers($intGameID, $intNpcID)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");

		//Find locations
		$query = "SELECT location_id FROM {$prefix}_locations WHERE 
					type  = 'Npc' and type_id = {$intNpcID}";
		$rsLocations = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error in Locations query");
		
		//Find qrcodes
		$query = "SELECT qrcode_id FROM {$prefix}_qrcodes WHERE 
						type  = 'Npc' and type_id = {$intNpcID}";
		$rsQRCodes = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error in QR query");
				
		
		//Combine them together
		$referrers = array();
		while ($row = mysql_fetch_array($rsLocations)){
			$referrers[] = array('type'=>'Location', 'id' => $row['location_id']);
		}
		while ($row = mysql_fetch_array($rsQRCodes)){
			$referrers[] = array('type'=>'QRCode', 'id' => $row['qrcode_id']);
		}
		
		return new returnData(0,$referrers);
	}	
	
	

	/**
     * Delete a specific NPC Conversation option
     * @returns true on success
     */
	public function deleteConversation($intGameID, $intConverationID)
	{
		$prefix = $this->getPrefix($intGameID);
		if (!$prefix) return new returnData(1, NULL, "invalid game id");
		
		$query = "DELETE FROM {$prefix}_npc_conversations WHERE conversation_id = {$intConverationID}";
		
		$rsResult = @mysql_query($query);
		if (mysql_error()) return new returnData(3, NULL, "SQL Error");
		
		if (mysql_affected_rows()) return new returnData(0);
		else return new returnData(2, 'invalid conversation id');
		
	}	

	
	
}