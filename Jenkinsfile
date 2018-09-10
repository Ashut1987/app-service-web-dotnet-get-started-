#!groovy

SONAR_BRANCH='master'
SONAR_URL='http://10.127.126.113:9000'
SonarQubeEnv ='sonarqube'

def SonarAnalysis()
{
 echo  "\u2600 **********Sonar analysis started*****************"
withSonarQubeEnv("$SonarQubeEnv") {
    bat "\"${tool 'sonarqube'}\\SonarScanner.MSBuild.exe\" begin /key:gamedemo /name:gamedemo /v:1.0 /d:sonar.host.url=http://10.127.126.113:9000 /d:sonar.login=a5eb64ffe8d9f5683336306de7dabc6338c397b8"
    }
}

node("ViaComBuild")

{
stage 'Checkout'

         checkout scm
		 

stage 'Build and code analysis'

//SonarAnalysis()
bat "\"${tool 'MSBuild'}\\msbuild.exe\" aspnet-get-started.sln /p:DeployOnBuild=true /p:PublishProfile=FolderProfile /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:VisualStudioVersion=15.0 /p:ProductVersion=1.0.0.${env.BUILD_NUMBER} /v:diag"
//bat "\"${tool 'MSBuild'}\\msbuild.exe\" /t:Package GameNagarro/GameNagarro.csproj"
//bat "\"${tool 'sonarqube'}\\SonarScanner.MSBuild.exe\" end /d:sonar.login=a5eb64ffe8d9f5683336306de7dabc6338c397b8"


stage 'deployment'


//powershell 'Publish-AzureWebsiteProject -Name "nagarrowebdemo" -Package "C:/jenkins/workspace/Nagarrodemo/aspnet-get-started/bin/Release/PublishOutPut" '

bat 'cat deploy.tf'
bat 'terraform init'
bat 'terraform plan'
bat 'terraform apply'

}

