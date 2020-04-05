--[[----------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
 Copyright 2007 Adobe Systems Incorporated
 All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

--------------------------------------------------------------------------------

ShowCustomDialog.lua
From the Hello World sample plug-in. Displays a custom dialog and writes debug info.

------------------------------------------------------------------------------]]

-- Access the Lightroom SDK namespaces.
local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'

local LrLogger = import 'LrLogger' 

local myLogger = LrLogger( 'libraryLogger' ) myLogger:enable( "print" ) -- or "logfile" 

local LrApplication       = import 'LrApplication'
local LrTasks = import 'LrTasks'


local function UpdateCollectionSet(MainFolderName, mainCollectionSet, catalog )
 
	myLogger:trace("UpdateCollectionSet")
	myLogger:trace(MainFolderName)
	myLogger:trace(mainCollectionSet)
  
	catalog:withWriteAccessDo("create cat", function( context ) 
 
		local sCol = catalog:createSmartCollection("All",  
													{
														{
															criteria = "folder",
															operation = "all",
															value = MainFolderName,
														},
														combine = "intersect",
													}
													, mainCollectionSet
													, true)
													
		sCol:setSearchDescription (
											{					
												{
													criteria = "folder",
													operation = "all",
													value = MainFolderName,
												},
												combine = "intersect",
												}
										)
										
										
		
		---------
		sCol = catalog:createSmartCollection("_Rating",  
											{
												{
													criteria = "folder",
													operation = "all",
													value = MainFolderName,
												},
												{
													 criteria = "rating",
													 operation = ">=",
													 value = 1,
												},
												
												combine = "intersect",
											}
										, mainCollectionSet
										, true)
				
				
		sCol:setSearchDescription (
									{					
										{
											criteria = "folder",
											operation = "all",
											value = MainFolderName,
										},
										{
											 criteria = "rating",
											 operation = ">=",
											 value = 1,
										},
										combine = "intersect",
										}
								)
		
		-----------------------------------------------
				
		sCol = catalog:createSmartCollection("_Picked",  
								{
									{
										criteria = "folder",
										operation = "all",
										value = MainFolderName,
									},
									{
										criteria = "pick",
										operation = "==",
										value = 1,
									},
									combine = "intersect",
								}
							, mainCollectionSet
							, true)
				
		sCol:setSearchDescription (
									{					
										{
											criteria = "folder",
											operation = "all",
											value = MainFolderName,
										},
										{
											criteria = "pick",
											operation = "==",
											value = 1,
										},
										combine = "intersect",
										}
								)									
													
		-------------------------------------------------------											
													
		sCol = catalog:createSmartCollection("Red",  
												{					 
													{
														criteria = "folder",
														operation = "all",
														value = MainFolderName,
													},
													
													{
														criteria = "labelColor",
														operation = "==",
														value = 1,
													},
													combine = "intersect",
												}
												, mainCollectionSet
												, true)
														
		sCol:setSearchDescription (
										{					
											{
												criteria = "folder",
												operation = "all",
												value = MainFolderName,
											},
											
											{
												criteria = "labelColor",
												operation = "==",
												value = 1,
											},
											combine = "intersect",
											}
									)
										
										
		-----------------------------------------------------								
																
		sCol = catalog:createSmartCollection("Green",  
														{					 
															{
																criteria = "folder",
																operation = "all",
																value = MainFolderName,
															},
															
															{
																criteria = "labelColor",
																operation = "==",
																value = 3,
															},
															combine = "intersect",
														}
														, mainCollectionSet
														, true)
					
					
		sCol:setSearchDescription (
									{					
										{
											criteria = "folder",
											operation = "all",
											value = MainFolderName,
										},
										
										{
											criteria = "labelColor",
											operation = "==",
											value = 3,
										},
										combine = "intersect",
										}
								)	
		
		
		myLogger:trace("childs")
		
		  for key, child in pairs(mainCollectionSet:getChildCollectionSets()) do  
                local name = child:getName()  
				myLogger:trace(name)
				
				FilterText = child:getName()
							
				
			local setCollectionSet = catalog:createCollectionSet(FilterText, mainCollectionSet, true )
						
			---ffhdf
			
			sCol = catalog:createSmartCollection("zAll",  
												{
													{
														criteria = "folder",
														operation = "all",
														value = MainFolderName,
													},
													{
														criteria = "keywords",
														operation = "words",
														value = FilterText,
													},
													combine = "intersect",
												}
												, setCollectionSet
												, true)
			
			sCol:setSearchDescription (
										{					
											{
												criteria = "folder",
												operation = "all",
												value = MainFolderName,
											},
											{
												criteria = "keywords",
												operation = "words",
												value = FilterText,
											},
										combine = "intersect",
										}			
									)												
				
			--------------------
			sCol = catalog:createSmartCollection("2_Rating",  
													{
														{
															criteria = "folder",
															operation = "all",
															value = MainFolderName,
														},
														{
															criteria = "keywords",
															operation = "words",
															value = FilterText,
														},
														{
															criteria = "rating",
															operation = ">=",
															value = 1,
														},
														combine = "intersect",
													}
													, setCollectionSet
													, true)
				
				
			sCol:setSearchDescription (
								{					
									{
										criteria = "folder",
										operation = "all",
										value = MainFolderName,
									},
									{
										criteria = "keywords",
										operation = "words",
										value = FilterText,
									},
									{
										criteria = "rating",
										operation = ">=",
										value = 1,
									},
									combine = "intersect",
									}
							)

				

			
			--------------------
			sCol = catalog:createSmartCollection("1_Picked",  
													{					 
														{
															criteria = "folder",
															operation = "all",
															value = MainFolderName,
														},
														{
															criteria = "keywords",
															operation = "words",
															value = FilterText,
														},
														{
															criteria = "pick",
															operation = "==",
															value = 1,
														},
														combine = "intersect",
													}
													, setCollectionSet
													, true)
													
			
			sCol:setSearchDescription (
								{					
									{
										criteria = "folder",
										operation = "all",
										value = MainFolderName,
									},
									{
										criteria = "keywords",
										operation = "words",
										value = FilterText,
									},
									{
										criteria = "pick",
										operation = "==",
										value = 1,
									},
									combine = "intersect",
									}
							)
			
			--------------------
			sCol = catalog:createSmartCollection("3_Red",  
													{					 
														{
															criteria = "folder",
															operation = "all",
															value = MainFolderName,
														},
														{
															criteria = "keywords",
															operation = "words",
															value = FilterText,
														},
														{
															criteria = "labelColor",
															operation = "==",
															value = 1,
														},
														combine = "intersect",
													}
													, setCollectionSet
													, true)
													
			
			sCol:setSearchDescription (
								{					
									{
										criteria = "folder",
										operation = "all",
										value = MainFolderName,
									},
									{
										criteria = "keywords",
										operation = "words",
										value = FilterText,
									},
									{
										criteria = "labelColor",
										operation = "==",
										value = 1,
									},
									combine = "intersect",
									}
							)
			
			--------------------
			sCol = catalog:createSmartCollection("4_Green",  
													{					 
														{
															criteria = "folder",
															operation = "all",
															value = MainFolderName,
														},
														{
															criteria = "keywords",
															operation = "words",
															value = FilterText,
														},
														{
															criteria = "labelColor",
															operation = "==",
															value = 3,
														},
														combine = "intersect",
													}
													, setCollectionSet
													, true)
													
				sCol:setSearchDescription (
								{					
									{
										criteria = "folder",
										operation = "all",
										value = MainFolderName,
									},
									{
										criteria = "keywords",
										operation = "words",
										value = FilterText,
									},
									{
										criteria = "labelColor",
										operation = "==",
										value = 3,
									},
									combine = "intersect",
									}
							)
				
				
				
				
				
			end   
		
		end)  
		
		LrDialogs.message("done")
end


--[[
	Demonstrates a custom dialog with a simple binding. The dialog displays a
	checkbox and a text field.  When the check box is selected the text field becomes
	enabled, if the checkbox is unchecked then the text field is disabled.
	
	The check_box.value and the edit_field.enabled are bound to the same value in an
	observable table.  When the check_box is checked/unchecked the changes are reflected
	in the bound property 'isChecked'.  Because the edit_field.enabled value is also bound then
	it reflects whatever value 'isChecked' has.
]]
local function UpdateCollection()

	LrFunctionContext.callWithContext( "UpdateCollection", function( context )
	
	myLogger:trace("UpdateCollection cmd")
 
	LrTasks.startAsyncTask (function()
 
		local catalog = LrApplication.activeCatalog()
	
		local sources = catalog:getActiveSources() 
	
		for _notUsed, source in ipairs(sources) do
		 
			if source:type() == 'LrCollection' then
			   -- do something
			elseif source:type() == 'LrCollectionSet' then
			   -- do something
				sourceName = source:getName()
			   myLogger:trace("LrCollectionSet")
			   myLogger:trace(sourceName)
			   
			   UpdateCollectionSet(sourceName, source, catalog)
			   			   
			elseif source:type() == 'LrFolder' then
			   myLogger:trace("LrCollectionSet")
			   sourceName = source:getName()
			   myLogger:trace(sourceName)
			
			elseif source:type() == 'LrPublishedCollection' then
			   -- do something
			elseif source:type() == 'LrPublishedCollectionSet' then
			   -- do something
			elseif source:type() == 'LrFolder' then
			   -- do something
			end
		 
		end
	end) 
	
	
	end) -- end main function

end




-- Now display the dialogs.
UpdateCollection()
