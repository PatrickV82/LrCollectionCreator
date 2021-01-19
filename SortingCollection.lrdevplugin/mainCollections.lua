

-- Access the Lightroom SDK namespaces.
local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'

local LrLogger = import 'LrLogger' 

local myLogger = LrLogger( 'libraryLogger' ) myLogger:enable( "print" ) -- or "logfile" 

local LrApplication       = import 'LrApplication'
local LrTasks = import 'LrTasks'


function CreateMainSmartCat(catalog)
	-- do something that reads or writes catalog 
	local topCollectionSet = catalog:createCollectionSet("Sorting cat", nil, true)
				
	
	sCol = catalog:createSmartCollection("3_Rating : *",  
											{
												
												{
													 criteria = "rating",
													 operation = ">=",
													 value = 1,
												},
												
												combine = "intersect",
											}
										, topCollectionSet
										, true)
										
	sCol = catalog:createSmartCollection("3_Rating : **",  
											{
												{
													 criteria = "rating",
													 operation = ">=",
													 value = 2,
												},
												
												combine = "intersect",
											}
										, topCollectionSet
										, true)
	
	sCol = catalog:createSmartCollection("3_Rating : ***",  
											{
												
												{
													 criteria = "rating",
													 operation = ">=",
													 value = 3,
												},
												
												combine = "intersect",
											}
										, topCollectionSet
										, true)
										
	sCol = catalog:createSmartCollection("3_Rating : ****",  
											{
												
												{
													 criteria = "rating",
													 operation = ">=",
													 value = 4,
												},
												
												combine = "intersect",
											}
										, topCollectionSet
										, true)
										
	sCol = catalog:createSmartCollection("3_Rating : *****",  
											{
												
												{
													 criteria = "rating",
													 operation = ">=",
													 value = 5,
												},
												
												combine = "intersect",
											}
										, topCollectionSet
										, true)
	
	sCol = catalog:createSmartCollection("2_Picked",  
											{
												
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
										criteria = "pick",
										operation = "==",
										value = 1,
									},
									combine = "intersect",
									}
							)									
										
										
										
	sCol = catalog:createSmartCollection("4_Red",  
											{					 
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
										criteria = "labelColor",
										operation = "==",
										value = 1,
									},
									combine = "intersect",
									}
							)
							
							
													
				sCol = catalog:createSmartCollection("6_Green",  
													{					 
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
										criteria = "labelColor",
										operation = "==",
										value = 3,
									},
									combine = "intersect",
									}
							)
							
							
			sCol = catalog:createSmartCollection("5_Yellow",  
							{					 
								{
									criteria = "labelColor",
									operation = "==",
									value = 2,
								},
								combine = "intersect",
							}
							, topCollectionSet
							, true)
	
	
						sCol:setSearchDescription (
						{					
							{
								criteria = "labelColor",
								operation = "==",
								value = 2,
							},
							combine = "intersect",
							}
						)
	
	
				sCol = catalog:createSmartCollection("5_Yellow_PSD",  
							{					 
								{
									criteria = "labelColor",
									operation = "==",
									value = 2,
								},
								{
									criteria = "pick",
									operation = "==",
									value = 1,
								},
								{
									criteria = "fileFormat",
									operation = "==",
									value = "PSD",
								},
								combine = "intersect",
							}
							, topCollectionSet
							, true)
	
	
						sCol:setSearchDescription (
						{												
							{
								criteria = "labelColor",
								operation = "==",
								value = 2,
							},
							{
								criteria = "pick",
								operation = "==",
								value = 1,
							},
							{
								criteria = "fileFormat",
								operation = "==",
								value = "PSD",
							},
							combine = "intersect",
							}
						)
	
				sCol = catalog:createSmartCollection("6_Green_PSD",  
							{					 
							
								{
									criteria = "labelColor",
									operation = "==",
									value = 3,
								},
								{
									criteria = "pick",
									operation = "==",
									value = 1,
								},
								{
									criteria = "fileFormat",
									operation = "==",
									value = "PSD",
								},
								combine = "intersect",
							}
							, topCollectionSet
							, true)
	
	
						sCol:setSearchDescription (
						{					
							{
								criteria = "labelColor",
								operation = "==",
								value = 3,
							},
							{
								criteria = "pick",
								operation = "==",
								value = 1,
							},
							{
								criteria = "fileFormat",
								operation = "==",
								value = "PSD",
							},
							combine = "intersect",
							}
						)
	
	
	end
	