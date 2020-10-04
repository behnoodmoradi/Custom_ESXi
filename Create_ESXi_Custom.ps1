$ESXi_New = "C:\HPE\New.zip"
$ESXi_Driver = "C:\HPE\Driver.zip"
$Vendor = "Vira Shabakeh Negar"
$Export_ESXi = "C:\HPE\ESXi_7_vShabakeh"
$Clone_Image_Name = "ESXi_7_vShabakeh"

# Add New ESXi Update Bundle

Add-EsxSoftwareDepot -DepotUrl $ESXi_New
Add-EsxSoftwareDepot -DepotUrl $ESXi_Driver
$ESXi_Clone = Get-EsxImageProfile | ogv -PassThru


# Clone New ESXi Bundle
New-EsxImageProfile -CloneProfile $ESXi_Clone -Name $Clone_Image_Name -Vendor $Vendor

# Add Old Version to Copy Drivers
Add-EsxSoftwarePackage -ImageProfile $Clone_Image_Name -SoftwarePackage "hpe-smx-provider 600.03.11.00.9-2768847"

# Export Update Bundle or ISO
Export-EsxImageProfile -ImageProfile $Clone_Image_Name -ExportToIso -FilePath "$Export_ESXi.iso"
Export-EsxImageProfile -ImageProfile $Clone_Image_Name -ExportToBundle -FilePath "$Export_ESXi.zip"

# Get File Hash
Get-FileHash C:\hpe\ESXi_7_vShabakeh.iso


#### 
# To set the acceptance level of the image profile to CommunitySupported by running the following command
Set-EsxImageProfile -AcceptanceLevel CommunitySupported –ImageProfile “ESXi_7_vShabakeh”
Set-EsxImageProfile -AcceptanceLevel CommunitySupported –ImageProfile ESXICUS

Get-EsxImageProfile | ogv -PassThru | Remove-EsxImageProfile 



Add-EsxSoftwareDepot -DepotUrl C:\HPE\ESXi_7_vShabakeh.zip
Get-EsxSoftwarePackage -Vendor HPE