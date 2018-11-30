#!/usr/bin/env bash

isCommand() {
  for cmd in \
    "help" \
    "list" \
    "analyser" \
    "analyser:list" \
    "analyser:run" \
    "cache" \
    "cache:clear" \
    "config" \
    "config:validate" \
    "diagnose" \
    "diagnose:run" \
    "diagram" \
    "diagram:class" \
    "diagram:package" \
    "plugin" \
    "plugin:list" \
    "reference" \
    "reference:list" \
    "reference:show" \
    "reflection" \
    "reflection:class" \
    "reflection:function"
  do
    if [[ -z "${cmd#"$1"}" ]]; then
      return 0
    fi
  done

  return 1
}

# check if the first argument passed in looks like a flag
if [[ "$(printf %c "$1")" = '-' ]]; then
  set -- /sbin/tini -- phpcompatinfo "$@"
# check if the first argument passed in is phpcompatinfo
elif [[ "$1" = 'phpcompatinfo' ]]; then
  set -- /sbin/tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /sbin/tini -- phpcompatinfo "$@"
fi

exec "$@"
