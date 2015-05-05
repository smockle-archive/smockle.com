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
  if [ ! -d ".tmp" ]; then
    mkdir ".tmp"
    MKDIR_TMP=true
  fi
  cp "$t" ".tmp/$o.local"
  cp "$t" ".tmp/$o.com"
  if (grep -q "\$tld" "$t"); then
    sed "s/\$tld/local/" ".tmp/$o.local" > ".tmp/$o.local.tmp" && mv ".tmp/$o.local.tmp" ".tmp/$o.local"
    sed "s/\$tld/com/" ".tmp/$o.com" > ".tmp/$o.com.tmp" && mv ".tmp/$o.com.tmp" ".tmp/$o.com"
  fi
  if (grep -q "\$onoff" "$t"); then
    sed "s/\$onoff/on/" ".tmp/$o.local" > ".tmp/$o.local.tmp" && mv ".tmp/$o.local.tmp" ".tmp/$o.local"
    sed "s/\$onoff/off/" ".tmp/$o.com" > ".tmp/$o.com.tmp" && mv ".tmp/$o.com.tmp" ".tmp/$o.com"
  fi
  if (grep -q "\$offon" "$t"); then
    sed "s/\$offon/off/" ".tmp/$o.local" > ".tmp/$o.local.tmp" && mv ".tmp/$o.local.tmp" ".tmp/$o.local"
    sed "s/\$offon/on/" ".tmp/$o.com" > ".tmp/$o.com.tmp" && mv ".tmp/$o.com.tmp" ".tmp/$o.com"
  fi
  mv ".tmp/$o.local" "sites-available/$o.local"
  rm -f ".tmp/$o.local.tmp"
  mv ".tmp/$o.com" "sites-available/$o.com"
  rm -f ".tmp/$o.com.tmp"
  if [[ $MKDIR_TMP ]]; then rm -Rf ".tmp"; fi

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
