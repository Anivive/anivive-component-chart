FROM us-central1-docker.pkg.dev/anivive-207100/containerimages/nxf-biocontainer:1.0

################## INSTALLATION Bowtie2 ######################
ENV ZIP=bowtie2-2.4.1-linux-x86_64.zip
ENV URL=https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.1
ENV FOLDER=bowtie2-2.4.1-linux-x86_64
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

# Copy data from local bowtie2 directory into Docker image
COPY bowtie2 /data/bowtie2


WORKDIR /data 