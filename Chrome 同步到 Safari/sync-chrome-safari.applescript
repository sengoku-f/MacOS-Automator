#!/usr/bin/osascript
set SecondsDelay to 0.1

tell application "Google Chrome"
	quit
end tell

tell application "Safari" to activate
delay SecondsDelay
tell application "Safari" to close windows

tell application "System Events" to tell process "Safari"
	tell menu item "导入自" of menu "文件" of menu bar item "文件" of menu bar 1
		tell menu "导入自"
			click menu item "Google Chrome…"
		end tell
	end tell
	tell window "从 Google Chrome 导入"
		click button "导入"
	end tell
	tell application "Safari"
		delay 60
		quit
		display notification "Chrome 👉 Safari" with title "同步完成🎉" sound name "glass"
	end tell
end tell