get-ciminstance win32_networkadapterconfiguration | 
where IPEnabled -eq "True" | 
ft Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder 