#!/bin/bash
SOOS_INTEGRATION_NAME="CircleCI"
SOOS_INTEGRATION_TYPE="Plugin"
CIRCLE_WORKING_DIRECTORY="${CIRCLE_WORKING_DIRECTORY/#\~/$HOME}"

soos-sca  -cid=$SOOS_CLIENT_ID \
          -akey=$SOOS_API_KEY \
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
          -pn=$SOOS_PROJECT_NAME
