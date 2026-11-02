
These are instructions to install and run the workflow on command line.
You can also access the workflow via the
[EPI2ME Desktop application](https://labs.epi2me.io/downloads/).

The workflow uses [Nextflow](https://www.nextflow.io/) to manage
compute and software resources,
therefore Nextflow will need to be
installed before attempting to run the workflow.

The workflow can currently be run using either
[Docker](https://docs.docker.com/get-started/)
or [Singularity](https://docs.sylabs.io/guides/3.0/user-guide/index.html)
to provide isolation of the required software.
Both methods are automated out-of-the-box provided
either Docker or Singularity is installed.
This is controlled by the
[`-profile`](https://www.nextflow.io/docs/latest/config.html#config-profiles)
parameter as exemplified below.

It is not required to clone or download the git repository
in order to run the workflow.
More information on running EPI2ME workflows can
be found on our [website](https://labs.epi2me.io/wfindex).

This fork is run from a local clone. Build the workflow container once so both minimap2 and bonefish are available:

```
docker build -t wf-16s-bonefish:latest -f containers/Dockerfile containers/
nextflow run . --help
```

If `docker` reports permission denied on `/var/run/docker.sock` but `getent group docker` already lists your user, the current login has not picked up the group yet. Open a new terminal, or run `newgrp docker`, then retry.

If Docker is not available, download the bonefish binary and run with Singularity/Apptainer. The singularity profile bind-mounts `containers/bonefish` into the official wf-metagenomics image:

```
bash containers/fetch-bonefish.sh
nextflow run . -profile singularity --help
```

A demo dataset is provided for testing of the workflow.
It can be downloaded and unpacked using the following commands:
```
wget https://ont-exd-int-s3-euwst1-epi2me-labs.s3.amazonaws.com/wf-16s/wf-16s-demo.tar.gz
tar -xzvf wf-16s-demo.tar.gz
```
The workflow can then be run with the downloaded demo data using:
```
nextflow run . \
	--fastq 'wf-16s-demo/test_data' \
	--minimap2_by_reference \
	-profile standard
```
To classify with bonefish instead of minimap2:
```
nextflow run . \
	--fastq 'wf-16s-demo/test_data' \
	--classifier bonefish \
	-profile standard
```
High-accuracy ONT mapping for either alignment classifier:
```
nextflow run . --fastq 'wf-16s-demo/test_data' --classifier bonefish --align_preset lr:hq
```

For further information about running a workflow on
the command line see https://labs.epi2me.io/wfquickstart/
