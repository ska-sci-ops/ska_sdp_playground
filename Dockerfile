FROM ubuntu:24.04

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
    RUN pip install numpy matplotlib astropy ipython notebook --break-system-packages

    # Install xradio
    RUN pip install xradio==0.0.43 --break-system-packages