#!/bin/bash -x

# run docker compose with update of environments

compose_file="compose.yml"

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Running on Linux"
	source set_user_bash.sh
elif [[ "$(uname -s)" == "MINGW64_NT"* || "$(uname -s)" == "MSYS_NT"* ]]; then
    echo "Running on Git Bash (Windows)"
	source set_user_bash_win.sh
	compose_file="compose-win.yml"
else
    echo "Unknown environment"
	exit 1
fi


cat << EOF > personal.env
ai_image=zeevb053/ai-dev:1.9
EOF



docker compose -f $compose_file --env-file personal.env up
