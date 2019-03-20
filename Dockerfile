FROM centos:7

COPY ./scif_app_recipes  /opt/scif_app_recipes

RUN echo "Install basic development tools" && \
    yum -y groupinstall "Development Tools" && \
    yum -y update && yum -y install wget curl && \
    echo "Install python2.7 setuptools and pip" && \
    yum -y install python-setuptools && \
    easy_install pip && \
    echo "Installing SCI-F" && \
    pip install scif ipython && \
    echo "Installing perl" && \
    yum -y install perl perl-Data-Dumper && \
    echo "Installing GCC" && \
    scif install /opt/scif_app_recipes/gcc_v8.2.0_centos7.scif

# Include ENV variables
ENV LC_ALL=en_US.UTF-8
ENV PATH=$PATH:/scif/apps/gcc/bin
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scif/apps/gcc/lib

# Include them also in /etc/bashrc
RUN echo "export LC_ALL=en_US.UTF-8" >> /etc/bashrc
RUN find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\$PATH:$in" >> /etc/bashrc;done
RUN if [ -z "${LD_LIBRARY_PATH-}" ]; then echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /etc/bashrc;fi
RUN find /scif/apps -maxdepth 2 -name "lib" | while read in; do echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$in" >> /etc/bashrc;done

