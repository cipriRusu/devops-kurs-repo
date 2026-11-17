using 'main.bicep'

// Your name, once. Change 'name' to your own name. The names below are built from it.
var name = 'crusu'

param planName = 'asp-waypoint-${name}'
param planSku = 'P0v3'
param appName = 'app-waypoint-${name}'
param linuxFxVersion = 'NODE|24-lts'

param sqlServerName = 'sql-waypoint-${name}'
param sqlDatabaseName = 'sqldb-waypoint-${name}'
param sqlAdminLogin = 'waypointadmin'

param sqlAdminPassword = readEnvironmentVariable('SQL_ADMIN_PASSWORD')
