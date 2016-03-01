#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install git gcc
sudo apt-get -y install libxml2-dev libcurl4-openssl-dev libssl0.9.8 libcairo2-dev
# python-software-properties needed to use add-apt-repository below on 12.04
sudo apt-get -y install python-software-properties
# need external repo to get recent R on 12.04
sudo add-apt-repository ppa:marutter/rrutter
# Ideally I would use https to access all cran/rstudio servers, but there are constant keyserver errors with AWS
gpg --keyserver pgpkeys.mit.edu --recv-key 51716619E084DAB9
gpg -a --export 51716619E084DAB9 | sudo apt-key add -
# comment out the following line if doing vagrant reload --provision otherwise it will keep adding duplicates to sources.list
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu precise/" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get -y install r-base r-base-dev
# outdated codetools was preventing installation of all necessary R packages
# all packages must be installed system wide as below..
sudo su - -c "R -e \"install.packages('codetools', repos='http://cran.rstudio.com/', dep = TRUE)\""
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/', dep = TRUE)\""
# add a pile of useful packages straight away
# This takes a while as there are a bunch of Rcpp packages to compile
# Also requires a vm with at least 2Gb ram otherwise RCppEigen compilation hangs
sudo su - -c "R -e \"install.packages(c('broom', 'car', 'd3heatmap', \
  'd3Network', 'DiagrammeR', 'dplyr', 'DT', 'genoPlotR', 'GGally', \
  'ggthemes', 'gplots', 'htmlwidgets', 'leaflet', 'lubridate', 'moments', \
  'plot3D', 'plot3Drgl', 'plotly', 'purrr', 'R.utils', 'RColorBrewer', \
  'RcppRoll', 'readr', 'readxl', 'reshape2', 'RSQLite', 'ggplot2', 'magrittr', \
  'rvest', 'shinyAce', 'shinyBS', 'shinydashboard', 'shinyFiles', \
  'svglite', 'threejs', 'tidyr', 'tm', 'viridis', 'wordcloud', \
  'zoo'), repos='http://cran.rstudio.com/', dep = TRUE)\""
# Add Bioconductor packages here - note https not supported
sudo su - -c "R -e \"source('http://bioconductor.org/biocLite.R'); biocLite()\""
# install shiny server
sudo apt-get -y install gdebi-core
wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.2.786-amd64.deb
sudo gdebi shiny-server-1.4.2.786-amd64.deb
sudo dpkg -i *.deb
rm *.deb
# this may throw an error if symlink to apps/ already exists from initial provision
sudo ln -s /vagrant/apps /srv/shiny-server
sudo usermod -a -G vagrant shiny
