cls
Write-Output "-----------------------------------------------------------------";
Write-Output "Cleaning Data Bundle";
Write-Output "-----------------------------------------------------------------";
$User = "CuentaDeAdministracion@versummaterials.com"
$siteURL = "https://versummaterials.sharepoint.com/sites/ElecSPCSQC"
$docLibrary = "Data Bundles Document Library"
$Pword = ConvertTo-SecureString -String "password" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Connect-PnPOnline -Url $siteURL -Credentials $Credential
#Get-PnPListItem -List "Data Bundles Document Library"
#net use Z: "\\files.versummaterials.com\databundle"  ------->Use this just to map a drive
Write-Output "User: $user";
Write-Output "Site: $siteURL";
Write-Output "Document Library: $docLibrary";
$downloadLocation = "\\files.versummaterials.com\databundle\"
$folderYear = (get-date).AddDays(-14)
$folderYear = Get-date $folderYear -Format yyyy
$finalPath = "$($downloadLocation)\$($folderYear)"
New-Item -ItemType Directory -Force -Path $finalPath
$dateLimit = (get-date).AddDays(-14) 
$dateLimit = Get-Date $dateLimit -Format g
$files = Get-PnPListItem -List $docLibrary
$contador = 0
$contadorPreliminar = $files.Count
$contadorTotal= 0
Write-Output "Moving files from: $dateLimit to the past";
Write-Output "Total files in the library: $contadorPreliminar";
Write-Output "********************************";
Write-Output "Starting moving process";
Write-Output "********************************";
foreach ($file in $files){
$contadorTotal=$contadorTotal+1
$modifiedDate = [datetime]$file["Modified"];
$modifiedDate = '{0:M/d/yy h:m tt}' -f $modifiedDate

 if((get-date $modifiedDate) -lt (get-date $dateLimit)){
 $contador = $contador + 1
 $source= $file.FieldValues.FileRef
 $fileName = $file.FieldValues.FileLeafRef
 $fileDirRef = $file.FieldValues.FileDirRef
 $fileDirRefDelete = "$($fileDirRef)/$($fileName)"
 echo $fileDirRefDelete
 #Get-PnPFile -Url $source -Path $finalPath.ToString() -Force -FileName $fileName -AsFile
 #$file.DeleteObject()

 }

}
Write-Output "Files moved: $contador";


#$cow = Get-PnPListItem -Id 3397 -List "Data Bundles Document Library"
#$source= $cow.FieldValues.FileRef
#$sentToCustomer = $cow.FieldValues.SentToCustomer

#Get-PnPFile -Url $source -Path c:\temp -FileName 4002830.XML -AsFile
#Remove-PnPFile -SiteRelativeUrl "/sites/ElecSPCSQC/Test/APK_479437_LTO520 13.28KG_20180731_10476.CSV" -Force -Recycle


