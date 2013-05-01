(*
move - added/downloaded app-like files to predefined subfolder

This Folder Action handler is triggered whenever items are added to the attached folder.
The script will move these items to the predefined folder only if they match apps' extensions list.

Copyright © 2013 Konrad Gibaszewski
*)

property targetFolder : "apps" -- define target subfolder for matching files
property extList : {"app", "dmg", "pkg"} -- define app-like filetypes

on adding folder items to thisFolder after receiving theseFiles
	try
		repeat with aFile in theseFiles
			beep
			tell application "Finder"
				if name extension of aFile is in extList then
					beep
					beep
					move aFile to (thisFolder & targetFolder as text)
				end if
			end tell
		end repeat
	end try
end adding folder items to
