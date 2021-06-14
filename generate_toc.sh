#!/bin/bash

# adapted from https://github.com/npryce/adr-tools
# a combination of a few scripts, _adr_title, _adr_generate_toc

set -e

args=$(getopt i:o:p: $*)
set -- $args

link_prefix=./decisions/

eval "$(adr config)"

echo "# Architecture Decision Records"

if [ -n "$intro" ];
then
    cat "$intro"
    echo
fi

basedir=$(pwd -P)/decisions

for d in decisions/*/; do
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




if [ -n "$outro" ]
then
    echo
    cat "$outro"
fi
