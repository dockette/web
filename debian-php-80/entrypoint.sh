#!/bin/bash

# loop through all the environment variables and append them to /etc/environment
# because cron doesn't "see" docker environment variables
echo -n > /etc/environment
while IFS='=' read -r key value; do
  if [[ ! -z "$key" && ! -z "$value" ]]; then
    echo "$key=\"$value\"" >> /etc/environment
  fi
done < <(printenv)

# run supervisord
supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
