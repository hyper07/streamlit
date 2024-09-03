FROM python:3.11-slim

WORKDIR /usr/src/app

# dont write pyc files
# dont buffer to stdout/stderr
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /usr/src/app/requirements.txt
COPY ./requirements-dev.txt /usr/src/app/requirements-dev.txt

RUN apt-get update && apt-get install libgomp1

# dependencies
RUN pip install --upgrade pip setuptools wheel \
    # && set -x HDF5_DIR "$(brew --prefix hdf5)" \
    && pip3 install --only-binary h5py h5py \
    && pip install -r requirements.txt \
    && pip install -r requirements-dev.txt \
    && rm -rf /root/.cache/pip

# COPY ./app /usr/src/app
