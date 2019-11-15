#====================================================
#
# Program:    stkynts.ps1
#
# Author:      Brett van Gennip
# Date:        Nov. 15, 2019
# Description: Script to copy and import sticky Notes to be executed from Win10 comp as admin
#
#====================================================

#checks identity of user only run as admin
$adm=([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$dnsb=<<<<<<<<<<PASTE IN YOUR AD Distinguished PATH>>>>>>>>>>>>>>

if($adm){

$getusr=get-aduser -filter * -searchbase $dnsb -properties samaccountname| out-gridview -passthru
$getcmp=get-adcomputer -filter * -searchbase $dnsb -properties name| out-gridview -passthru

$getcmp=$getcmp.name
$getusr=$getusr.samaccountname

$fn ="\\$getcmp\c$\users\$getusr\AppData\Roaming\Microsoft\Sticky Notes\stickynotes.snt"

if(test-path $fn){
cd c:\
#create legacy directory
mkdir C:\Users\$getusr\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\legacy\
cp $fn C:\Users\$getusr\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\legacy\ThresholdNotes.snt -verbose

# explorer shell:appsfolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App
}else{
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
[Microsoft.VisualBasic.Interaction]::msgBox("$fn Path not found or $getcmp not on Network.")
}
}else{
#command run as admin!
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
[Microsoft.VisualBasic.Interaction]::msgBox("Run as your admin $ account on the target win10 system.")
}
