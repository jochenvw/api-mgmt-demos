// multiline string doesnt support interpolation
var graphql_api_name = 'api-app-sruinard-graphql'
var backend_policy_value = ' <policies> <inbound> <set-backend-service id="apim-generated-policy" backend-id="WebApp_${graphql_api_name}" /> <base /> </inbound> <backend> <base /> </backend> <outbound> <base /> </outbound> <on-error> <base /> </on-error> </policies> '

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
    path: ''
    protocols: [
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
    templateParameters: []
    responses: []
  }

}

resource operations_post 'Microsoft.ApiManagement/service/apis/operations@2019-01-01' = {
  name: '${graphqlapi.name}/graphqloperations_post'
  properties: {
    displayName: 'graphql_post'
    method: 'POST'
    urlTemplate: '/*'
    responses: []
    templateParameters: []
  }

}


resource backend_policy 'Microsoft.ApiManagement/service/apis/policies@2021-01-01-preview' = {
  name: '${graphqlapi.name}/policy'
  properties: {
    value: backend_policy_value
  }
}
