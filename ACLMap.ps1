Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction SilentlyContinue

# To get the Current domain 
$Domain = Get-ADDomain
Write-Host "DOMAIN:" -ForegroundColor Yellow
Write-Host "  $($Domain.DNSRoot)`n"

# To get the Current domain's organizational units
Write-Host "ORGANIZATIONAL UNITS:" -ForegroundColor Yellow
$OUs = Get-ADOrganizationalUnit -Filter * -Properties Name
foreach ($ou in $OUs) {
    Write-Host "  $($ou.Name)"
}
Write-Host ""

# To get the Current domain's users
Write-Host "USERS (SamAccountName):" -ForegroundColor Yellow
$Users = Get-ADUser -Filter * -Properties SamAccountName
foreach ($user in $Users) {
    Write-Host "  $($user.SamAccountName)"
}
Write-Host ""

# Groups in the current domain
Write-Host "GROUPS (SamAccountName):" -ForegroundColor Yellow
$Groups = Get-ADGroup -Filter * -Properties SamAccountName
foreach ($group in $Groups) {
    Write-Host "  $($group.SamAccountName)"
}
Write-Host ""

# Computers in the current domain
Write-Host "COMPUTERS (SamAccountName):" -ForegroundColor Yellow
$Computers = Get-ADComputer -Filter * -Properties SamAccountName
foreach ($comp in $Computers) {
    Write-Host "  $($comp.SamAccountName)"
}
Write-Host ""

# GPOs in current domain
if (Get-Command Get-GPO -ErrorAction SilentlyContinue) {
    Write-Host "GROUP POLICY OBJECTS (GPOs):" -ForegroundColor Yellow
    $GPOs = Get-GPO -All
    foreach ($gpo in $GPOs) {
        Write-Host "  $($gpo.DisplayName)"
    }
} else {
    Write-Warning "GroupPolicy module not available — skipping GPO listing."
}

Write-Host "`nEnumeration done" -ForegroundColor Green
