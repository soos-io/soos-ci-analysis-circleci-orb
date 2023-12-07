#!/bin/bash
SOOS_INTEGRATION_NAME="CircleCI"
SOOS_INTEGRATION_TYPE="Plugin"
CIRCLE_WORKING_DIRECTORY="${CIRCLE_WORKING_DIRECTORY/#\~/$HOME}"

PARAMS=""

if [  "$SOOS_VERBOSE" -eq 1 ]; then
    PARAMS+=" --verbose"
fi


if [ -z "$SOOS_PROJECT_NAME" ] || [ "$SOOS_PROJECT_NAME" == "SOOS CircleCI Template" ]; then
    SOOS_PROJECT_NAME=$CIRCLE_PROJECT_REPONAME
fi

node ./soos/node_modules/@soos-io/soos-sca/bin/index.js --clientId=${!SOOS_CLIENT_ID_VAR_NAME} \
          --apiKey=${!SOOS_API_KEY_VAR_NAME} \
          --onFailure=$SOOS_ON_FAILURE \
          --directoriesToExclude=$SOOS_DIRS_TO_EXCLUDE \
          --filestoExclude=$SOOS_FILES_TO_EXCLUDE \
          --workingDirectory=$CIRCLE_WORKING_DIRECTORY \
          --buildUri=$CIRCLE_BUILD_URL \
          --commitHash=$CIRCLE_SHA1 \
          --branchName=$CIRCLE_BRANCH \
          --integrationName=$SOOS_INTEGRATION_NAME \
          --integrationType=$SOOS_INTEGRATION_TYPE \
          --apiURL=$SOOS_API_URL \
          --sourceCodePath=$CIRCLE_WORKING_DIRECTORY \
          --projectName="$SOOS_PROJECT_NAME" \
          --packageManagers=$SOOS_PACKAGE_MANAGERS \
          --logLevel=$SOOS_LOG_LEVEL \
          --outputFormat=$SOOS_OUTPUT_FORMAT ${PARAMS}
