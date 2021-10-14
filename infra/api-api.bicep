
resource apimgmt 'Microsoft.ApiManagement/service@2021-01-01-preview' existing = {
  name: 'api-mgmt-demos-apimgmt-sruinard'
}  

resource api 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apimgmt.name}/nodeAPI'
  properties: {
    apiType: 'http'
    description: 'Example nodeJS API'
    isCurrent: true
    format: 'openapi-link'
    value: 'https://api-app-sruinard-nodeapi.azurewebsites.net/spec/api.yml'
    path: 'nodeAPI'
  }
}

resource graphqlapi 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apimgmt.name}/GraphQLAPI'
  properties: {
    apiType: 'http'
    description: 'Example GraphQL API'
    isCurrent: true
    path: 'GraphQLAPI'
    protocols: [
      'http'
      'https'
    ]
    displayName: 'graphQLAPI'
    serviceUrl: 'https://api-mgmt-demos-apimgmt-sruinard.azure-api.net/'
    subscriptionRequired: false
  }
}
