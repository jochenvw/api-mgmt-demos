
resource apimgmt 'Microsoft.ApiManagement/service@2021-01-01-preview' existing = {
  name: 'api-mgmt-demos-apimgmt'
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
