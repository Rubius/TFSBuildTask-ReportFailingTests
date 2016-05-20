# TFS Build Task - Report Failing Tests (via email)

## Overview
This repo contains a task that could be included in TFS 2015 scriptable build system.

An intention of the task is to extend the standard email notification about test results from:
![before](/before.png?raw=true "Before")

to:

![after](/after.png?raw=true "After")


to be able to see the failing test names right from the email notification.

The task should be added to the build pipeline after Visual Studio Test task. __"Always run" checkbox should be checked for the task__
This is how build colfiguration could look:
![build configuration](/BuildConfiguration.png)

## Installation

You could either:
 - upload this task to your TFS using the [script](/UploadTaskToTFS.ps1), taken from (https://blogs.infosupport.com/custom-build-tasks-in-tfs-2015/)
 - download [the script](/ReportFailingTests/1.0.1/ReportFailingTests.ps1), add it to your version control and use it as a Powershell build task.
