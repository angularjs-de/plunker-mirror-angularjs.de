#!/usr/bin/env bash

CONFIG_FILE="config.sh"

if [ ! -f $CONFIG_FILE ]; then
	echo "WARNING: No file $CONFIG_FILE found. Please, create one according to the sample file."
	echo "Just copy the sample file!"
	echo "cp config.sample.sh config.sh"
	exit 0
fi

# EXECUTE CONFIG SCRIPT
source ./$CONFIG_FILE


if [ -z $BASE_PATH ]; then
	echo "Config variable BASE_PATH is missing. Please add it in your $CONFIG_FILE"
	exit 0
fi


# READ AND CHECK PLUNKER_HASH
PLUNKER_HASH=$1
if [ -z $PLUNKER_HASH ]; then
	echo "Please add the plunker hash from the url (http://embed.plnkr.co/<hash>/preview) as parameter"
	exit 0
fi

# DOMAIN VARIABLES
PLUNKER_EMBED_DOMAIN="embed.plnkr.co"
PLUNKER_RUN_DOMAIN="run.plnkr.co"

# PLUNKER FILE
PLUNKER_PREVIEW_FILE="$PLUNKER_EMBED_DOMAIN/$PLUNKER_HASH/preview"

# URLS
PLUNKER_PREVIEW_URL="http://$PLUNKER_PREVIEW_FILE"
PLUNKER_RUN_URL="http://$PLUNKER_RUN_DOMAIN/plunks/$PLUNKER_HASH/"

# DOWNLOAD STATIC RESOURCES
wget --page-requisites $PLUNKER_PREVIEW_URL
wget --page-requisites $PLUNKER_RUN_URL

# REPLACE RUN IFRAME URLS IN JSON
perl -pi -e 's!http:\\x2F\\x2F'$PLUNKER_RUN_DOMAIN'!/'$BASE_PATH'/'$PLUNKER_RUN_DOMAIN'!g' $PLUNKER_PREVIEW_FILE

# REPLACE STATIC RESOURCE PATHS
for DIR_NAME in $(ls $PLUNKER_EMBED_DOMAIN)
do
	SEARCH="$DIR_NAME/"
	REPLACE="$BASE_PATH/$PLUNKER_EMBED_DOMAIN/$DIR_NAME/"
	perl -pi -e 's!'$SEARCH'!'$REPLACE'!g' $PLUNKER_PREVIEW_FILE
done

# EMBED JS AND CSS
EMBED_CSS_FILE="$PLUNKER_EMBED_DOMAIN/css/embed-min.css"
EMBED_JS_FILE="$PLUNKER_EMBED_DOMAIN/js/embed-min.js"

# MOVE FILES WITH FLAWED SUFFIX
mv $EMBED_CSS_FILE?_= $EMBED_CSS_FILE
mv $EMBED_JS_FILE?_= $EMBED_JS_FILE

# REPLACE IMG PATH IN CSS
PLUNKER_IMG="img/plunker.png"
perl -pi -e 's!'$PLUNKER_IMG'!'$BASE_PATH'/'$PLUNKER_EMBED_DOMAIN'/'$PLUNKER_IMG'!g' $EMBED_CSS_FILE

# ADD CORRECT BASE_TAG AFTER HEAD
BASE_PREVIEW_PATH="/$BASE_PATH$PLUNKER_EMBED_DOMAIN/$PLUNKER_HASH"
perl -pi -e  's!<head>!<head>\n<base href="'$BASE_PREVIEW_PATH'"><base/>!' $PLUNKER_PREVIEW_FILE

# RESET HTML5 MODE
perl -pi -e  's/html5Mode\(!0\)/html5Mode(!1)/' $EMBED_JS_FILE


# CREATE .html FILE FOR GITHUB CONTENT_TYPE DETECTION
cp $PLUNKER_PREVIEW_FILE $PLUNKER_PREVIEW_FILE.html