#! /bin/bash

COMMAND=$1
ENVIRONMENT=$2

PREFIX="PREFIX-"
SLAVE_SUFFIX="-RC"

ALLOWEDENVIRONMENTS=("FRONTEND-PROD" "FRONTEND-STAGE" "FRONTEND-QA" "PROD" "STAGE" "QA")

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

if [ -z ${COMMAND} ]; then
    echo "You have to pass command"
    exit 1
fi

if [ -z ${ENVIRONMENT} ]; then
    echo "You have to pass environment"
    exit 1
fi

containsElement ${ENVIRONMENT} "${ALLOWEDENVIRONMENTS[@]}"
ISALLOWEDENV=$?

if [ ${ISALLOWEDENV} != 0 ]; then
    echo ${ENVIRONMENT} " is not allowed environment"
    exit 1
fi

if [ ${COMMAND} == "clone" ]; then
    eb clone ${PREFIX}${ENVIRONMENT} -n ${PREFIX}${ENVIRONMENT}${SLAVE_SUFFIX} --timeout 20
    exit 0
elif [ ${COMMAND} == "swap-urls" ]; then
    eb swap ${PREFIX}${ENVIRONMENT} -n ${PREFIX}${ENVIRONMENT}${SLAVE_SUFFIX}
    exit 0
elif [ ${COMMAND} == "terminate-rc" ]; then
    eb terminate ${PREFIX}${ENVIRONMENT}${SLAVE_SUFFIX} --force
    exit 0
else
    echo ${COMMAND} " is unsupported"
    exit 1
fi
