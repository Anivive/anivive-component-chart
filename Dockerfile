FROM us-central1-docker.pkg.dev/anivive-207100/containerimages/nxf-gcc:latest

RUN set -x && \
    . /usr/share/lmod/lmod/init/sh && \
    eb --robot Bowtie2-2.4.1-GCC-9.3.0.eb SAMtools-1.10-GCC-9.3.0.eb --installpath=/app/ --prefix=/scratch --tmpdir=/scratch/tmp

RUN echo 'module load Bowtie2/2.4.1-GCC-9.3.0 SAMtools/1.10-GCC-9.3.0' >> ${HOME}/.bashrc

CMD ["/bin/bash", "-l"]