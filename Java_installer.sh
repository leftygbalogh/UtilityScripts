#!/bin/sh

# Check if I am root user - comes handy for the install
if [[ ! `whoami` = "root" ]]; then
    echo "You must have administrative privileges to run this script."
    echo "Log in as root or use sudo and try again."
    exit 1
else echo "You are an administrator. \nThe application will be installed as root."
fi

# Chech if java is already installed and if it is 1.8 or higher - if not, install Java 1.8
boolInstallJava=0

if type -p java; then
    echo Found Java.
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo Found Java.
    _java="$JAVA_HOME/bin/java"
else
    echo No Java found.
    boolInstallJava=1
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
fi

    if [[ "$version" > "1.7" ]] && [[ $boolInstallJava -ne 1 ]]; then
        echo We are good to go.
    else
        echo "Java will now be installed"
        yes | yum install java-1.8.0-openjdk.x86_64
    fi