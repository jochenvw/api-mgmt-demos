resource apimgmt 'Microsoft.ApiManagement/service@2021-01-01-preview' = {
  name: 'api-mgmt-demos-apimgmt'
  location: 'westeurope'
  sku: {
    name: 'Premium'
    capacity: 1
  }
  properties: {
    publisherEmail: 'jowylick@microsoft.com'
    publisherName: 'John Doe'
  }
}
