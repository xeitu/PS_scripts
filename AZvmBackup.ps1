# Define los nombres de las máquinas virtuales, el nombre del vault de Backup y el nombre del contenedor de almacenamiento
$vmNames = @("WWW", "SQL")
$vaultName = "<NombreDelVault>"
$resourceGroupName = "<NombreDelGrupoDeRecursos>"
$policyName = "<NombreDeLaPolítica>"

# Conéctate a tu cuenta de Azure
Connect-AzAccount

# Selecciona la suscripción de Azure
Select-AzSubscription -SubscriptionId "<ID_de_tu_suscripción>"

foreach ($vmName in $vmNames) {
    # Obtiene la máquina virtual
    $vm = Get-AzVM -Name $vmName -ResourceGroupName $resourceGroupName
    
    # Habilita la protección de backup para la máquina virtual
    $container = Get-AzRecoveryServicesBackupContainer -ContainerType AzureVM -FriendlyName $vmName -VaultId $vaultId
    $item = Get-AzRecoveryServicesBackupItem -Container $container -WorkloadType AzureVM -VaultId $vaultId
    $policy = Get-AzRecoveryServicesBackupProtectionPolicy -Name $policyName -VaultId $vaultId
    
    Enable-AzRecoveryServicesBackupProtection -VaultId $vaultId -Policy $policy -Item $item
}

Write-Output "Backup configurado para las máquinas virtuales."
