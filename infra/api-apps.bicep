resource appserviceplan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'api-serviceplan'
  location: 'westeurope'
  kind: 'elastic'
  sku: {
     name: 'P1v2'
     tier: 'PremiumV2'
  }  
}

resource app 'Microsoft.Web/sites@2021-01-15' = {
  name: 'api-app-jvw-dev'
  location: 'westeurope'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appserviceplan.id
    httpsOnly: true    
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: ''
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: ''
        }

        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: ''
        }

      ]
    }
  }
}
