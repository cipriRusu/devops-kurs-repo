@description('Region. The same as the resource group, given by main.bicep.')
param location string

@description('Name of the database server. Part of its address, so it must be unique in all of Azure.')
param serverName string

@description('Name of the database. Unique on its server.')
param databaseName string

@description('Database admin user name. Azure does not allow admin.')
param sqlAdminLogin string

@secure()
@description('Database admin password. Never a value in a committed file.')
param sqlAdminPassword string

resource sqlServer 'Microsoft.Sql/servers@2025-01-01' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: sqlAdminLogin
    administratorLoginPassword: sqlAdminPassword
    minimalTlsVersion: '1.2'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2025-01-01' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: 'Basic'
  }
}

// 0.0.0.0 to 0.0.0.0 is a special rule: it lets in services inside Azure, such as App Service.
resource allowAzureServices 'Microsoft.Sql/servers/firewallRules@2025-01-01' = {
  parent: sqlServer
  name: 'allow-azure-services'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// The address and the name only. An output is never secret, so the password never comes out here.
output sqlServerFqdn string = sqlServer.properties.fullyQualifiedDomainName
output sqlDatabaseName string = sqlDatabase.name
