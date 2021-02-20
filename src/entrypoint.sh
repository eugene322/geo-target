#!/bin/bash

wait_for () {
    for _ in `seq 0 100`; do
        (echo > /dev/tcp/$1/$2) >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            echo "$1:$2 accepts connections"
            break
        fi
        sleep 1
    done
}
populate_env_variables () {
  set -o allexport
  [[ -f core/.env ]] && source core/.env
  set +o allexport
  echo "env variables are populated"
}
clear_old_files () {
  rm -rf celerybeat.pid celerybeat-schedule
}
clear_old_files
populate_env_variables
case "$PROCESS" in
"LINT")
    mypy . && flake8 . && bandit --exclude tests -r . && safety check
    ;;
"TEST")
    pytest -v --cov . --cov-report term-missing --cov-fail-under=100 \
    --color=yes --mypy -n 1 -W error
    ;;
"DEV_FASTAPI")
    wait_for "${DB_HOST}" "${DB_PORT}"
    uvicorn core.main:app --reload --host 0.0.0.0 --port 8000
    ;;
"FASTAPI")
    uvicorn core.main:app --host 0.0.0.0 --port "${PORT}" \
    --proxy-headers --workers 8 --limit-max-requests 2048
    # workers = (2*CPU)+1
    ;;
*)
    echo "NO PROCESS SPECIFIED!"
    exit 1
    ;;
esac
