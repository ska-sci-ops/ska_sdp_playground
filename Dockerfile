FROM ubuntu:23.04

    ENV DEBIAN_FRONTEND=noninteractive

    # Ubuntu apt installs
    RUN apt-get update \
    && apt-get --yes install --no-install-recommends \
        build-essential \
        casacore-data \
        casacore-dev \
        cmake \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-casacore \
        wget \
        git \
        libblas-dev \
        libboost-date-time-dev libboost-filesystem-dev \
        libboost-program-options-dev libboost-system-dev \
        libcfitsio-dev libfftw3-dev libgsl-dev \
        libhdf5-dev liblapack-dev libopenmpi-dev \
        libpython3-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

    # Install commonly used python packages
    RUN pip install numpy matplotlib astropy ipython pandas notebook --break-system-packages

    # NRAO CASA
    RUN pip install casatasks --break-system-packages

    # xradio
    RUN pip install xradio==0.0.44 --break-system-packages

    # SKA SDP Spectral Line Imaging Pipeline
    RUN pip install --extra-index-url https://artefact.skao.int/repository/pypi-internal/simple ska-sdp-spectral-line-imaging --break-system-packages

    # Install Everybeam
    RUN cd / && git clone https://git.astron.nl/RD/EveryBeam.git \
    && cd EveryBeam && git checkout v0.6.0 \
    && mkdir build && cd build \
    && cmake ../ \
    && make -j $threads && make install \
    && cd / && rm -rf EveryBeam

    # Install IDG
    RUN cd / && git clone https://gitlab.com/astron-idg/idg.git \
    && cd idg && git checkout 1.2.0 \
    && mkdir build && cd build \
    && cmake \
    -DBUILD_LIB_CUDA=Off \
    ../ \
    && make && make install && cd / && rm -rf idg

    # Install wsclean
    RUN cd / && git clone https://gitlab.com/aroffringa/wsclean.git \
    && cd wsclean && git checkout v3.5 \
    && mkdir build && cd build \
    && cmake ../ \
    && make && make install \
    && cd / && rm -rf wsclean