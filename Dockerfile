FROM biocontainers/biocontainers:v1.1.0_cv2

################## METADATA ######################

LABEL base_image="biocontainers:v1.1.0_cv2"
LABEL version="2"
LABEL software="bowtie2"
LABEL software.version="2.5.3"
LABEL about.summary="an ultrafast memory-efficient short read aligner"
LABEL about.home="http://bowtie-bio.sourceforge.net/bowtie2/index.shtml"
LABEL about.documentation="http://bowtie-bio.sourceforge.net/bowtie2/index.shtml"
LABEL about.license_file="http://bowtie-bio.sourceforge.net/bowtie2/index.shtml"
LABEL about.license="SPDX:Artistic-2.0"
LABEL extra.identifiers.biotools="bowtie2"
LABEL about.tags="Genomics"
LABEL extra.binaries="bowtie2"

################## INSTALLATION Bowtie2 ######################
ENV ZIP=bowtie2-2.5.3-linux-x86_64.zip
ENV URL=https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.5.3
ENV FOLDER=bowtie2-2.5.3-linux-x86_64
ENV DST=/home/biodocker/bin
ENV ULOCAL=/usr/local/bin

USER 0

RUN wget $URL/$ZIP/download -O $DST/$ZIP --no-check-certificate && \
    unzip $DST/$ZIP -d $DST && \
    rm $DST/$ZIP && \
    mv $DST/$FOLDER/* $DST && \
    rmdir $DST/$FOLDER

RUN apt update
RUN apt install python3  -y

RUN ln -s $DST/* $ULOCAL/

################## INSTALLATION samtools ######################
ENV TAR=samtools-1.19.2.tar.bz2
ENV URL=https://github.com/samtools/samtools/releases/download/1.19.2
ENV FOLDER=samtools-1.19.2
ENV DST=/home
ENV ULOCAL=/usr/local/bin

USER 0
WORKDIR /home

RUN apt update

RUN apt install libz-dev libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev -y

RUN apt clean

RUN apt purge

RUN wget $URL/$TAR -O $DST/$TAR --no-check-certificate && \
    tar jxf $DST/$TAR  && \
    rm $DST/$TAR && \
    cd $DST/$FOLDER \
    ./configure && \
    make && \
    make install

WORKDIR /data