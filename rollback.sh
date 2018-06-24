#!/bin/bash
BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$BRANCH" = "master" ]
then
  echo "Rolling back the master branch to previous revision"

  git pull origin master && \

  git reset --soft HEAD~1 && \

  echo "The 'master' branch has been rolled back"  || \

  (echo "Error" && exit 1)
else
  echo "You must be in the 'master' branch to perform a rollback. The 'dev' branch doesn't get rolled back automatically."
fi
