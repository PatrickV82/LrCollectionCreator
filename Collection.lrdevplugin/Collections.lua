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


--[[
	Demonstrates a custom dialog with a simple binding. The dialog displays a
	checkbox and a text field.  When the check box is selected the text field becomes
	enabled, if the checkbox is unchecked then the text field is disabled.
	
	The check_box.value and the edit_field.enabled are bound to the same value in an
	observable table.  When the check_box is checked/unchecked the changes are reflected
	in the bound property 'isChecked'.  Because the edit_field.enabled value is also bound then
	it reflects whatever value 'isChecked' has.
]]
local function showCustomDialog()

	LrFunctionContext.callWithContext( "showCustomDialog", function( context )
	
	
    
		local f = LrView.osFactory()
		
		-- Create a bindable table.  Whenever a field in this table changes
	    -- then notifications will be sent.
	  	local props = LrBinding.makePropertyTable( context )
		props.MainKeyword = "West Ales"
		props.NrOfSets = 10
	
	    

		local KeyWordField = f:edit_field {
			immediate = true,
			value = "Enter some text!!"
		}
		
		local NrOfSetsField = f:edit_field {
			immediate = true,
			value = 1
		}
		
	    -- Create the contents for the dialog.
		local c = f:column {
			spacing = f:dialog_spacing(),
			f:row {
		
				-- Bind the table to the view.  This enables controls to be bound
				-- to the named field of the 'props' table.
				
				bind_to_object = props,
					
				-- Add a checkbox and an edit_field.
				
			   f:static_text {
					alignment = "right",
					width = LrView.share "label_width",
					title = "Main keyword: "
				},
				f:edit_field {
					immediate = true,
					value = LrView.bind( "MainKeyword" )
				}	
			},
			f:row {
		
				-- Bind the table to the view.  This enables controls to be bound
				-- to the named field of the 'props' table.
				
				bind_to_object = props,
					
				-- Add a checkbox and an edit_field.
				
			   f:static_text {
					alignment = "right",
					width = LrView.share "label_width",
					title = "Number Of sets: "
				},
				f:edit_field {
					immediate = true,
					value = LrView.bind( "NrOfSets" )
				}	
			}
		}
	
		LrTasks.startAsyncTask (function()                                             
			
			local catalog = LrApplication.activeCatalog()
			local sources = catalog:getActiveSources() 
		
			for _notUsed, source in ipairs(sources) do
			 if source:type() == 'LrFolder' then
				   sourceName = source:getName()
				   props.MainKeyword = sourceName  
				end
			end
		end)
	
	    local verb = LrDialogs.presentModalDialog {
			    title = "Custom Dialog",
			    contents = c
		    }
			
		if verb == "ok" then 

			myLogger:trace("Ok was pressed")
			myLogger:trace(props.MainKeyword)
			myLogger:trace(props.NrOfSets)
			LrTasks.startAsyncTask (function()                                             
    
				local maincat = LrApplication.activeCatalog()
				maincat:withWriteAccessDo("create cat", function( context ) 
							 
				
				
				
				-- do something that reads or writes catalog 
				local topCollectionSet = maincat:createCollectionSet(props.MainKeyword, nil, true)
			
				local sCol = maincat:createSmartCollection("All",  
													{
														{
															criteria = "folder",
															operation = "all",
															value = props.MainKeyword,
														},
														combine = "intersect",
													}
													, topCollectionSet
													, true)
													
				sCol:setSearchDescription (
											{					
												{
													criteria = "folder",
													operation = "all",
													value = props.MainKeyword,
												},
												combine = "intersect",
												}
										)
										
				
				sCol = maincat:createSmartCollection("_Rating : *",  
														{
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															{
																 criteria = "rating",
																 operation = "==",
																 value = 1,
															},
															
															combine = "intersect",
														}
													, topCollectionSet
													, true)
													
				sCol = maincat:createSmartCollection("_Rating : **",  
														{
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															{
																 criteria = "rating",
																 operation = "==",
																 value = 2,
															},
															
															combine = "intersect",
														}
													, topCollectionSet
													, true)
				
				sCol = maincat:createSmartCollection("_Rating : ***",  
														{
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															{
																 criteria = "rating",
																 operation = "==",
																 value = 3,
															},
															
															combine = "intersect",
														}
													, topCollectionSet
													, true)
													
				sCol = maincat:createSmartCollection("_Rating : ****",  
														{
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															{
																 criteria = "rating",
																 operation = "==",
																 value = 4,
															},
															
															combine = "intersect",
														}
													, topCollectionSet
													, true)
													
				sCol = maincat:createSmartCollection("_Rating : *****",  
														{
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															{
																 criteria = "rating",
																 operation = "==",
																 value = 5,
															},
															
															combine = "intersect",
														}
													, topCollectionSet
													, true)
				
				sCol = maincat:createSmartCollection("_Picked",  
														{
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															{
																criteria = "pick",
																operation = "==",
																value = 1,
															},
															combine = "intersect",
														}
													, topCollectionSet
													, true)
				
				sCol:setSearchDescription (
											{					
												{
													criteria = "folder",
													operation = "all",
													value = props.MainKeyword,
												},
												{
													criteria = "pick",
													operation = "==",
													value = 1,
												},
												combine = "intersect",
												}
										)									
													
													
													
				sCol = maincat:createSmartCollection("Red",  
														{					 
															{
																criteria = "folder",
																operation = "all",
																value = props.MainKeyword,
															},
															
															{
																criteria = "labelColor",
																operation = "==",
																value = 1,
															},
															combine = "intersect",
														}
														, topCollectionSet
														, true)
														
				sCol:setSearchDescription (
											{					
												{
													criteria = "folder",
													operation = "all",
													value = props.MainKeyword,
												},
												
												{
													criteria = "labelColor",
													operation = "==",
													value = 1,
												},
												combine = "intersect",
												}
										)
										
										
																
				sCol = maincat:createSmartCollection("Green",  
																{					 
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	
																	{
																		criteria = "labelColor",
																		operation = "==",
																		value = 3,
																	},
																	combine = "intersect",
																}
																, topCollectionSet
																, true)
					
					
				sCol:setSearchDescription (
											{					
												{
													criteria = "folder",
													operation = "all",
													value = props.MainKeyword,
												},
												
												{
													criteria = "labelColor",
													operation = "==",
													value = 3,
												},
												combine = "intersect",
												}
										)	
			
				for i=1,props.NrOfSets,1
					do
						
						FilterText = "Set"
						FilterText = FilterText .. i
						myLogger:trace(FilterText)
						
						SetItemsColName = "Items: Set ".. i
						myLogger:trace(SetItemsColName)
						
						local setCollectionSet = maincat:createCollectionSet(FilterText, topCollectionSet, true )
						
						
						myLogger:trace("Create collection set")
						---ffhdf
							---ffhdf
						maincat:createCollection(SetItemsColName, setCollectionSet	, true)
						
						myLogger:trace("Created main col")
						
							
						--------------------
						sCol = maincat:createSmartCollection("2_Rating : *",  
																{
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = "==",
																		value = 1,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
							--------------------
							
						sCol = maincat:createSmartCollection("2_Rating : **",  
																{
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = "==",
																		value = 2,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
							
											
--------------------
						sCol = maincat:createSmartCollection("2_Rating : ***",  
																{
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = "==",
																		value = 3,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
						
						--------------------
						sCol = maincat:createSmartCollection("2_Rating : ****",  
																{
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = "==",
																		value = 4,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
						
						--------------------
						sCol = maincat:createSmartCollection("2_Rating : *****",  
																{
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = "==",
																		value = 5,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
						
						--------------------
						sCol = maincat:createSmartCollection("1_Picked",  
																{					 
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
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
													value = props.MainKeyword,
												},
												{
													criteria = "collection",
													operation = "beginsWith",
													value = SetItemsColName,
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
						sCol = maincat:createSmartCollection("3_Red",  
																{					 
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
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
													value = props.MainKeyword,
												},
												{
													criteria = "collection",
													operation = "beginsWith",
													value = SetItemsColName,
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
						sCol = maincat:createSmartCollection("5_Green",  
																{					 
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
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
													value = props.MainKeyword,
												},
												{
													criteria = "collection",
													operation = "beginsWith",
													value = SetItemsColName,
												},
												{
													criteria = "labelColor",
													operation = "==",
													value = 3,
												},
												combine = "intersect",
												}
										)
						
						--------------------
						sCol = maincat:createSmartCollection("4_Yellow",  
																{					 
																	{
																		criteria = "folder",
																		operation = "all",
																		value = props.MainKeyword,
																	},
																	{
																		criteria = "collection",
																		operation = "beginsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "labelColor",
																		operation = "==",
																		value = 2,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
					end
				end ) 
			end)        
		end
	end) -- end main function

end


-- Now display the dialogs.
showCustomDialog()
