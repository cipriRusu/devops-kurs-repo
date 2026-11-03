param planName string
param planSku string = 'B1'
param appName string
param linuxFxVersion string

resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: planName
  location: resourceGroup().location
  kind: 'linux'
  sku: {
    name: planSku
  }
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2025-03-01' = {
  name: appName
  location: resourceGroup().location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      appSettings: [
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
      ]
    }
  }
}

output appServiceUrl string = 'https://${appService.properties.defaultHostName}'
