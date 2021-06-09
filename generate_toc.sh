#!/bin/bash
set -e

args=$(getopt i:o:p: $*)
set -- $args

link_prefix=./decisions/

eval "$(adr config)"

cat <<EOF
# Architecture Decision Records
EOF

if [ ! -z $intro ]
then
    cat "$intro"
    echo
fi

basedir=$(pwd -P)/decisions

for d in $(find $basedir -mindepth 1 -maxdepth 1 -type d)
do
  if ! [[ $d -ef $basedir ]]; then
    echo -e "\n\n## $(basename $d)"

    for f in $(find $d -name '*.md'| grep -E "/[0-9]+-[^/]*\\.md" | sort)
      do
          title=$(head -1 "$f" | cut -c 3-)
          link=${link_prefix}$(basename $d)/$(basename $f)

          echo "* [$title]($link)"
      done
  fi
done




if [ ! -z $outro ]
then
    echo
    cat "$outro"
fi
