#!/bin/sh
if type -p java; then
    echo -e "Found Java executable in \c"
    type -p java
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    echo "There is no Java installed."
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "Your current Java version is: $version"
    if [[ "$version" < "1.8" ]]; then
        echo Java version does not meet the requirements.
    else
        echo Java meets the system requirements.
    fi
fi
