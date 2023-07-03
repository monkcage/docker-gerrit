#!/bin/bash -e

export JAVA_OPTS='--add-opens java.base/java.net=ALL-UNNAMED --add-opens java/base/java.lang.invoke=ALL-UNNAMED'

if [ ! -d /site/git/All-projects.git ] || [ "$1" == "init" ]
then
    echo "Initializing Gerrit site..."
    java $JAVA_OPTS -jar /gerrit-3.2.12.war init --batch --install-all-plugins -d /site
    java $JAVA_OPTS -jar /gerrit-3.2.12.war reindex -d /site
    git config -f /site/etc/gerrit.config --add container.javaOptions "-Djava.security.egd=file:/dev/./urandom"
    git config -f /site/etc/gerrit.config --add container.javaOptions "--add-opens java.base/java.net=ALL-UNNAMED"
    git config -f /site/etc/gerrit.config --add container.javaOptions "--add-opens java.base/java.lang.invoke=ALL-UNNAMED"
fi

git config -f /site/etc/gerrit.config gerrit.canonicalWebUrl "${CANONICAL_WEB_URL}:-http://$HOSTNAME"
if [ ${HTTPD_LISTEN_URL} ];
then
    git config -f /site/etc/gerrit.config httpd.listenUrl ${HTTPD_LISTEN_URL}
fi

if [ "$1" != "init" ]
then
    echo "Running Gerrit ..."
    exec /site/bin/gerrit.sh run
fi
