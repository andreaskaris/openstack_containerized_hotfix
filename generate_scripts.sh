#!/bin/bash

JINJA=$(which jinja2)

if [ "$JINJA" == "" ]; then
  echo "Cannot find jinja2 binary. Please install jinja2"
  echo "E.g.:"
  echo "sudo yum install python3-jinja2-cli.noarch"
  echo "or"
  echo "sudo yum install python2-jinja2-cli.noarch"
  exit 1
fi

for f in $(ls templates) ; do
  echo "Converting templates/$f to scripts/$f:"
  $JINJA templates/$f config.yaml > scripts/${f//[.]j2[.]/.}
done
