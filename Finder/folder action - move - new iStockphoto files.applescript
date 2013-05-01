(*
move - added/downloaded iStock files to predefined subfolders

This Folder Action handler is triggered whenever items are added to the attached folder.
The script will move these items to the predefined folders only if their filenames match defined pattern.

Copyright © 2013 Konrad Gibaszewski
*)

property targetAudioFolder : "iStock_audio" -- define target subfolder for audio files
property targetPhotoFolder : "iStock_photo" -- define target subfolder for photos

on adding folder items to thisFolder after receiving theseFiles
	try
		repeat with aFile in theseFiles
			beep
			
			tell application "Finder"
				
				set fileName to (name of aFile) as string
				
				-- check if file matches using grep and regEx
				set checkCommandString to "echo \"" & fileName & "\" | grep -E \"^iStock(.*)\\.(jpg|wav)$\" $1" as string
				set isMatched to do shell script checkCommandString as boolean
				
				if isMatched is equal to true then
					say "Dispatching files started."
					if name extension of aFile is equal to "wav" then
						beep
						move aFile to (thisFolder & targetAudioFolder as text)
					else if name extension of aFile is equal to "jpg" then
						beep
						move aFile to (thisFolder & targetPhotoFolder as text)
					end if
					say "Dispatching files complete."
				end if
			end tell
		end repeat
	end try
end adding folder items to
