#!/bin/sh

if [ "$1" = "version" ];
  then
    CURL_DATA='{"projectName": '\"$2\"'}';

    VERSION=$(curl -s \
    -H "Content-Type: application/json" \
    --request POST \
    --data "$CURL_DATA" \
    https://api.kube.iungo.ink/project/version)

    echo $VERSION
fi

if [ "$1" = "bump" ];
  then
    CURL_DATA='{"projectName": '\"$3\"', "toBump": '\"$2\"'}'

    VERSION=$(curl -s \
        -H "Content-Type: application/json" \
        --request POST \
        --data "$CURL_DATA" \
        https://api.kube.iungo.ink/project/bump)

    echo $VERSION
fi

if [ "$1" = "setBuildNum" ];
  then
    CURL_DATA='{"projectPath": '\"$3\"', "buildNum": '\"$2\"'}'

    BUILDNUM=$(curl -s \
        -H "Content-Type: application/json" \
        --request POST \
        --data "$CURL_DATA" \
        https://api.kube.iungo.ink/project/setBuildNum)

    echo $BUILDNUM
fi

if [ "$1" = "getBuildNum" ];
  then
    CURL_DATA='{"projectName": '\"$2\"'}'

    BUILDNUM=$(curl -s \
        -H "Content-Type: application/json" \
        --request POST \
        --data "$CURL_DATA" \
        https://api.kube.iungo.ink/project/getBuildNum)

    echo $BUILDNUM
fi

if [ "$1" = "getSeq" ];
  then
    CURL_DATA='{"projectName": '\"$2\"'}'

    BUILDNUM=$(curl -s \
        -H "Content-Type: application/json" \
        --request POST \
        --data "$CURL_DATA" \
        https://api.kube.iungo.ink/project/getSeq)

    echo $BUILDNUM
fi

if [ "$1" = "translate" ]; then

  # Check if pipeline source is a merge request
  if [ "$CI_PIPELINE_SOURCE" = "merge_request_event" ]; then
      echo "build"
      exit 0
  fi

    # Mapping CI_COMMIT_BRANCH to version increment
  if [ "$CI_COMMIT_BRANCH" = "dev" ]; then
      VERSION_INCREMENT="patch"
  elif [ "$CI_COMMIT_BRANCH" = "staging" ]; then
      VERSION_INCREMENT="minor"
  elif [ "$CI_COMMIT_BRANCH" = "prod" ]; then
      VERSION_INCREMENT="major"
  else
      echo "Error: Unrecognized branch '$CI_COMMIT_BRANCH'."
      exit 1
  fi

    # Output the corresponding version increment
    echo "$VERSION_INCREMENT"
fi

if [ "$1" = "createMetadata" ];
  then
    CURL_DATA='{"projectName": '\"$4\"', "key": '\"$2\"', "value": '\"$3\"'}'

    METADATA=$(curl -s \
    -H "Content-Type: application/json" \
    --request POST \
    --data "$CURL_DATA" \
    https://api.kube.iungo.ink/project/metadata)

    echo $METADATA
fi

if [ "$1" = "getMetadata" ];
  then
    CURL_DATA='{"projectName": '\"$4\"', "version": '\"$2\"', "key": '\"$3\"'}'

    METADATA=$(curl -s \
    -H "Content-Type: application/json" \
    --request GET \
    --data "$CURL_DATA" \
    https://api.kube.iungo.ink/project/metadata:single)

    echo $METADATA
fi

if [ "$1" = "getDeployed" ];
  then
  CURL_DATA='{"projectName": '\"$3\"', "stage": '\"$2\"'}'

  VERSION=$(curl -s \
    -H "Content-Type: application/json" \
    --request POST \
    --data "$CURL_DATA" \
    https://api.kube.iungo.ink/project/deploy/get)

  echo $VERSION
fi

