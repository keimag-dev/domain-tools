# ------------------------------------------
# PowerShell Script
# This script notifies the current global IP to MyDNS.JP
# You can update your dynamic IP by running this script periodically using Task Scheduler or other methods.
# ------------------------------------------

# ++++++++++ Secrets ++++++++++
# Replace these with your actual MyDNS MasterID and Password
$MasterID = "mydnsXXXXXX"
$Password = "yourpasswd"
# +++++++++++++++++++++++++++++

# Define the MyDNS login URLs for IPv4 and IPv6
$IPV4_URL = "https://ipv4.mydns.jp/login.html"
$IPV6_URL = "https://ipv6.mydns.jp/login.html"

# Notify MyDNS.JP with current global IPv4 address
Write-Host "--------------- IPV4 ---------------"
Invoke-WebRequest `
    -Uri $IPV4_URL `
    -Headers @{ Authorization = ("Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$MasterID:$Password"))) } `
    | Out-Null

# Notify MyDNS.JP with current global IPv6 address
Write-Host "--------------- IPV6 ---------------"
Invoke-WebRequest `
    -Uri $IPV6_URL `
    -Headers @{ Authorization = ("Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$MasterID:$Password"))) } `
    | Out-Null
