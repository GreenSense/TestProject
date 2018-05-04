#!/bin/bash

BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$BRANCH" = "dev" ];  then
else
echo "Skipping commit version. Only pushed for 'dev' branch not '$BRANCH'"
fi
