# SOOS Security Analysis CI for Circle CI

A [CircleCI Orb](https://circleci.com/docs/2.0/orb-intro/) for using [SOOS](https://soos.io) to check for
vulnerabilities in your projects.

You can use the Orb as follows:

```yaml
version: 2.1

orbs:
  soos: soos/soos@x.y.z

#
# The Workflow is the example of how a user would integrate with the PA ORB
#
workflows:
  main:
    jobs:

      - soos/analysis_async_init:
          client_id: "<<SOOS Client Id>>"
          api_key: "<<SOOS API Key>>"

      - soos/analysis_async_result:
          client_id: "<<SOOS Client Id>>"
          api_key: "<<SOOS API Key>>"

          requires:
           - soos/analysis_async_init
        
```

The SOOS Action has properties which are passed to the action using `with`.

| Property | Default | Description |
| --- | --- | --- |
| client_id | ""  | `Required` - SOOS Client Id. Get it from SOOS Application.
| api_key | ""  | `Required` - SOOS API Key. Get it from SOOS Application
| on_failure | "fail_the_build"  | Flag indicating whether or not to return an error code if errors are found in the SOOS script or SOOS analysis.
| directories_to_exclude | ""  | List (comma separated) of directories (relative to ./) to exclude from the search for manifest files. Example - Correct: bin/start/ ... Example - Incorrect: ./bin/start/ ... Example - Incorrect: /bin/start/'|
| files_to_exclude | "" | List (comma separated) of files (relative to ./) to exclude from the search for manifest files. Example - Correct: bin/start/manifest.txt ... Example - Incorrect: ./bin/start/manifest.txt ... Example - Incorrect: /bin/start/manifest.txt' |
| analysis_result_max_wait | 300 | Maximum seconds to wait for Analysis Result before exiting with error. |
| analysis_result_polling_interval | 10 | Polling interval (in seconds) for analysis result completion (success/failure.). Min 10. |
| fs_debug | false | Enables printing of debug statements from the Orb |

The SOOS Action has environment variables which are passed to the action using `env`. These environment variables are stored as project `environment variables` and are required for the action to operate.

| Property | Description |
| --- | --- |
| SOOS_PROJECT_NAME | A custom project name that will present itself as a collection of test results within your soos.io dashboard. |
| SOOS_BASE_URI | The API BASE URI provided to you when subscribing to SOOS services. |
| SOOS_ROOT_CODE_PATH | The relative path from the workspace to search for manifest files to analyze. |
| SOOS_CLIENT_ID | Provided to you when subscribing to SOOS services. |
| SOOS_API_KEY | Provided to you when subscribing to SOOS services. |


## EXAMPLE: Asynchronous scan that contains other CI logic between the two SOOS jobs:

```yaml
version: 2.1

orbs:
  soos: soos/soos@x.y.z

workflows:
  main:
    jobs:

      # NOTE: YOUR OTHER JOBS GO HERE

      - soos/analysis_async_init:
          client_id: "<<SOOS Client Id>>"
          api_key: "<<SOOS API Key>>"

      # NOTE: YOUR OTHER JOBS GO HERE

      - soos/analysis_async_result:
          client_id: "<<SOOS Client Id>>"
          api_key: "<<SOOS API Key>>"

          # NOTE: RUNNING ASYNCHRONOUSLY WILL REQUIRE A DEPENDENCY TO BE ESTABLISHED AGAINST THE "analysis_async_init" JOB
          requires:
           - soos/analysis_async_init

        # NOTE: YOUR OTHER JOBS GO HERE
        
```
### ENVIRONMENT VARIABLES FOR THE ABOVE EXAMPLE
| Property | Value |
| --- | --- |
| SOOS_PROJECT_NAME | "My Project Name" |
| SOOS_BASE_URI | "https://api.soos.io/api/" |
| SOOS_ROOT_CODE_PATH | "./" |
| SOOS_CLIENT_ID | [redacted] |
| SOOS_API_KEY | [redacted] |

## EXAMPLE: Synchronous scan that continues running until analysis complete or timeout reached:

```yaml
version: 2.1

orbs:
  soos: soos/soos@x.y.z

workflows:
  main:
    jobs:

      # NOTE: YOUR OTHER JOBS GO HERE

      - soos/analysis_run_and_wait:
          client_id: "<<SOOS Client Id>>"
          api_key: "<<SOOS API Key>>"

      # NOTE: YOUR OTHER JOBS GO HERE
      
```
### ENVIRONMENT VARIABLES FOR THE ABOVE EXAMPLE
| Property | Value |
| --- | --- |
| SOOS_PROJECT_NAME | "My Project Name" |
| SOOS_BASE_URI | "https://api.soos.io/api/" |
| SOOS_ROOT_CODE_PATH | "./" |
| SOOS_CLIENT_ID | [redacted] |
| SOOS_API_KEY | [redacted] |


## EXAMPLE: "Fire and Forget" scan that runs and the analysis result is inconsequential to the CI build.

```yaml
version: 2.1

orbs:
  soos: soos/soos@x.y.z

workflows:
  main:
    jobs:

      # NOTE: YOUR OTHER JOBS GO HERE

      - soos/analysis_async_init:
          client_id: "<<SOOS Client Id>>"
          api_key: "<<SOOS API Key>>"

      # NOTE: YOUR OTHER JOBS GO HERE
      
```
### ENVIRONMENT VARIABLES FOR THE ABOVE EXAMPLE
| Property | Value |
| --- | --- |
| SOOS_PROJECT_NAME | "My Project Name" |
| SOOS_BASE_URI | "https://api.soos.io/api/" |
| SOOS_ROOT_CODE_PATH | "./" |
| SOOS_CLIENT_ID | [redacted] |
| SOOS_API_KEY | [redacted] |
