FROM rocker/r-ver:3.6.1

# install and update some linux packages then clean up
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    psmisc \
    procps \
    wget \
    libxml2-dev \
    libpq-dev \
    libssh2-1-dev \
    ca-certificates \
    libglib2.0-0 \
	  libxext6 \
	  libsm6  \
	  libxrender1 \
	  bzip2 \
    zlib1g-dev \
    && wget -O libssl1.0.0.deb http://ftp.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb \
    && dpkg -i libssl1.0.0.deb \
    && rm libssl1.0.0.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ 

# install Python 3.7 (Miniconda) and Tensorflow Python packages then set  path variables.
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.8.1-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
RUN /opt/conda/bin/pip install --no-cache-dir tensorflow==2.0.0 h5py==2.10.0
ENV PATH /opt/conda/bin:$PATH
ENV RETICULATE_PYTHON /opt/conda/bin/python

# copy the files
COPY / /

# install the needed R packages
RUN Rscript setup.R

EXPOSE 80

ENTRYPOINT ["Rscript","main.R"]