Option Explicit

dim fso, rootDir, targetDir, oShell
dim appDataDir

set fso = CreateObject("Scripting.FileSystemObject")
set oShell = CreateObject("WScript.Shell")

appDataDir = oShell.ExpandEnvironmentStrings("%APPDATA%")

rootDir = "."

targetDir = appDataDir & "\.minecraft\"

WScript.Echo "TargetDir = " & targetDir

if(fso.FolderExists(targetDir & "mods\")) then
	fso.DeleteFile(targetDir & "mods\*")
	fso.DeleteFolder(targetDir & "mods\*")
end if

if(fso.FolderExists(targetDir & "coremods\")) then
	fso.DeleteFile(targetDir & "coremods\*")
	fso.DeleteFolder(targetDir & "coremods\*")
end if

if(fso.FolderExists(targetDir & "config\")) then
	fso.DeleteFile(targetDir & "config\*")
	fso.DeleteFolder(targetDir & "config\*")
end if

call RecurseDir("", rootDir)

function RecurseDir(path, dir)

	dim tempDir, file, subDir

	set TempDir = fso.GetFolder(dir)

	if not fso.FolderExists(targetDir & path) then
		fso.CreateFolder targetDir & path
	end if

	for each file in TempDir.Files

		file.copy(targetDir & path)

	next

	for each subDir in TempDir.subfolders
		if InStr(subDir.path, ".git") = 0 then
			call RecurseDir(path & subDir.Name & "\", subDir.path)
		end if
	next

end function