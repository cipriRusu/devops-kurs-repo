using 'main.bicep'

var name = 'crusu'

param planName = 'asp-waypoint-${name}'
param planSku = 'B1'
param appName = 'app-waypoint-${name}'
param linuxFxVersion = 'NODE|24-lts'
