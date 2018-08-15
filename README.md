
# fq2vcf

## functions

- fastqc -- quality control
- fastp -- quality control, cut primer, adaptor, barcode etc.
- bwa mem -- mapping
- bam filter -- filter low mapping quality reads
- bqsr -- base quality score recalibration
- haplotype calling and genotype calling

## installation

### tools involved

#### tools need to be on tools' search path

- python, version >= 2.7
- pipenv, a python package management tool

how to install pipenv please see https://docs.pipenv.org/install/#installing-pipenv

briefly, installing pipenv is as follows：

1. using pip

pip install --user pipenv

2. using get-pipenv.py

curl https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py -o get-pipenv.py

python get-pipenv.py --user

The "--user" option does a user installation to prevent breaking any system-wide packages. If pipenv isn’t available in your shell after installation, you’ll need to add the user base’s binary directory to your PATH.

On Linux and macOS you can find the user base binary directory by running python -m site --user-base and adding bin to the end. For example, this will typically print ~/.local (with ~ expanded to the absolute path to your home directory) so you’ll need to add ~/.local/bin to your PATH. You can set your PATH permanently by modifying ~/.profile.

- fastp
- fastqc
- bwa
- samtools

#### jar packages involved

- picard
- gatk, version 3 and >=3.7 support currently.

### installing fq2vcf

pipenv install git+https://github.com/yingnn/fq2vcf.git#egg=fq-to-vcf

## usage

activate virtual environment

cd path/on/which/installing/fq2vcf

pipenv shell

activate environment variable FQ2VCF_RC, FQ2VCF_RC point to a file that contains some variables and functions that scripts used. the default file path is ~/.config/fq2vcfrc. FQ2VCF_RC can be set by yourself.

. activate.sh

fq2vcf --help

fq2vcf --config fq2vcf.cfg list

fq2vcf.cfg is a config file, list is a file with 4 cols per line, each col represents sample_id sample_name path/to/read1.fq path/to/read2.fq, separated by tab.

note: first time or every time that the config file changes, --config fq2vcf.cfg must be supplied for the profile file that FQ2VCF_RC point to goes into effect.

config and input example files are on examples directory, which are examples/fq2vcf.cfg and examples/list.

log files locate on work directory, they are .log0 and .log1.

## files needed before running scripts
### reference genome

scripts used for download ref genome and index ref genome

download_ref.sh

note: ref genome file should be decompressed

ref_index.sh ref.fasta

### Indel realignment standard
standard files getting from gatk bundle
### Base quality score recalibration standard
standard files getting from gatk bundle

script getting these standard files

download_std.sh





