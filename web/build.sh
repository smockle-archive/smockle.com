#!/bin/bash

# Check for templates
if [ ! -d "sites-template" ]; then
  exit
fi

TEMPLATES="sites-template/*"
for t in $TEMPLATES
do
  # Get base filename
  o="${t/sites-template\//}"
  o="${o/.template/}"

  # Transform templates into available sites
  if [ ! -d "sites-available" ]; then
    mkdir "sites-available"
  fi
  sed "s/\$tld/local/" "$t" > "sites-available/$o.local"
  sed "s/\$tld/com/" "$t" > "sites-available/$o.com"

  # Link available sites
  if [ ! -d "sites-enabled" ]; then
    mkdir "sites-enabled"
  fi
  (
    cd "sites-enabled"
    rm -f "$o.local"
    ln -s "../sites-available/$o.local" "."
    rm -f "$o.com"
    ln -s "../sites-available/$o.com" "."
  )

  echo "$o.template is transformed and linked."
done
