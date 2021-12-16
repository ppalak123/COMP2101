#Function for getting system hardware description
function hardwareInfo {
echo "System Hardware Description"
$systemhardware = Get-WmiObject win32_computersystem
$systemhardware | Select-Object | ft description
}

#Function for getting operating system data
function osData {
echo "Operating System Data"
$osdata = Get-WmiObject win32_operatingsystem
$osdata | Select-Object | ft name, version
}

#Function for getting processor information
function processorData {
echo "Processor Information:"
$processordata = Get-WmiObject win32_processor
$processordata | Select-Object | ft Description, MaxClockSpeed, NumberOfCores, L3CacheSize
}

#function for getting RAM description
function ramData{
echo "RAM Description"
$capacity = 0
Get-WmiObject -class win32_physicalmemory | foreach {
New-Object -TypeName psobject -Property @{
Manufacturer = $_.manufacturer
Description = $_.Description
"Size(GB)" = $_.capacity/1gb
Bank = $_.Banklabel
Slot = $_.devicelocator }
$capacity += $_.capacity/1mb } | ft Vendor, Description, "Size(MB)", Bank, Slot
"Total RAM: ${capacity}MB"
""
}

#Function for getting the information of physical disk drives
function diskInfo{
echo "Physical Disk Drives Information"
get-WmiObject -classname Win32_DiskDrive |
where-object DeviceID -ne $NULL |
Foreach-Object {
                $drive = $_
                $drive.GetRelated("Win32_DiskPartition") |
                foreach {$logicaldisk =$_.GetRelated("win32_LogicalDisk");
                        if($logicaldisk.size) {
                                New-Object -TypeName PSobject -Property @{
    Manufacturer = $drive.Manufacturer
    DriveLetter = $logicaldisk.DeviceID
    Model = $drive.model
    Size = [String]($logicaldisk.size/1gb -as [int])+"GB"
    Free = [string]((($logicaldisk.freespace / $logicaldisk.size) * 100) -as [int])+ "%"
    FreeSpace = [string]($logicaldisk.freespace / 1gb -as [int]) +"GB"
      } | ft -AutoSize Manufacturer, Model, size, Free, FreeSpace }
   }
  }
  }

#Function for getting network adaptor configuration
function networkInfo {
echo "Network Adapter Configuration"
$adaptersinfo = get-ciminstance win32_networkadapterconfiguration 
$adaptersinfo | Where-Object ipenabled -eq 1 | 
Select-Object | ft Description, Index, IPAddress, IPSubnet, DNSDomain, @{n="DNSServer";e={$_.DNSServerSearchOrder }}
}

# Function for getting video card summary
function graphicInfo {
echo "Video Card Summary"
$gpu = Get-WmiObject win32_videocontroller
$gpu | Select-Object | ft @{n="Vendor";e={$.AdapterCompatibility}}, Description, @{n="Screen Resolution";e={$.VideoModeDescription}}
}

hardwareInfo
osData
processorData
ramData
diskInfo
networkInfo
graphicInfo