targetScope = 'resourceGroup'

// @description('Location for resources')
//param location string = 'uksouth'

@description('Name of the API Management Service')
param apimServiceName string

// @description('The environment to deply to')
//param env string = 'dev'

module importpetStoreApi 'modules/importPetstoreApi.bicep' = {
  name: 'importPetstoreApi'
  params: {
    apimServiceName: apimServiceName
    name: 'petstore'
  }
}
