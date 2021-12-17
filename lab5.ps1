param (
    [switch]$System,
    [switch]$Disks,
    [switch]$Network
)
if ( !($System) -and !($Disks) -and !($Network)) {
    hardwareInfo
    processorData
    osData
    ramData
    graphicInfo
    diskInfo
    networkInfo
}
if ($System) {
    hardwareInfo
    processorData
    OSData
    ramData
    graphicsInfo
}
if ($Disks) {
    diskInfo
}
if ($Network) {
    networkInfo
}