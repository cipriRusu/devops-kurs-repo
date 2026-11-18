@description('Region. The same as the resource group, unless you give another.')
param location string = resourceGroup().location

@description('Name of the App Service plan.')
param planName string

@description('Plan tier: B1, or P0v3 for the faster alternative.')
param planSku string = 'B1'

@description('Name of the web app. Part of its address, so it must be unique in all of Azure.')
param appName string

@description('Language and version, for example NODE|24-lts.')
param linuxFxVersion string

@description('Name of the database server. Part of its address, so it must be unique in all of Azure.')
param sqlServerName string

@description('Name of the database. Unique on its server.')
param sqlDatabaseName string

@description('Database admin user name. Azure does not allow admin.')
param sqlAdminLogin string

@description('Name of the container registry. Letters and digits only, unique in all of Azure.')
param registryName string

@secure()
@minLength(12)
@description('Database admin password. Never a value in a committed file.')
param sqlAdminPassword string

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'app-service-plan'
  params: {
    location: location
    planName: planName
    planSku: planSku
  }
}

module containerRegistry 'modules/container-registry.bicep' = {
  name: 'container-registry'
  params: {
    location: location
    registryName: registryName
  }
}

module sqlDatabase 'modules/sql-database.bicep' = {
  name: 'sql-database'
  params: {
    location: location
    serverName: sqlServerName
    databaseName: sqlDatabaseName
    sqlAdminLogin: sqlAdminLogin
    sqlAdminPassword: sqlAdminPassword
  }
}

module appService 'modules/app-service.bicep' = {
  name: 'app-service'
  params: {
    location: location
    appName: appName
    appServicePlanId: appServicePlan.outputs.appServicePlanId
    linuxFxVersion: linuxFxVersion
    sqlServerFqdn: sqlDatabase.outputs.sqlServerFqdn
    sqlDatabaseName: sqlDatabase.outputs.sqlDatabaseName
    sqlAdminLogin: sqlAdminLogin
    sqlAdminPassword: sqlAdminPassword
  }
}

output appServiceUrl string = appService.outputs.appServiceUrl
output registryLoginServer string = containerRegistry.outputs.loginServer
