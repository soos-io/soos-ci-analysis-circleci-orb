#!/bin/bash
SOOS_INTEGRATION_NAME="CircleCI"
SOOS_INTEGRATION_TYPE="Plugin"
CIRCLE_WORKING_DIRECTORY="${CIRCLE_WORKING_DIRECTORY/#\~/$HOME}"

PARAMS=""

if [  "$SOOS_VERBOSE" -eq 1 ]; then
    PARAMS+=" --verbose"
fi


if [ -z "$SOOS_PROJECT_NAME" ] || [ "$SOOS_PROJECT_NAME" == "SOOS CircleCI Template" ]; then
    $SOOS_PROJECT_NAME=${!CIRCLE_PROJECT_REPONAME}
fi

soos-sca  -cid=${!SOOS_CLIENT_ID_VAR_NAME} \
          -akey=${!SOOS_API_KEY_VAR_NAME} \
          -m=$SOOS_SCAN_MODE \
          -of=$SOOS_ON_FAILURE \
          -dte=$SOOS_DIRS_TO_EXCLUDE \
          -fte=$SOOS_FILES_TO_EXCLUDE \
          -wd=$CIRCLE_WORKING_DIRECTORY \
          -armw=$SOOS_ANALYSIS_MAX_AWAIT \
          -arpi=$SOOS_POLLING_INTERVAL \
          -blduri=$CIRCLE_BUILD_URL \
          -ch=$CIRCLE_SHA1 \
          -bn=$CIRCLE_BRANCH \
          -intn=$SOOS_INTEGRATION_NAME \
          -intt=$SOOS_INTEGRATION_TYPE \
          -buri=$SOOS_API_URL \
          -scp=$CIRCLE_WORKING_DIRECTORY \
          -pn=$SOOS_PROJECT_NAME \
          -pm=$SOOS_PACKAGE_MANAGERS \
          -v=$SOOS_VERBOSITY ${PARAMS}
