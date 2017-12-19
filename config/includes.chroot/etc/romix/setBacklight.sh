# This just sets brightness

[ $1 -eq $1 ] || exit 5

echo $1 > $2"brightness"
