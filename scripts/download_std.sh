#!/bin/bash

function info() {
    echo Usage: `basename $0` version
    exit 1
}

while getopts ":p:" opt
do
    case $opt in
        p) out_prefix=$OPTARG;;
        *) echo version must be one of b37 hg38 && info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

case $1 in
    b37) echo version b37;;
    hg38) echo hg38;;
    *) echo version must be one of b37 hg38 && exit 1;;
esac

. $var || :

version=$1

ftp_base=ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/$version

# both indel and bqsr
for i in Mills_and_1000G_gold_standard.indels.$version.vcf.gz 1000G_phase1.indels.$version.vcf.gz beta/Homo_sapiens_assembly38.known_indels.vcf.gz
do
    j=`basename $i`
    i_idx=$i.tbi
    j_idx=$j.tbi
    wget -c $ftp_base/$i
    wget -c $ftp_base/$i_idx
    ln -sf $j indel_std.bqsr_std.$j
    ln -sf $j_idx indel_std.bqsr_std.$j_idx
done

# indel

# bqsr
for i in dbsnp_146.hg38.vcf.gz dbsnp_138.b37.vcf.gz 1000G_phase1.snps.high_confidence.hg38.vcf.gz beta/Homo_sapiens_assembly38.variantEvalGoldStandard.vcf.gz beta/NISTIntegratedCalls.hg38.vcf.gz
do
    j=`basename $i`
    i_idx=$i.tbi
    j_idx=$j.tbi
    wget -c $ftp_base/$i
    wget -c $ftp_base/$i_idx
    ln -sf $j bqsr_std.$j
    ln -sf $j_idx bqsr_std.$j_idx
done

set_done

