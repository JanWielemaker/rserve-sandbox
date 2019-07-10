# our R base image
FROM r-base

RUN apt-get update && apt-get install -y \
	libcurl4-openssl-dev \
	libssl-dev \
	libcairo-dev
# BiocManager requirements
RUN apt-get update && apt-get install -y \
	libxml2-dev \
	libudunits2-dev \
	libgeos++-dev \
	libtiff-dev \
	libopenmpi-dev

# install packages
# these are ones I like
RUN echo 'install.packages(c("ggplot2"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

RUN echo 'install.packages("Rserve",,"http://rforge.net/",type="source")' > /tmp/packages2.R \
    && Rscript /tmp/packages2.R

# Popular data science packages
RUN echo 'install.packages(c("data.table", "dplyr", "plyr", "scales", "lubridate", "ggplot2", "grid", "BSDA", "cluster", "clustertend", "factoextra", "heatmaply", "NbClust", "RColorBrewer", "pandoc"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# Bio DB packages
RUN echo 'install.packages(c("igraph"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# Bio DB packages
RUN echo 'install.packages(c("qgraph", "svglite", "GGally", "network", "sna"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# Optional Bio DB packages
RUN echo 'install.packages(c("pheatmap", "NMF"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# BiocManager
RUN echo 'install.packages(c("BiocManager"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# GOstats
RUN echo 'BiocManager::install("GOstats")' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# Disable development tools
RUN chmod o-rwx \
	/usr/lib/gcc /usr/lib/python* /usr/lib/tcltk /usr/lib/valgrind \
	/sbin /usr/sbin /usr/local/bin \
	/usr/bin/* /bin/* && \
    chmod o+x \
	/bin/bash /bin/ls /bin/uname /bin/sh && \
    chmod o+rx \
	/usr/bin/R /usr/bin

VOLUME /rserve

# set the command
RUN mkdir /home/ruser
ADD Rserv.conf /home/ruser/Rserv.conf
ADD Rserv.sh /home/ruser/Rserv.sh
WORKDIR /home/ruser

ENTRYPOINT ["./Rserv.sh"]
