ARG IMAGE
FROM $IMAGE

ADD install_packages.R /tmp/
ADD bioconductor_packages.txt /tmp/
ADD devtools_packages.txt /tmp/
ADD CRAN_packages.txt /tmp/
ADD requirements.txt /tmp/

RUN Rscript /tmp/install_packages.R  && \
    pip install -r /tmp/requirements.txt --no-cache-dir 

RUN apt autoremove && \
    apt clean && \
    apt autoclean && \
    rm -rf /tmp/*
