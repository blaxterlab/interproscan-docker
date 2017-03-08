# interproscan-docker
Docker container to run EBI Interproscan

Follows instructions at https://github.com/ebi-pf-team/interproscan/wiki/HowToDownload and adapts https://hub.docker.com/r/tabotaab/interproscan_5.21-60.0/

To run on a protein fasta file in the current working directory, and to put the output back in the current working directory:

```
docker run -u $UID:$GROUPS --rm \
    -v `pwd`:/dir \
    -v `pwd`:/in \
    blaxterlab/interproscan:latest \
    interproscan.sh -i /in/test_proteins.fasta -d /dir
```

You can run a complete interproscan command with all options (see https://github.com/ebi-pf-team/interproscan/wiki/HowToRun) using the docker command above.
You can also edit the default interproscan.properties file as shown in https://github.com/ebi-pf-team/interproscan/wiki/ConfigurationOptions 
and https://github.com/ebi-pf-team/interproscan/wiki/ImprovingPerformance and mount this file inside the container using this command:

```
docker run -u $UID:$GROUPS --rm \
    -v `pwd`:/dir \
    -v `pwd`:/in \
    -v `pwd`/interproscan.properties:/interproscan-5.22-61.0/interproscan.properties \
    blaxterlab/interproscan:latest \
    interproscan.sh -i /in/test_proteins.fasta -d /dir
```
