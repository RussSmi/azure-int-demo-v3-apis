targetScope = 'resourceGroup'

@description('Name of the API Management Service')
param apimServiceName string // = replace(resourceGroup().name, 'rg-', '')

// API name needs to unique in APIM
param name string = 'petstore'

@allowed([
  'yaml-v3' //uses 'openapi-link' format
  'json-v3' //uses 'openapi+json-link' format
])
param swaggerType string = 'yaml-v3'

// This url needs to be reachable for APIM
param urlToSwagger string = 'https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/examples/v3.0/petstore.yaml'

// There can be only one api without path
param apiPath string = 'petstore'
// param apiVersion string

var format = ((swaggerType == 'yaml-v3')  ? 'openapi-link' : 'openapi+json-link')

// Get the existing API Management Service
resource apimService 'Microsoft.ApiManagement/service@2023-03-01-preview' existing = {
  name: apimServiceName
  scope: resourceGroup()
}

resource api 'Microsoft.ApiManagement/service/apis@2020-06-01-preview' = {
  name: name
  parent: apimService
  properties: {
    format: format
    value: urlToSwagger
    path: apiPath
    // apiVersion: apiVersion
    // apiVersionSetId: apiVersionSet.id
  }
}

//output nameWithVersion string = nameWithVersion
output name string = api.name
output id string = api.id
