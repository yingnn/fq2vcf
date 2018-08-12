#!/bin/bash

function info() {
    echo Usage: `basename $0` version
    exit 1
}

while getopts ":p:" opt
do
    case $opt in
        p) out_prefix=$OPTARG;;
        *) echo version must be one of b37 hg19 hg38 && info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi


case $1 in
    b37) echo version b37;;
    hg19) echo hg19;;
    hg38) echo hg38;;
    *) echo version must be one of b37 hg19 hg38 && exit 1;;
esac

. $var || :

ftp_base=ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/$1

wget -c $ftp_base/*.fasta.gz

. $cmd_done
