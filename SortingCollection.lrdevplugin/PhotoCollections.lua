

-- Access the Lightroom SDK namespaces.
local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'

local LrLogger = import 'LrLogger' 

local myLogger = LrLogger( 'libraryLogger' ) myLogger:enable( "print" ) -- or "logfile" 

local LrApplication       = import 'LrApplication'
local LrTasks = import 'LrTasks'


function CreateNewPhotoCollection(catalog, photos)
	-- do something that reads or writes catalog 
	local topCollectionSet = catalog:createCollectionSet("Sets", nil, true)
	myLogger:trace("ncreateCollectionSet")

	local topSetChilds = topCollectionSet:getChildren()
	if not topSetChilds then
		myLogger:trace("null")
		-- Some code
	else
		myLogger:trace("not null")

		local NumberChilds = #topSetChilds
		myLogger:trace( NumberChilds)

		local i = NumberChilds + 1
		FilterText = "Set "
		FilterText = FilterText .. i
		myLogger:trace(FilterText)
		
		SetItemsColName = "Items: Set ".. i
		myLogger:trace(SetItemsColName)
		-- Some code

		local setCollectionSet = catalog:createCollectionSet(FilterText, topCollectionSet, true )
		
		myLogger:trace("Create collection set")



		local photoCol =  catalog:createCollection(SetItemsColName, setCollectionSet	, true)
		
		photoCol:addPhotos(photos)
													
						--------------------
						sCol = catalog:createSmartCollection("2_Rating : *",  
																{
																	{
																		criteria = "collection",
																		operation = "endsWith",
																		value = SetItemsColName,
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
																criteria = "collection",
																operation = "endsWith",
																value = SetItemsColName,
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
							
						sCol = catalog:createSmartCollection("2_Rating : **",  
																{
																	{
																		criteria = "collection",
																		operation = "endsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = ">=",
																		value = 2,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)

																sCol:setSearchDescription (
																	{
																		{
																			criteria = "collection",
																			operation = "endsWith",
																			value = SetItemsColName,
																		},
																		{
																			criteria = "rating",
																			operation = ">=",
																			value = 2,
																		},
																		combine = "intersect",
																	}
																)				
							
											
--------------------
						sCol = catalog:createSmartCollection("2_Rating : ***",  
																{
																	{
																		criteria = "collection",
																		operation = "endsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = ">=",
																		value = 3,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)
																
																sCol:setSearchDescription (
																	{
																		{
																			criteria = "collection",
																			operation = "endsWith",
																			value = SetItemsColName,
																		},
																		{
																			criteria = "rating",
																			operation = ">=",
																			value = 3,
																		},
																		combine = "intersect",
																	}
																)			
						
						--------------------
						sCol = catalog:createSmartCollection("2_Rating : ****",  
																{
																	{
																		criteria = "collection",
																		operation = "endsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = ">=",
																		value = 4,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)

																sCol:setSearchDescription (
																	{
																		
																		{
																			criteria = "collection",
																			operation = "endsWith",
																			value = SetItemsColName,
																		},
																		{
																			criteria = "rating",
																			operation = ">=",
																			value = 4,
																		},
																		combine = "intersect",
																	}
																)			
						
						--------------------
						sCol = catalog:createSmartCollection("2_Rating : *****",  
																{
																	
																	{
																		criteria = "collection",
																		operation = "endsWith",
																		value = SetItemsColName,
																	},
																	{
																		criteria = "rating",
																		operation = ">=",
																		value = 5,
																	},
																	combine = "intersect",
																}
																, setCollectionSet
																, true)

																sCol:setSearchDescription (
																	{
																		
																		{
																			criteria = "collection",
																			operation = "endsWith",
																			value = SetItemsColName,
																		},
																		{
																			criteria = "rating",
																			operation = ">=",
																			value = 5,
																		},
																		combine = "intersect",
																	}
																)			
						
						--------------------
						sCol = catalog:createSmartCollection("1_Picked",  
																{					 
																	
																	{
																		criteria = "collection",
																		operation = "endsWith",
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
													criteria = "collection",
													operation = "endsWith",
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
						sCol = catalog:createSmartCollection("3_Red",  
																{					 
																	
																	{
																		criteria = "collection",
																		operation = "endsWith",
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
													criteria = "collection",
													operation = "endsWith",
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
						sCol = catalog:createSmartCollection("5_Green",  
																{					 
																	
																	{
																		criteria = "collection",
																		operation = "endsWith",
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
													criteria = "collection",
													operation = "endsWith",
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
						sCol = catalog:createSmartCollection("4_Yellow",  
																{					 
																	
																	{
																		criteria = "collection",
																		operation = "endsWith",
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

								sCol:setSearchDescription (
											{					
												{
													criteria = "collection",
													operation = "endsWith",
													value = SetItemsColName,
												},
												{
													criteria = "labelColor",
													operation = "==",
													value = 2,
												},
												combine = "intersect",
												}
										)








	 end 
	--
	
	 
end
	