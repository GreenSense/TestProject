RESULT="$(git log -1 --pretty=%B | grep -c '.*\[ci skip\].*')"
#echo $RESULT
if [ $RESULT = 1 ]; then
    echo "Skip CI"
    SKIP_CI=1
else
    echo "Continue CI"
    SKIP_CI=0
fi
exit $SKIP_CI