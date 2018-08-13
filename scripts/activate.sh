#!/bin/bash -e

echo $1
cd $1
pwd
pipenv shell
test -z "$FQ2VCF_RC" && FQ2VCF_RC=~/.config/fq2vcfrc
export FQ2VCF_RC
export var=$FQ2VCF_RC
cd -
