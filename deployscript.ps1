# Replace the following URL with a public GitHub repo URL
$gitrepo="https://github.com/Ashut1987/app-service-web-dotnet-get-started-.git"
$webappname="nagarroapp"
$location="West Europe"

# Create a resource group.
New-AzureRmResourceGroup -Name myResourceGroup -Location $location

# Create an App Service plan in Free tier.
New-AzureRmAppServicePlan -Name $webappname -Location $location `
-ResourceGroupName myResourceGroup -Tier Free

# Create a web app.
New-AzureRmWebApp -Name $webappname -Location $location `
-AppServicePlan $webappname -ResourceGroupName myResourceGroup

# Upgrade App Service plan to Standard tier (minimum required by deployment slots)
Set-AzureRmAppServicePlan -Name $webappname -ResourceGroupName myResourceGroup `
-Tier Standard

#Create a deployment slot with the name "staging".
New-AzureRmWebAppSlot -Name $webappname -ResourceGroupName myResourceGroup `
-Slot staging

# Configure GitHub deployment to the staging slot from your GitHub repo and deploy once.
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    IsManualIntegration = "true";
}

#Deployment
Import-AzurePublishSettingsFile 'D:\demo\app-service-web-dotnet-get-started\Windows Azure MSDN - 9_10_2018, 13_03_24 - credentials.publishsettings'
Publish-AzureWebsiteProject -Name nagarroapp -ProjectFile "D:\Demo\app-service-web-dotnet-get-started\aspnet-get-started\aspnet-get-started.csproj" -Configuration Debug