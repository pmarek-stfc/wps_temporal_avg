# Installation and getting started

## Instructions for getting the server running

On a new VM:

```
ssh root@...my-vm...
mkdir -p /usr/local/wps-test
cd /usr/local/wps-test

yum install -y python3 gcc python3-devel

python3 -m venv server
. server/bin/activate

git clone https://github.com/pmarek-stfc/wps_temporal_avg
cd wps_temporal_avg/

pip install -r requirements.txt

make install
make start
```

## Instructions for getting the client running

On the same VM:

```
ssh root@...my-vm...
cd /usr/local/wps-test

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b

# !! Now close and re-open shell to see "conda"

cd /usr/local/wps-test/
conda create --name client
conda activate client

conda install -c conda-forge birdy
```

## Testing with the client

You need some data, copy some locally from CEDA archive:

```
ssh root@...my-vm...

mkdir -p /badc/cmip5/data/cmip5/output1/MOHC/HadGEM2-CC/rcp45/mon/atmos/Amon/r1i1p1/latest/tas
scp -v <USERID>@jasmin-xfer1.ceda.ac.uk:/badc/cmip5/data/cmip5/output1/MOHC/HadGEM2-CC/rcp45/mon/atmos/Amon/r1i1p1/latest/tas/*.nc /badc/cmip5/data/cmip5/output1/MOHC/HadGEM2-CC/rcp45/mon/atmos/Amon/r1i1p1/latest/tas/

```

Run the "birdy" client:

```
birdy get_cutout -h

# Test with:
birdy get_cutout --min_lon 20 --max_lon 30 --min_lat 0 --max_lat 80
```
