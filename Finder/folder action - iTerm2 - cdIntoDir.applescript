-- cd to the current (selected or not) finder window folder in iTerm.
-- Modified script from this source: http://snippets.dzone.com/posts/show/961

-- Instructions:
-- paste this script into Script Editor and save as an application to ~/Library/Scripts/Applications/Finder/cd
-- Drag it to the toolbar of a finder window.
-- Activate it by clicking on it.

-- To give the saved script the same icon as iTerm :
-- $ rm ~/Library/Scripts/Applications/Finder/cd.app/Contents/Resources/droplet.icns
-- $ cp /Applications/iTerm.app/Contents/Resources/iTerm.icns ~/Library/Scripts/Applications/Finder/cd.app/Contents/Resources/droplet.icns

-- script was opened by click in toolbar
on run
	tell application "Finder"
		try
			set currFolder to (item 1 of (get selection) as string)
		on error
			try
				set currFolder to (folder of the front window as string)
			on error
				set currFolder to (path to desktop folder as string)
			end try
		end try
	end tell
	CD_to(currFolder, false)
end run

-- script run by draging file/folder to icon
on open (theList)
	set newWindow to false
	repeat with thePath in theList
		set thePath to thePath as string
		if not (thePath ends with ":") then
			set x to the offset of ":" in (the reverse of every character of thePath) as string
			set thePath to (characters 1 thru -(x) of thePath) as string
		end if
		CD_to(thePath, newWindow)
		set newWindow to true -- create window for any other files/folders
	end repeat
	return
end open

-- cd to the desired directory in iterm
on CD_to(theDir, newWindow)
	set theDir to quoted form of POSIX path of theDir as string
	tell application "iTerm"
		activate
		delay 1
		-- talk to the first terminal 
		tell the first terminal
			try
				-- launch a default shell in a new tab in the same terminal 
				launch session "Default Session"
				tell the last session
					try
						-- cd to the finder window
						write text "cd " & theDir
					on error
						display dialog "There was an error cding to the finder window." buttons {"OK"}
					end try
				end tell
			on error
				display dialog "There was an error creating a new tab in iTerm." buttons {"OK"}
			end try
		end tell
	end tell
end CD_to