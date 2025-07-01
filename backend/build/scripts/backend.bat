@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem
@rem SPDX-License-Identifier: Apache-2.0
@rem

@if "%DEBUG%"=="" @echo off
@rem ##########################################################################
@rem
@rem  backend startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
@rem This is normally unused
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and BACKEND_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH. 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME% 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\backend-0.1.jar;%APP_HOME%\lib\micronaut-cassandra-6.1.1.jar;%APP_HOME%\lib\micronaut-micrometer-registry-prometheus-5.2.0.jar;%APP_HOME%\lib\micronaut-micrometer-core-5.2.0.jar;%APP_HOME%\lib\micronaut-serde-jackson-2.4.0.jar;%APP_HOME%\lib\micronaut-serde-support-2.4.0.jar;%APP_HOME%\lib\micronaut-serde-api-2.4.0.jar;%APP_HOME%\lib\micronaut-http-client-4.2.1.jar;%APP_HOME%\lib\micronaut-jackson-databind-4.2.1.jar;%APP_HOME%\lib\micronaut-management-4.2.1.jar;%APP_HOME%\lib\java-driver-mapper-processor-4.17.0.jar;%APP_HOME%\lib\java-driver-mapper-runtime-4.17.0.jar;%APP_HOME%\lib\java-driver-query-builder-4.17.0.jar;%APP_HOME%\lib\java-driver-core-4.17.0.jar;%APP_HOME%\lib\micronaut-http-server-netty-4.2.1.jar;%APP_HOME%\lib\micronaut-websocket-4.2.1.jar;%APP_HOME%\lib\micronaut-http-client-core-4.2.1.jar;%APP_HOME%\lib\micronaut-discovery-core-4.2.1.jar;%APP_HOME%\lib\micronaut-http-netty-4.2.1.jar;%APP_HOME%\lib\micronaut-http-server-4.2.1.jar;%APP_HOME%\lib\micronaut-router-4.2.1.jar;%APP_HOME%\lib\micronaut-jackson-core-4.2.1.jar;%APP_HOME%\lib\micronaut-json-core-4.2.1.jar;%APP_HOME%\lib\micronaut-http-4.2.1.jar;%APP_HOME%\lib\micronaut-context-propagation-4.2.1.jar;%APP_HOME%\lib\micronaut-context-4.2.1.jar;%APP_HOME%\lib\micronaut-buffer-netty-4.2.1.jar;%APP_HOME%\lib\micronaut-aop-4.2.1.jar;%APP_HOME%\lib\micronaut-inject-4.2.1.jar;%APP_HOME%\lib\logback-classic-1.4.13.jar;%APP_HOME%\lib\snakeyaml-2.0.jar;%APP_HOME%\lib\spotbugs-annotations-4.8.1.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\native-protocol-1.5.1.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.101.Final.jar;%APP_HOME%\lib\netty-codec-http2-4.1.101.Final.jar;%APP_HOME%\lib\netty-codec-http-4.1.101.Final.jar;%APP_HOME%\lib\netty-handler-4.1.101.Final.jar;%APP_HOME%\lib\java-driver-shaded-guava-25.1-jre-graal-sub-1.jar;%APP_HOME%\lib\config-1.4.1.jar;%APP_HOME%\lib\jnr-posix-3.1.15.jar;%APP_HOME%\lib\metrics-core-4.2.22.jar;%APP_HOME%\lib\micronaut-core-reactive-4.2.1.jar;%APP_HOME%\lib\micronaut-core-4.2.1.jar;%APP_HOME%\lib\slf4j-api-2.0.9.jar;%APP_HOME%\lib\micrometer-registry-prometheus-1.11.5.jar;%APP_HOME%\lib\micrometer-core-1.11.5.jar;%APP_HOME%\lib\HdrHistogram-2.1.12.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.15.3.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.15.3.jar;%APP_HOME%\lib\jackson-databind-2.15.3.jar;%APP_HOME%\lib\jackson-annotations-2.15.3.jar;%APP_HOME%\lib\jackson-core-2.15.3.jar;%APP_HOME%\lib\reactor-core-3.5.11.jar;%APP_HOME%\lib\reactive-streams-1.0.4.jar;%APP_HOME%\lib\jcip-annotations-1.0-1.jar;%APP_HOME%\lib\jakarta.annotation-api-2.1.1.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.101.Final.jar;%APP_HOME%\lib\netty-codec-socks-4.1.101.Final.jar;%APP_HOME%\lib\netty-codec-4.1.101.Final.jar;%APP_HOME%\lib\netty-transport-4.1.101.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.101.Final.jar;%APP_HOME%\lib\logback-core-1.4.13.jar;%APP_HOME%\lib\micrometer-observation-1.11.5.jar;%APP_HOME%\lib\jnr-ffi-2.2.11.jar;%APP_HOME%\lib\jnr-constants-0.10.3.jar;%APP_HOME%\lib\netty-resolver-4.1.101.Final.jar;%APP_HOME%\lib\netty-common-4.1.101.Final.jar;%APP_HOME%\lib\jakarta.inject-api-2.0.1.jar;%APP_HOME%\lib\micrometer-commons-1.11.5.jar;%APP_HOME%\lib\jffi-1.3.9.jar;%APP_HOME%\lib\jffi-1.3.9-native.jar;%APP_HOME%\lib\asm-commons-9.2.jar;%APP_HOME%\lib\asm-util-9.2.jar;%APP_HOME%\lib\asm-analysis-9.2.jar;%APP_HOME%\lib\asm-tree-9.2.jar;%APP_HOME%\lib\asm-9.2.jar;%APP_HOME%\lib\jnr-a64asm-1.0.0.jar;%APP_HOME%\lib\jnr-x86asm-1.0.2.jar;%APP_HOME%\lib\javapoet-1.13.0.jar;%APP_HOME%\lib\LatencyUtils-2.0.3.jar;%APP_HOME%\lib\simpleclient_common-0.16.0.jar;%APP_HOME%\lib\simpleclient-0.16.0.jar;%APP_HOME%\lib\simpleclient_tracer_otel-0.16.0.jar;%APP_HOME%\lib\simpleclient_tracer_otel_agent-0.16.0.jar;%APP_HOME%\lib\simpleclient_tracer_common-0.16.0.jar


@rem Execute backend
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %BACKEND_OPTS%  -classpath "%CLASSPATH%" com.notesmaker.Application %*

:end
@rem End local scope for the variables with windows NT shell
if %ERRORLEVEL% equ 0 goto mainEnd

:fail
rem Set variable BACKEND_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
set EXIT_CODE=%ERRORLEVEL%
if %EXIT_CODE% equ 0 set EXIT_CODE=1
if not ""=="%BACKEND_EXIT_CONSOLE%" exit %EXIT_CODE%
exit /b %EXIT_CODE%

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
