#!/bin/bash -e

function info() {
    echo Usage: `basename $0` '[-n sample_name] r1 r2'
    exit 1
}

while getopts ":p:f:n:r:i:d:" opt; do
    case  $opt  in
        p) out_prefix=$OPTARG;;
        f) suffix=$OPTARG;;
        n) sample_name=$OPTARG;;
        d) sample_id=$OPTARG;;
        i) interval=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 2 ]; then info; fi


. $var || :


sample_name=${sample_name:=sample_test}

fastqc.sh -s$sample_name $1
fastqc.sh -s$sample_name $2

fp.sh -p$out_prefix $1 $2

fastqc.sh -p$out_prefix.r1 $out_prefix.r1.fq
fastqc.sh -p$out_prefix.r2 $out_prefix.r2.fq


align2bam.sh -s$sample_name `opt -d $sample_id` -p$out_prefix $out_prefix.r1.fq $out_prefix.r2.fq

bam_sort_index.sh -p$out_prefix $out_prefix.bam
samtools flagstat $out_prefix.sort.bam > $out_prefix.sort.bamstat.txt

bam_filter.sh -p$out_prefix -q20 `opt -i $interval` $out_prefix.sort.bam
samtools flagstat $out_prefix.filter.bam > $out_prefix.filter.bamstat.txt


deldup.sh -p$out_prefix $out_prefix.filter.bam
samtools flagstat $out_prefix.deldup.bam > $out_prefix.deldup.bamstat.txt


# realign_indel.sh -p$out_prefix -i$interval $out_prefix.deldup.bam


bqsr.sh `opt -i $interval` -p$out_prefix $out_prefix.deldup.bam
samtools flagstat $out_prefix.bqsr.bam > $out_prefix.bqsr.bamstat.txt
fastqc.sh -p$out_prefix.realn $out_prefix.bqsr.bam
summ_gatk.sh -p$out_prefix.bqsr `opt -i $interval` $out_prefix.bqsr.bam

hap.sh -p$out_prefix `opt -i$interval` $out_prefix.bqsr.bam

. $cmd_done
