
# yfull

## 功能

- fastqc -- 质量控制
- fastp -- 质量控制，引物切除
- bwa mem -- 比对
- bam filter -- 低质量比对过滤
- bqsr -- 碱基质量值校正
- haplotype caller and genotype caller -- 单倍体型和基因型检出

## 安装

### 需要的工具

#### 以下工具应该在命令的搜索路径中

- python，版本 >= 2.7
- pip，python 包管理工具 pip

如何安装 pip 请见 https://pip.pypa.io/en/stable/installing/

简而言之，安装 pip 命令如下：

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python get-pip.py --user

"--user" 使在非管理员权限下安装，安装的 pip 位于 ~/.local/bin 路径下，为了方便使用 pip 命令，将 ~/.local/bin 加入命令的搜索路径中。

- fastp
- fastqc
- bwa
- samtools

#### 需要以下 jar 包

- picard
- gatk，目前仅支持版本 3，且版本 >=3.7。

### 安装步骤

1. 推荐在虚拟环境下安装，首先安装 virtualenv

pip install --user virtualenv

"--user" 选项同样会将命令 virtualenv 安装于 ~/.local/bin 路径下

2. 建立虚拟环境并激活虚拟环境

virtualenv a_virtual_env

. a_virtual_env/bin/activate

需要注意的是，如果建立了虚拟环境，则每次运行程序时都需要激活虚拟环境，通过 ". a_virtual_env/bin/activate" 实现，注意 "." 是一个命令。

3. 安装程序脚本

pip install git+https://code.csdn.net/YINGNN0/cal.git

如果不建立虚拟环境，可以省略步骤 1，2。这时第三步可以加上 "--user" 使在非管理员权限下也能安装。

4. 运行命令

确保安装的脚本位于可执行文件的搜索路径下

激活环境变量 YFUL_RC, YFUL_RC 指向脚本运行时需要的一些变量和方程的配置文件，默认为 ~/.config/yfulrc。YFUL_RC 可先自行指定。

. activate_yful.sh

yful --help

yful --config yful.cfg list

yful.cfg 是程序的配置文件，list 是每行四列的文件，各列分别表示 sample_id sample_name path/to/read1.fq path/to/read2.fq，以 tab 分隔

需要注意的是 yful.cfg 在第一次运行程序时和每次 yful.cfg 更改后需要经由 --config yful.cfg 生成环境变量 YFUL_RC 指向的配置文件，默认为 ~/.config/yfulrc。

查看配置和输入示例文件

示例文件在 examples 路径下，分别为 examples/yful.cfg examples/list

日志文件存放于当前路径下，分别为 .log0 .log1。

## 需要的文件
### reference genome
参考基因组使用 GRCh38，即染色体命名没有前缀 ‘Chr’，使用 1-22，X，Y，
MT 共 25 个 contig，其他弃用。其中 MT id 为 NC_012920.1（即为rCRS？）。

运行脚本前下载参考基因组和给参考基因组建立索引的示例：

download_ref.sh hg38

需要注意的是下载的参考基因组需要解压缩，并清理不必要的 config

ref_index.sh ref.fasta

### Indel realignment standard
从 gatk 获得的 vcf 文件
### Base quality score recalibration standard
从 gatk 获得的 vcf 文件

获取这些标准文件使用

download_std.sh hg38 &





