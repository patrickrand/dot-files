if [ $(uname) == 'Darwin' ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
else
    export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
fi

