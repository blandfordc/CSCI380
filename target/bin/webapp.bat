@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup
set REPO=


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\com\googlecode\json-simple\json-simple\1.1.1\json-simple-1.1.1.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-core\2.8.5\jackson-core-2.8.5.jar;"%REPO%"\mysql\mysql-connector-java\5.1.6\mysql-connector-java-5.1.6.jar;"%REPO%"\org\apache\tomcat\embed\tomcat-embed-core\8.5.2\tomcat-embed-core-8.5.2.jar;"%REPO%"\org\apache\tomcat\embed\tomcat-embed-logging-juli\8.5.2\tomcat-embed-logging-juli-8.5.2.jar;"%REPO%"\org\apache\tomcat\embed\tomcat-embed-jasper\8.5.2\tomcat-embed-jasper-8.5.2.jar;"%REPO%"\org\apache\tomcat\embed\tomcat-embed-el\8.5.2\tomcat-embed-el-8.5.2.jar;"%REPO%"\org\eclipse\jdt\core\compiler\ecj\4.5.1\ecj-4.5.1.jar;"%REPO%"\org\apache\tomcat\tomcat-jasper\8.5.2\tomcat-jasper-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-servlet-api\8.5.2\tomcat-servlet-api-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-juli\8.5.2\tomcat-juli-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-el-api\8.5.2\tomcat-el-api-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-api\8.5.2\tomcat-api-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-util-scan\8.5.2\tomcat-util-scan-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-util\8.5.2\tomcat-util-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-jasper-el\8.5.2\tomcat-jasper-el-8.5.2.jar;"%REPO%"\org\apache\tomcat\tomcat-jsp-api\8.5.2\tomcat-jsp-api-8.5.2.jar;"%REPO%"\com\amazonaws\aws-java-sdk-s3\1.11.224\aws-java-sdk-s3-1.11.224.jar;"%REPO%"\com\amazonaws\aws-java-sdk-kms\1.11.224\aws-java-sdk-kms-1.11.224.jar;"%REPO%"\com\amazonaws\aws-java-sdk-core\1.11.224\aws-java-sdk-core-1.11.224.jar;"%REPO%"\commons-logging\commons-logging\1.1.3\commons-logging-1.1.3.jar;"%REPO%"\org\apache\httpcomponents\httpclient\4.5.2\httpclient-4.5.2.jar;"%REPO%"\org\apache\httpcomponents\httpcore\4.4.4\httpcore-4.4.4.jar;"%REPO%"\commons-codec\commons-codec\1.9\commons-codec-1.9.jar;"%REPO%"\software\amazon\ion\ion-java\1.0.2\ion-java-1.0.2.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-databind\2.6.7.1\jackson-databind-2.6.7.1.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-annotations\2.6.0\jackson-annotations-2.6.0.jar;"%REPO%"\com\fasterxml\jackson\dataformat\jackson-dataformat-cbor\2.6.7\jackson-dataformat-cbor-2.6.7.jar;"%REPO%"\joda-time\joda-time\2.8.1\joda-time-2.8.1.jar;"%REPO%"\com\amazonaws\jmespath-java\1.11.224\jmespath-java-1.11.224.jar;"%REPO%"\com\amazonaws\aws-java-sdk-elasticbeanstalk\1.11.224\aws-java-sdk-elasticbeanstalk-1.11.224.jar;"%REPO%"\com\amazonaws\aws-java-sdk-lambda\1.11.224\aws-java-sdk-lambda-1.11.224.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudformation\1.11.224\aws-java-sdk-cloudformation-1.11.224.jar;"%REPO%"\com\amazonaws\aws-java-sdk\1.11.106\aws-java-sdk-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-pinpoint\1.11.106\aws-java-sdk-pinpoint-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-xray\1.11.106\aws-java-sdk-xray-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-opsworkscm\1.11.106\aws-java-sdk-opsworkscm-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-support\1.11.106\aws-java-sdk-support-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-simpledb\1.11.106\aws-java-sdk-simpledb-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-servicecatalog\1.11.106\aws-java-sdk-servicecatalog-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-servermigration\1.11.106\aws-java-sdk-servermigration-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-simpleworkflow\1.11.106\aws-java-sdk-simpleworkflow-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-storagegateway\1.11.106\aws-java-sdk-storagegateway-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-route53\1.11.106\aws-java-sdk-route53-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-importexport\1.11.106\aws-java-sdk-importexport-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-sts\1.11.106\aws-java-sdk-sts-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-sqs\1.11.106\aws-java-sdk-sqs-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-rds\1.11.106\aws-java-sdk-rds-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-redshift\1.11.106\aws-java-sdk-redshift-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-glacier\1.11.106\aws-java-sdk-glacier-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-iam\1.11.106\aws-java-sdk-iam-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-datapipeline\1.11.106\aws-java-sdk-datapipeline-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-elasticloadbalancing\1.11.106\aws-java-sdk-elasticloadbalancing-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-elasticloadbalancingv2\1.11.106\aws-java-sdk-elasticloadbalancingv2-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-emr\1.11.106\aws-java-sdk-emr-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-elasticache\1.11.106\aws-java-sdk-elasticache-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-elastictranscoder\1.11.106\aws-java-sdk-elastictranscoder-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-ec2\1.11.106\aws-java-sdk-ec2-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-dynamodb\1.11.106\aws-java-sdk-dynamodb-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-sns\1.11.106\aws-java-sdk-sns-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-budgets\1.11.106\aws-java-sdk-budgets-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudtrail\1.11.106\aws-java-sdk-cloudtrail-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudwatch\1.11.106\aws-java-sdk-cloudwatch-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-logs\1.11.106\aws-java-sdk-logs-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-events\1.11.106\aws-java-sdk-events-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cognitoidentity\1.11.106\aws-java-sdk-cognitoidentity-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cognitosync\1.11.106\aws-java-sdk-cognitosync-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-directconnect\1.11.106\aws-java-sdk-directconnect-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudfront\1.11.106\aws-java-sdk-cloudfront-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-clouddirectory\1.11.106\aws-java-sdk-clouddirectory-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-kinesis\1.11.106\aws-java-sdk-kinesis-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-opsworks\1.11.106\aws-java-sdk-opsworks-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-ses\1.11.106\aws-java-sdk-ses-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-autoscaling\1.11.106\aws-java-sdk-autoscaling-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudsearch\1.11.106\aws-java-sdk-cloudsearch-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudwatchmetrics\1.11.106\aws-java-sdk-cloudwatchmetrics-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-codedeploy\1.11.106\aws-java-sdk-codedeploy-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-codepipeline\1.11.106\aws-java-sdk-codepipeline-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-config\1.11.106\aws-java-sdk-config-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-ecs\1.11.106\aws-java-sdk-ecs-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-ecr\1.11.106\aws-java-sdk-ecr-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cloudhsm\1.11.106\aws-java-sdk-cloudhsm-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-ssm\1.11.106\aws-java-sdk-ssm-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-workspaces\1.11.106\aws-java-sdk-workspaces-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-machinelearning\1.11.106\aws-java-sdk-machinelearning-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-directory\1.11.106\aws-java-sdk-directory-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-efs\1.11.106\aws-java-sdk-efs-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-codecommit\1.11.106\aws-java-sdk-codecommit-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-devicefarm\1.11.106\aws-java-sdk-devicefarm-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-elasticsearch\1.11.106\aws-java-sdk-elasticsearch-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-waf\1.11.106\aws-java-sdk-waf-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-marketplacecommerceanalytics\1.11.106\aws-java-sdk-marketplacecommerceanalytics-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-inspector\1.11.106\aws-java-sdk-inspector-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-iot\1.11.106\aws-java-sdk-iot-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-api-gateway\1.11.106\aws-java-sdk-api-gateway-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-acm\1.11.106\aws-java-sdk-acm-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-gamelift\1.11.106\aws-java-sdk-gamelift-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-dms\1.11.106\aws-java-sdk-dms-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-marketplacemeteringservice\1.11.106\aws-java-sdk-marketplacemeteringservice-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-cognitoidp\1.11.106\aws-java-sdk-cognitoidp-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-discovery\1.11.106\aws-java-sdk-discovery-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-applicationautoscaling\1.11.106\aws-java-sdk-applicationautoscaling-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-snowball\1.11.106\aws-java-sdk-snowball-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-rekognition\1.11.106\aws-java-sdk-rekognition-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-polly\1.11.106\aws-java-sdk-polly-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-lightsail\1.11.106\aws-java-sdk-lightsail-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-stepfunctions\1.11.106\aws-java-sdk-stepfunctions-1.11.106.jar;"%REPO%"\com\jayway\jsonpath\json-path\2.2.0\json-path-2.2.0.jar;"%REPO%"\org\slf4j\slf4j-api\1.7.16\slf4j-api-1.7.16.jar;"%REPO%"\com\amazonaws\aws-java-sdk-health\1.11.106\aws-java-sdk-health-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-costandusagereport\1.11.106\aws-java-sdk-costandusagereport-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-codebuild\1.11.106\aws-java-sdk-codebuild-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-appstream\1.11.106\aws-java-sdk-appstream-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-shield\1.11.106\aws-java-sdk-shield-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-batch\1.11.106\aws-java-sdk-batch-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-lex\1.11.106\aws-java-sdk-lex-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-mechanicalturkrequester\1.11.106\aws-java-sdk-mechanicalturkrequester-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-organizations\1.11.106\aws-java-sdk-organizations-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-workdocs\1.11.106\aws-java-sdk-workdocs-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-models\1.11.106\aws-java-sdk-models-1.11.106.jar;"%REPO%"\com\amazonaws\aws-java-sdk-swf-libraries\1.11.22\aws-java-sdk-swf-libraries-1.11.22.jar;"%REPO%"\commons-io\commons-io\2.5\commons-io-2.5.jar;"%REPO%"\com\csci380\project\Csci380\1.0-SNAPSHOT\Csci380-1.0-SNAPSHOT.jar

set ENDORSED_DIR=
if NOT "%ENDORSED_DIR%" == "" set CLASSPATH="%BASEDIR%"\%ENDORSED_DIR%\*;%CLASSPATH%

if NOT "%CLASSPATH_PREFIX%" == "" set CLASSPATH=%CLASSPATH_PREFIX%;%CLASSPATH%

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS%  -classpath %CLASSPATH% -Dapp.name="webapp" -Dapp.repo="%REPO%" -Dapp.home="%BASEDIR%" -Dbasedir="%BASEDIR%" launch.Main %CMD_LINE_ARGS%
if %ERRORLEVEL% NEQ 0 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
