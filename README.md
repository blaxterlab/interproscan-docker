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
and https://github.com/ebi-pf-team/interproscan/wiki/ImprovingPerformance 

For example, to run on a single machine with 64 cores, you could do:
```
curl https://raw.githubusercontent.com/ebi-pf-team/interproscan/5.22-61.0/core/jms-implementation/support-mini-x86-32/interproscan.properties \
| perl -plne 's/^(number.of.embedded.workers).*/$1=1/;s/^(maxnumber.of.embedded.workers).*/$1=63/' >interproscan.properties
```

This will update `number.of.embedded.workers=1`, and `maxnumber.of.embedded.workers=63` in the default `interproscan.properties` file for this version 5.21-60.0. Once you have this file in the current working directory, you can mount it inside the container using this command:

```
docker run -u $UID:$GROUPS --rm \
    -v `pwd`:/dir \
    -v `pwd`:/in \
    -v `pwd`/interproscan.properties:/interproscan-5.22-61.0/interproscan.properties \
    blaxterlab/interproscan:latest \
    interproscan.sh -i /in/test_proteins.fasta -d /dir -dp -f XML -goterms -pa
```
