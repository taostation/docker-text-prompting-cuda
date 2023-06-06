# Build container
FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel

# Build arguments
ARG BRANCH=master
WORKDIR /

# install tools and dependencies
RUN apt update && \
  apt upgrade -y && \
  apt install -y python3 python3-pip gcc python3-dev cargo git g++ cmake make curl && \
  git clone -b $BRANCH https://github.com/opentensor/validators.git && \
  cd validators && \
  pip3 install -e . && \
  apt purge -y gcc python3-dev cargo git g++ cmake make curl && \
  apt -y autoremove && \
  rm -rf /var/lib/apt/lists/*

# Start inside the bittensor git folder
WORKDIR /validators
ENTRYPOINT ["python3", "openvalidators/neuron.py"]

