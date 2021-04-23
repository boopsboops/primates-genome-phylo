#!/usr/bin/env bash

# INSTALL TAPIR AND DEPENDENCIES

# http://faircloth-lab.github.io/tapir/
# https://github.com/faircloth-lab/tapir

# python dependencies
sudo apt-get install python-pip python-numpy python-scipy python-nose
sudo apt-get install gfortran libatlas-base-dev liblapack-dev

# install dendropy (need an older version of dendropy for tapir)
git clone https://github.com/jeetsukumaran/DendroPy.git
cd DendroPy
git checkout v3.12.2
sudo python setup.py install

# install rpy2 (maybe not needed actually, because can use R direct from db)
sudo pip install rpy2

# to install hyphy
mkdir hyphy
cd hyphy
wget http://s3.faircloth-lab.org/packages/hyphy2.linux.gz
gunzip hyphy2.linux.gz
chmod 0700 hyphy2.linux
mv hyphy2.linux hyphy2
export PATH=/home/rupert/Software/hyphy:$PATH
export PATH=/home/tomas/bin/hyphy:$PATH

# get and install tapir (don't use pip as it installs an old version of tapir)
git clone https://github.com/faircloth-lab/tapir.git
cd tapir
python setup.py build
python setup.py test
sudo python setup.py install
# to test tapir start 'python' in the terminal
# 'import tapir'
# 'tapir.test()'
# 'quit()'


# to run tapir - need to not use --multiprocessing as it causes errors. run individually
cd ../../temp/tapir
mkdir nex
mkdir output

# calc rates individually by removing and adding nex into the nex folder, then moving the rates file
tapir_compute.py nex nex/Perelman_strict.nwk --output output --times 1,10,20,30,40,50,60,70 --intervals 1-10,10-20,20-30,30-40,40-50,50-60,60-70 --tree-format newick --threshold 12

# then compute PI after moving the rates files
tapir_compute.py good_rates nex/Perelman_strict.nwk --output output --times 1,10,20,30,40,50,60,70 --intervals 1-10,10-20,20-30,30-40,40-50,50-60,60-70 --tree-format newick --threshold 12 --site-rates