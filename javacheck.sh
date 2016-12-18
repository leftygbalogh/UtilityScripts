#!/bin/sh
#_java=$(java -version 2>&1 | head -n 1 | cut -d\" -f 2 | cut -c1-3)

if type -p java; then
    echo Found Java.
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo Found Java.     
    _java="$JAVA_HOME/bin/java"
else
    echo "Java will now be installed"
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
fi

    if [[ "$version" > "1.5" ]]; then
        echo version is more than 1.5
    else         
        echo version is less than 1.5
    fi
