# S13 Provisioning: PowerShell Artifact Seeding
$TargetDir = "C:\Users\Administrator\Desktop"
$ArtifactPath = "$TargetDir\onboard_engineers.ps1"

Write-Host "[*] Initializing Session 13 Environment..." -ForegroundColor Cyan

$Template = @'

# ==================================================
# SESSION 13: THE AUTOMATED ONBOARDING
# Operator Deployment Script
# ==================================================

Write-Host "[*] Beginning Engineering Onboarding..."

# INSTRUCTION 1: Create a loop (For 1 to 5)
# YOUR CODE HERE:
1..5 | ForEach-Object {

# INSTRUCTION 2: Inside the loop, use New-ADUser to create Eng_User1 through Eng_User5.
# Ensure you set the -Path to your new Engineering OU, and require a password change.
# YOUR CODE HERE:
New-ADUser -Name "Eng_User$_" -Path "OU=Engineering,DC=titan,DC=local" -ChangePasswordAtLogon $true -Enabled $true -AccountPassword (ConvertTo-SecureString "TempPass123!" -AsPlainText -Force)
}


Write-Host "[+] All engineers onboarded successfully."
'@

Set-Content -Path $ArtifactPath -Value $Template
Write-Host "[+] PROVISIONING COMPLETE. Artifact template seeded at: $ArtifactPath" -ForegroundColor Green