ARG IMAGE
FROM $IMAGE
ARG SAMTOOLS_VERSION=1.22

ADD install_packages.R /tmp/
ADD bioconductor_packages.txt /tmp/
ADD devtools_packages.txt /tmp/
ADD CRAN_packages.txt /tmp/
ADD requirements.txt /tmp/

RUN cd /tmp/ && wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 -O /tmp/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && tar -jxvf /tmp/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && cd /tmp/samtools-${SAMTOOLS_VERSION} \
    && ./configure && make && make install && \
    Rscript /tmp/install_packages.R  && \
    pip install -r /tmp/requirements.txt --no-cache-dir 


RUN apt autoremove && \
    apt clean && \
    apt autoclean && \
    rm -rf /tmp/*
