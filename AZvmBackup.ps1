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


#Reemplaza <NombreDelVault>, <NombreDelGrupoDeRecursos>, <NombreDeLaPolítica>, y <ID_de_tu_suscripción> con los valores correspondientes a tu entorno.
#Asegúrate de tener instalado y configurado Azure PowerShell en tu máquina local o utiliza Azure Cloud Shell.
#Este script es un ejemplo básico y puede necesitar ajustes para adaptarse a tu entorno y requisitos específicos, como la configuración de políticas de backup si aún no existen.
#Antes de ejecutar scripts, especialmente aquellos que modifican recursos, asegúrate de entender completamente lo que el script hace y prueba en un entorno seguro si es posible.
#Este script te ayudará a configurar backups diarios para tus máquinas virtuales en Azure después de un failover. Si necesitas más detalles o tienes requisitos adicionales, házmelo saber
