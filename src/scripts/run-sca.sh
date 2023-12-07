#!/bin/bash
SOOS_INTEGRATION_NAME="CircleCI"
SOOS_INTEGRATION_TYPE="Plugin"
CIRCLE_WORKING_DIRECTORY="${CIRCLE_WORKING_DIRECTORY/#\~/$HOME}"

if [ -z "$SOOS_PROJECT_NAME" ] || [ "$SOOS_PROJECT_NAME" == "SOOS CircleCI Template" ]; then
    SOOS_PROJECT_NAME=$CIRCLE_PROJECT_REPONAME
fi


PARAMS=(
    "--apiKey" "${!SOOS_API_KEY_VAR_NAME}"
    "--apiURL" "${!SOOS_CLIENT_ID_VAR_NAME}"
    "--branchName" "${CIRCLE_BRANCH}"
    ${CIRCLE_BUILD_URL:+--buildUri "${CIRCLE_BUILD_URL}"}
    "--clientId" "${SOOS_CLIENT_ID_VAR_NAME}"
    "--commitHash" "${CIRCLE_SHA1}"
    "--directoriesToExclude" "${SOOS_DIRS_TO_EXCLUDE}"
    "--filesToExclude" "${SOOS_FILES_TO_EXCLUDE}"
    "--integrationName" "${SOOS_INTEGRATION_NAME}"
    "--integrationType" "${SOOS_INTEGRATION_TYPE}"
    ${SOOS_LOG_LEVEL:+--logLevel ${SOOS_LOG_LEVEL}}
    "--onFailure" "${SOOS_ON_FAILURE}"
    ${SOOS_OUTPUT_FORMAT:+--outputFormat ${SOOS_OUTPUT_FORMAT}}
    ${SOOS_PACKAGE_MANAGERS:+--packageManagers "${SOOS_PACKAGE_MANAGERS}"}    
    "--projectName" "${SOOS_PROJECT_NAME}"
    "--sourceCodePath" "${CIRCLE_WORKING_DIRECTORY}"
    "--workingDirectory" "${CIRCLE_WORKING_DIRECTORY}"
)

if [  "$SOOS_VERBOSE" -eq 1 ]; then
    PARAMS+=(" --verbose")
fi



node ./soos/node_modules/@soos-io/soos-sca/bin/index.js "${PARAMS[@]}"