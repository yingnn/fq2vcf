#!/bin/bash

function info() {
echo Usage: `basename $0` '[-i] <input.bam>'
exit 1
}

while getopts  ":Gp:m:i:" opts
do
	case  $opts  in
	p) out_prefix=$OPTARG;;
   i) interval=$OPTARG;;
	?) info;;
	esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info;  fi


. $var || :

if [ -n "$interval" ]; then interval="-L $interval"; fi

if [ -z $out_prefix ]; then
	out_prefix=1.gatk.depth
fi

echo;echo;echo gatk summary
java.sh -m$java_memory -d$java_tmp_dir $gatk \
   DepthOfCoverage \
   -R $ref_genome $interval \
   -o $out_prefix \
   --omitDepthOutputAtEachBase \
   --omitLocusTable \
   --outputFormat csv \
   -I $1 \
   -ct 1 -ct 10 -ct 30 -ct 100 -ct 500

. $cmd_done
