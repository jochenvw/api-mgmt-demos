# api-mgmt-demos

Modify infra/*.bicep files

api-api.bicep:
    change: 
        - apimgmt name
        - api properties.value

api-apps.bicep:
    change: 
        - appserviceplan name
        - app name

api-mgmt.bicep:
    change:
        apimgmt name 

.github/workflows/main.yml:
    change:
        env: AZURE_WEBAPP_NAME


Add AZURE_CREDENTIALS to your repositories' secrets:
command to create az service principal:
az ad sp create-for-rbac --name <INSERT_SP_NAME (e.g. apim-poc-team)> --role contributor --scopes /subscriptions/<INSERT_SUBSCRIPTION_ID> --sdk-auth
