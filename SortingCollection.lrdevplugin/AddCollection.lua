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

local mainCollections = require 'mainCollections.lua'

local PhotoCollections = require 'PhotoCollections.lua'

--local mainCollections = import 'mainCollections'

--[[
	Demonstrates a custom dialog with a simple binding. The dialog displays a
	checkbox and a text field.  When the check box is selected the text field becomes
	enabled, if the checkbox is unchecked then the text field is disabled.
	
	The check_box.value and the edit_field.enabled are bound to the same value in an
	observable table.  When the check_box is checked/unchecked the changes are reflected
	in the bound property 'isChecked'.  Because the edit_field.enabled value is also bound then
	it reflects whatever value 'isChecked' has.
]]
local function AddSelectedPhotosToColl()

	LrFunctionContext.callWithContext( "AddSelectedPhotosToColl", function( context )
		
		LrTasks.startAsyncTask (function() 
			local catalog = LrApplication.activeCatalog()
			catalog:withWriteAccessDo("create main cat", function( context ) 
				
				catalog:createCollectionSet("Sorting cat", nil, true)
				catalog:createCollectionSet("Sets", nil, true)

			end)

			catalog:withWriteAccessDo("create cat", function( context ) 

				CreateMainSmartCat(catalog)

				local selectedPhotos = catalog:getTargetPhotos()
				
				myLogger:trace(#selectedPhotos)

				CreateNewPhotoCollection(catalog, selectedPhotos)

				for i, photoInfo in ipairs( selectedPhotos ) do
					
					myLogger:trace(photoInfo)

					photoInfo:setRawMetadata( 'colorNameForLabel', 'grey' ) -- clear by color.
				end


			end)       
		end) 
	end) -- end main function

end


	


-- Now display the dialogs.
AddSelectedPhotosToColl()
