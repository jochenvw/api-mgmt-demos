resource apimgmt 'Microsoft.ApiManagement/service@2021-01-01-preview' existing = {
  name: 'api-mgmt-demos-apimgmt'
}  

resource appinsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: 'api-mgmt-demos-app-insights'
  scope: resourceGroup('api-mgmt-demos-appteam')
}

resource apilogger 'Microsoft.ApiManagement/service/loggers@2021-01-01-preview' = {  
  name: '${apimgmt.name}/apiinsights'
  properties: {
    loggerType: 'applicationInsights'
    credentials: {
      'instrumentationKey': appinsights.properties.InstrumentationKey
    }    
    isBuffered: true
    resourceId: appinsights.id
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apimgmt.name}/nodeAPI'
  properties: {
    apiType: 'http'
    description: 'Example nodeJS API'
    isCurrent: true
    format: 'openapi-link'
    value: 'https://api-app-jvw-nodeapi.azurewebsites.net/spec/api.yml'
    path: 'nodeAPI'
  }
}
resource diagnosticsetting 'Microsoft.ApiManagement/service/apis/diagnostics@2021-01-01-preview' = {
  name: '${api.name}/diagsetting'
  properties: {
    loggerId: apilogger.id
  }
}

