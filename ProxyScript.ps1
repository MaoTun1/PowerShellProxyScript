$domainInfo = Get-WmiObject -Class Win32_ComputerSystem
if ($domainInfo.PartOfDomain) {
    Write-Host "Bu makine bir domain'e dahil."
    Write-Host "Domain Adı: $($domainInfo.Domain)"
} else {
    Write-Host "Bu makine domain'e dahil değil, Workgroup üyesi."
    Write-Host "Workgroup Adı: $($domainInfo.Workgroup)"
}
$CurrentUser = whoami
Write-Host "`nOturum açmış kullanıcı: $CurrentUser"

# Domain bilgileri
$dnsDomain = (Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.DNSDomain -ne $null }).DNSDomain
if ($dnsDomain) {
    Write-Host "Makinenin DNS Domain Adı: $dnsDomain"
} else {
    Write-Host "Makineye ait DNS Domain bilgisi bulunamadı."
}

# Proxy ayarlarını kontrol etmek için registry ayarlarını al
$ProxySettings = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

# Internet Explorer Proxy Etkin mi?
if ($ProxySettings.ProxyEnable -eq 1) {
    Write-Host "`nProxy Ayarları Aktif."
    Write-Host "Proxy Sunucu: $($ProxySettings.ProxyServer)"
} else {
    Write-Host "`nProxy Ayarları Pasif."
}

# İstisna listesini yazdırma
if ($ProxySettings.ProxyOverride) {
    Write-Host "`nProxy İstisna Listesi: $($ProxySettings.ProxyOverride)"
} else {
    Write-Host "`nProxy İstisna Listesi Tanımlı Değil."
}
