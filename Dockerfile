# our R base image
FROM r-base

# install packages
# these are ones I like
RUN echo 'install.packages(c("ggplot2", "plyr", "reshape2", "RColorBrewer", "scales","grid", "wesanderson", "Rserve"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# create an R user
ENV HOME /home/ruser
RUN useradd --create-home --home-dir $HOME ruser \
    && chown -R ruser:ruser $HOME

WORKDIR $HOME
USER ruser

# set the command
ADD start.R start.R
ADD Rserv.conf Rserv.conf
EXPOSE 6311
CMD Rscript start.R
