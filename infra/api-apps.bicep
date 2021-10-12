resource appserviceplan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'api-mgmt-demos-serviceplan'
  location: 'westeurope'
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
     name: 'P1v2'
     tier: 'PremiumV2'
  }  
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'api-mgmt-demos-app-logs'
  location: 'westeurope'
}

resource appinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'api-mgmt-demos-app-insights'
  location: 'westeurope'
  kind: 'web'  
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id    
  }
}

resource app 'Microsoft.Web/sites@2021-02-01' = {
  name: 'api-app-jvw-nodeapi'
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
          value: appinsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appinsights.properties.ConnectionString
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
      linuxFxVersion: 'NODE|14-lts'
      alwaysOn: false
    }
    clientAffinityEnabled: false    
  }  
}
