#include <file.au3>

Dim $array
Dim $data
Dim $project



_FileReadToArray("data.txt", $data)

$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")

$project = InputBox("Project name", "Project short name")

$username = InputBox("Username", "Username")

$password = InputBox("Password", "Password")

;LOGIN

;Post request
$oHTTP.Open("POST", "https://www.ohloh.net/sessions", False)
;Add User-Agent header
$oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.0.10) Gecko/2009042316 Firefox/3.0.10 (.NET CLR 4.0.20506)")
;Add Referrer header
$oHTTP.SetRequestHeader("Referrer", "https://www.ohloh.net/sessions/new")
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send("login[login]=" & $username & "&login[password]=" & $password & "&login[remember_me]=1")
;Get received data
;$oReceived = $oHTTP.ResponseText


For $x = 1 To $data[0]

	;ADD ENLISTMENT

	;Post request
	$oHTTP.Open("POST", "https://www.ohloh.net/p/" & $project & "/enlistments", False)
	;Add User-Agent header
	$oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.0.10) Gecko/2009042316 Firefox/3.0.10 (.NET CLR 4.0.20506)")
	;Add Referrer header
	$oHTTP.SetRequestHeader("Referrer", "https://www.ohloh.net/p/" & $project & "/enlistments/new")
	;Add Content-Type
	$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	;Send POST request
	$oHTTP.Send("repository[module_name]=" & $data[$x] & "&repository[type]=CvsRepository&repository[url]=:pserver:anonymous:@cvs.project-open.net:/home/cvsroot")
	;Get received data
	;$oReceived = $oHTTP.ResponseText

	$log = FileOpen("log.txt", 1)
	FileWriteLine($log, $data[$x])
	FileClose($log)

	Sleep(5000)

Next
