# docker-workspace

portable workspace running inside docker

## Usage

build the container

```bash
docker build -t workspace .
```

run the container

```bash
docker run --rm -it -v $HOME/.ssh:/root/.ssh:ro -v ${PWD}:/workspace workspace
docker run --rm -it -v $HOME/.ssh:/root/.ssh:ro -v ${PWD}:/workspace --gpus all workspace
```

if you are running on an apple silicon machine you will need to
specify `--platform linux/amd64` to build and run the container.
