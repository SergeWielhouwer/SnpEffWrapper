#!/bin/bash

set -x
set -e

start_dir=$(pwd)

#SNPEFF_VERSION="v4_1l_core"
SNPEFF_VERSION="v4_3t_core"
SNPEFF_DOWNLOAD_URL="http://sourceforge.net/projects/snpeff/files/snpEff_${SNPEFF_VERSION}.zip"

# Make an install location
if [ ! -d "${start_dir}/build" ]; then
  mkdir "${start_dir}/build"
fi
build_dir="${start_dir}/build"

# DOWNLOAD ALL THE THINGS
download () {
  url=$1
  download_location=$2

  if [ -e $download_location ]; then
    echo "Skipping download of $url, $download_location already exists"
  else
    echo "Downloading $url to $download_location"
    wget $url -O $download_location
  fi
}

cd $build_dir
download $SNPEFF_DOWNLOAD_URL snpEff_${SNPEFF_VERSION}.zip

if [ -e "snpEff_${SNPEFF_VERSION}" ]; then
  echo "Skipping unzip of snpEff_${SNPEFF_VERSION}.zip; it already exists"
else
  unzip snpEff_${SNPEFF_VERSION}.zip
  mv snpEff snpEff_${SNPEFF_VERSION}
fi

export SNPEFF_EXEC="${build_dir}/snpEff_${SNPEFF_VERSION}/snpEff.jar"

cd $start_dir

set +x
set +e
