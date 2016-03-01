# Provision Shiny Server with Vagrant



Vagrantfile to provision [R](https://www.r-project.org) and [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server2/) on ubuntu 12.04 using virtualbox.  
Installs and compiles a long list of useful R packages, and some basic
[Bioconductor](https://www.bioconductor.org) packages.

Placing app code inside the apps/ directory
located alongside the Vagrantfile will serve
the app at localhost:3838/apps/

See [localhost:3838/apps/test/](localhost:3838/apps/test/)
to confirm that this is functioning correctly.

TODO:
- Break bootstrap.sh into alternative
bootstrap files allowing varying degrees of
R and Bioconductor package preinstallation.
