Bootstrap: docker
From: centos:7

%files
	./scif_app_recipes  /opt/scif_app_recipes

%post
	echo "Install basic development tools" && \
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


    # Executables must be exported for nextflow, if you use their singularity native integration.
    # It would be cool to use $SCIF_APPBIN_bwa variable, but it must be set after PATH variable, because I tried to use it here and in %environment without success.
    # Include them also in /etc/bashrc
	echo "export LC_ALL=en_US.UTF-8" >> /etc/bashrc
	find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\$PATH:$in" >> /etc/bashrc;done
	if [ -z "${LD_LIBRARY_PATH-}" ]; then echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /etc/bashrc;fi
	find /scif/apps -maxdepth 2 -name "lib" | while read in; do echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$in" >> /etc/bashrc;done

%runscript
    exec scif "$@"
