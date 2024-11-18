FROM ubuntu:23.04

    ENV DEBIAN_FRONTEND=noninteractive

    # Ubuntu apt installs
    RUN apt-get update \
    && apt-get --yes install --no-install-recommends \
        build-essential \
        python3-dev \
        python3-pip \
        python3-setuptools \
        wget \
        git \
    && rm -rf /var/lib/apt/lists/*

    # Install commonly used python packages
    RUN pip install numpy matplotlib astropy ipython pandas notebook --break-system-packages

    # NRAO CASA
    RUN pip install casatasks --break-system-packages

    # xradio
    RUN pip install xradio==0.0.44 --break-system-packages

    # SKA SDP Spectral Line Imaging Pipeline
    RUN pip install --extra-index-url https://artefact.skao.int/repository/pypi-internal/simple ska-sdp-spectral-line-imaging --break-system-packages
