# TFS Build Task - Report Failing Tests (via email)

## Overview
This repo contains a task that could be included in TFS 2015 scriptable build system.

An intention of the task is to extend the standard email notification about test results from:
![before](/before.png?raw=true "Before")

to:

![after](/after.png?raw=true "After")


to be able to see the failing test names right from the email notification.

The task should be added to the build pipeline after Visual Studio Test task.
