#!/bin/bash

URL="http://result:4000/" 
current=0
next=0
new=0

while ! timeout 1 bash -c "echo > /dev/tcp/vote/80"; do
    sleep 1
done

# add initial vote 
curl -sS -X POST --data "vote=a" http://vote > /dev/null

current=$(phantomjs render.js $URL | grep -i vote | cut -d ">" -f 4 | cut -d " " -f1)
# echo $current
if [ -z "$current" ]; then current=1; else echo "Not NULL"; fi

next=$((current + 1))

  echo -e """
\n\n-----------------
Current Votes Count: $current
-----------------\n
"""

echo -e " I: Submitting one more vote...\n"

curl -sS -X POST --data "vote=b" http://vote > /dev/null
sleep 3

new=$(phantomjs render.js $URL | grep -i vote | cut -d ">" -f 4 | cut -d " " -f1)

if [ -z "$new" ]; then new=$next; else echo "Not NULL"; fi



  echo -e """
\n\n-----------------
New Votes Count: $new
-----------------\n
"""

echo -e "I: Checking if votes tally......\n"

if [ "$next" -eq "$new" ]; then
  echo -e """
\\e[42m------------
\\e[92mTests passed
\\e[42m------------
"""
  exit 0
else
  echo -e """
\\e[41m------------
\\e[91mTests failed
\\e[41m------------
"""
  exit 1
fi
