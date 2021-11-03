param uniqueness string = 'z9pqqf'
param location string = resourceGroup().location

resource appserviceplan 'Microsoft.Web/serverfarms@2021-01-15' existing =  {
  name: 'api-app-asp-${uniqueness}'
}

resource apimgmt 'Microsoft.ApiManagement/service@2021-01-01-preview' existing =  {
  name: 'api-mgmt-team-apim-${uniqueness}'
  scope: resourceGroup('api-mgmt-demos-apiteam')
}

resource appinsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: 'api-app-insights-${uniqueness}'
}

resource webshop 'Microsoft.Web/sites@2021-02-01' = {
  name: 'api-app-api-python-${uniqueness}-webshop'
  location: 'westeurope'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appserviceplan.id
    httpsOnly: true    
    siteConfig: {
      cors: {
        allowedOrigins: [
          '*'
        ]
        supportCredentials: false
      }
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appinsights.properties.InstrumentationKey
        }
        {
          name: 'APPINSIGHTS_CONNECTION_STRING'
          value: appinsights.properties.ConnectionString
        }
        {
          name: 'APIM_ENDPOINT'
          value: apimgmt.properties.managementApiUrl
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'recommended'
        }
      ]
      
      linuxFxVersion: 'python|3.7'
      alwaysOn: false
      
    }
    clientAffinityEnabled: false    
  }  
}

resource payments 'Microsoft.Web/sites@2021-02-01' = {
  name: 'api-app-api-python-${uniqueness}-payments'
  location: 'westeurope'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appserviceplan.id
    httpsOnly: true    
    siteConfig: {
      cors: {
        allowedOrigins: [
          '*'
        ]
        supportCredentials: false
      }
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appinsights.properties.InstrumentationKey
        }
        {
          name: 'APPINSIGHTS_CONNECTION_STRING'
          value: appinsights.properties.ConnectionString
        }
        {
          name: 'SHIPPING_ENDPOINT'
          value: shipping.properties.defaultHostName
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'recommended'
        }
      ]
      
      linuxFxVersion: 'python|3.7'
      alwaysOn: false
      
    }
    clientAffinityEnabled: false    
  }  
}

resource shipping 'Microsoft.Web/sites@2021-02-01' = {
  name: 'api-app-api-python-${uniqueness}-shipping'
  location: 'westeurope'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appserviceplan.id
    httpsOnly: true    
    siteConfig: {
      cors: {
        allowedOrigins: [
          '*'
        ]
        supportCredentials: false
      }
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appinsights.properties.InstrumentationKey
        }
        {
          name: 'APPINSIGHTS_CONNECTION_STRING'
          value: appinsights.properties.ConnectionString
        }
        {
          name: 'ACCOUNT_URI'
          value: cosmos_account.properties.documentEndpoint
        }        
        {
          name: 'ACCOUNT_KEY'
          value: listKeys(cosmos_account.id, cosmos_account.apiVersion).primaryMasterKey
        }     
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'recommended'
        }
      ]
      
      linuxFxVersion: 'python|3.7'
      alwaysOn: false
      
    }
    clientAffinityEnabled: false    
  }  
}


// ####################
// #####  COSMOS  #####
// ####################

resource cosmos_account 'Microsoft.DocumentDB/databaseAccounts@2021-07-01-preview' = {
  name: 'we-cosmos-distributed-tracing'
  location: location
  properties: {
    createMode: 'Default'
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        'locationName': location
        'failoverPriority': 0
        'isZoneRedundant':false
      }
    ]
  }
}

resource cosmos_db 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-04-15' = {
  name: '${cosmos_account.name}/webshop'
  location: location
  properties: {
    resource: {
      id: 'webshop'
    }
    options: {
      throughput: 400
    }
  }
}

resource cosmosdb_container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-06-15' = {
  name: '${cosmos_db.name}/orders'
  location: location
  properties: {
    resource: {
      id: 'orders'
      partitionKey:{
        kind: 'Hash'
        paths: [
          '/item_id'
        ]
        version: 1
      }
    }
  }
}
