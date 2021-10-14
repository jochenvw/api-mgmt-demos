
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

resource operations_get 'Microsoft.ApiManagement/service/apis/operations@2019-01-01' = {
  name: '${graphqlapi.name}/graphqloperations_get'
  properties: {
    displayName: 'graphql_get'
    method: 'GET'
    urlTemplate: '/*'
  }

}

resource operations_post 'Microsoft.ApiManagement/service/apis/operations@2019-01-01' = {
  name: '${graphqlapi.name}/graphqloperations_post'
  properties: {
    displayName: 'graphql_post'
    method: 'POST'
    urlTemplate: '/*'
  }

}
