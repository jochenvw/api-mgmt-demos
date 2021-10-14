resource apimgmt 'Microsoft.ApiManagement/service@2021-01-01-preview' = {
  name: 'api-mgmt-demos-apimgmt-sruinard'
  location: 'westeurope'
  sku: {
    name: 'Premium'
    capacity: 1
  }
  properties: {
    publisherEmail: 'stefruinard@microsoft.com'
    publisherName: 'Stef Ruinard'
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'api-mgmt-demos-apimgmt-logs'
  location: 'westeurope'
}

resource appinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'api-mgmt-demos-apimgmt-insights'
  location: 'westeurope'
  kind: 'web'  
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
}
