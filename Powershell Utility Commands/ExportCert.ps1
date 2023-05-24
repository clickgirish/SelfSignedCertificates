$certThumbprint = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"  # Replace with the thumbprint of the certificate you want to export
$exportPath = "C:\Path\to\ExportedCertificate.pfx"        # Replace with the desired export location and filename

$certificate = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Thumbprint -eq $certThumbprint}

if ($certificate) {
    $password = ConvertTo-SecureString -String "YourPassword" -Force -AsPlainText    # Replace "YourPassword" with the desired export password

    Export-PfxCertificate -Cert $certificate -FilePath $exportPath -Password $password

    Write-Host "Certificate exported successfully to: $exportPath"
}
else {
    Write-Host "Certificate with thumbprint $certThumbprint not found."
}
