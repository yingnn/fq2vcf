#!/bin/bash -e

test -z "$FQ2VCF_RC" && FQ2VCF_RC=~/.config/fq2vcfrc
export FQ2VCF_RC
export var=$FQ2VCF_RC
