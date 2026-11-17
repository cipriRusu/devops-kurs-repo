@description('Region. The same as the resource group, given by main.bicep.')
param location string

@description('Name of the web app. Part of its address, so it must be unique in all of Azure.')
@minLength(2)
@maxLength(60)
param appName string

@description('Id of the plan the app runs on: the plan module\'s output.')
param appServicePlanId string

@description('Language and version, for example NODE|24-lts.')
param linuxFxVersion string

@description('Address of the database server: the database module\'s output.')
param sqlServerFqdn string

@description('Name of the database.')
param sqlDatabaseName string

@description('Database admin user name. Azure does not allow admin.')
param sqlAdminLogin string

@secure()
@description('Database admin password. Never a value in a committed file.')
param sqlAdminPassword string

resource appService 'Microsoft.Web/sites@2025-03-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      appSettings: [
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'SQL_CONNECTION_STRING'
          value: 'Server=tcp:${sqlServerFqdn},1433;Database=${sqlDatabaseName};User Id=${sqlAdminLogin};Password=${sqlAdminPassword};Encrypt=true'
        }
      ]
    }
  }
}

output appServiceUrl string = 'https://${appService.properties.defaultHostName}'
