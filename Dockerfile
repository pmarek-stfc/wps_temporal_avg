# vim:set ft=dockerfile:
FROM continuumio/miniconda3
MAINTAINER https://github.com/pmarek-stfc/wps_exercise
LABEL Description="wps_exercise WPS" Vendor="Birdhouse" Version="0.1.0"

# Update Debian system
RUN apt-get update && apt-get install -y \
 build-essential \
&& rm -rf /var/lib/apt/lists/*

# Update conda
RUN conda update -n base conda

# Copy WPS project
COPY . /opt/wps

WORKDIR /opt/wps

# Create conda environment
RUN conda env create -n wps -f environment.yml

# Install WPS
RUN ["/bin/bash", "-c", "source activate wps && python setup.py develop"]

# Start WPS service on port 5000 on 0.0.0.0
EXPOSE 5000
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["source activate wps && exec wps_exercise start -b 0.0.0.0 -c /opt/wps/etc/demo.cfg"]

# docker build -t pmarek-stfc/wps_exercise .
# docker run -p 5000:5000 pmarek-stfc/wps_exercise
# http://localhost:5000/wps?request=GetCapabilities&service=WPS
# http://localhost:5000/wps?request=DescribeProcess&service=WPS&identifier=all&version=1.0.0
