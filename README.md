# interproscan-docker
Docker container to run EBI Interproscan

Follows instructions at https://github.com/ebi-pf-team/interproscan/wiki/HowToDownload and adapts https://hub.docker.com/r/tabotaab/interproscan_5.21-60.0/

To run on a protein fasta file in the current working directory, and to put the output back in the current working directory as testoutput

```
docker run --rm \
    --name ipr-test \
    -v `pwd`:/in \
    -v `pwd`:/out \
    blaxterlab/interproscan:latest \
    interproscan.sh -i /in/test_proteins.fasta -b /out/testoutput
```
