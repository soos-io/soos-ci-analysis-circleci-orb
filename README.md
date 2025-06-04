# [SOOS Core SCA for Circle CI](https://soos.io/sca-product)

SOOS is an independent software security company, located in Winooski, VT USA, building security software for your team. [SOOS, Software security, simplified](https://soos.io).

Use SOOS to scan your software for [vulnerabilities](https://app.soos.io/research/vulnerabilities) and [open source license](https://app.soos.io/research/licenses) issues with [SOOS Core SCA](https://soos.io/products/sca). [Generate and ingest SBOMs](https://soos.io/products/sbom-manager). [Export reports](https://kb.soos.io/help/soos-reports-for-export) to industry standards. Govern your open source dependencies. Run the [SOOS DAST vulnerability scanner](https://soos.io/products/dast) against your web apps or APIs. [Scan your Docker containers](https://soos.io/products/containers) for vulnerabilities. Check your source code for issues with [SAST Analysis](https://soos.io/products/sast).

[Demo SOOS](https://app.soos.io/demo) or [Register for a Free Trial](https://app.soos.io/register).

If you maintain an Open Source project, sign up for the Free as in Beer [SOOS Community Edition](https://soos.io/products/community-edition).

## soos-ci-analysis-circleci-orb

A [CircleCI Orb](https://circleci.com/docs/2.0/orb-intro/) for using [SOOS](https://soos.io) to check for
vulnerabilities in your projects.

Example usage:

```yaml
version: 2.1

orbs:
  soos: soos-io/sca@x.y.z

#
# The Workflow is the example of how a user would integrate with the SOOS Orb
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
| client_id |  | SOOS Client ID - get yours from [SOOS Integration](https://app.soos.io/integrate/sca). Uses `SOOS_API_CLIENT` env value if present.  
| api_key |  | SOOS API Key - get yours from [SOOS Integration](https://app.soos.io/integrate/sca). Uses `SOOS_API_KEY` env value if present.
| branch_name              | `CIRCLE_BRANCH` | Branch Name to create scan under |
| build_version           | |Version of application build artifacts. |
| on_failure | `continue_on_failure`  | Flag indicating whether or not to return an error code if errors are found in the SOOS CLI or SOOS analysis. |
| output_format   |        | Output format for vulnerabilities: only the value SARIF is available at the moment |  
| directories_to_exclude |  | Listing of directories or patterns to exclude from the search for manifest files. eg: **bin/start/**, **/start/** |
| files_to_exclude | | Listing of files or patterns patterns to exclude from the search for manifest files. eg: **/req**.txt/, **/requirements.txt |
| package_managers | | List (comma separated) of Package Managers to filter manifest search. (Dart, Erlang, Homebrew, PHP, Java, Nuget, NPM, Python, Ruby, Rust.)|
| log_level | `INFO`  | Log level to show: DEBUG, INFO, WARN, FAIL, ERROR.|

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
  soos: soos-io/sca@1.0.0

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
  soos: soos-io/sca@x.x.x

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
  soos: soos-io/sca@x.x.x

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

### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info soos-io/sca | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/soos-io/soos-ci-analysis-circleci-orb/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.
