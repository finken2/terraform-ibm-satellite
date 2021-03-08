#!/bin/sh
# take a directory name as input
# create directory
RELEASE_DIR=$1
if [ -z "$RELEASE_DIR" ]; then
  RELEASE_DIR="release0"
fi
OUTPUT_DIR=releases/$RELEASE_DIR
TAR_NAME=$2
if [ -z "$TAR_NAME" ]; then
  TAR_NAME="v0.1.tgz"
fi
mkdir -p $OUTPUT_DIR
cp -r examples/satellite-aws/ $OUTPUT_DIR
cp -R modules $OUTPUT_DIR
# sed the files
# note, if GNU, we'll need to modify this
sed -i '' 's#../../modules#./modules#g' $OUTPUT_DIR/*.tf
# tar the files
cd $OUTPUT_DIR
tar -czf ../$TAR_NAME .

# also need TF_VERSION added to the terraform itself
