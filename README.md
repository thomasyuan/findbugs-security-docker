# findbugs-sec

Spotbugs + security plugin Docker container

Very much a PoC at this moment. The Dockerfile needs some love.

[Find Security Bugs](http://find-sec-bugs.github.io/) is a promising plugin that extends the old warhorse [FindBugs](http://findbugs.sourceforge.net/). Hopefully the Docker image built from this repository makes it easier to use in certain situations, like CI/CD pipeline.

To run, do something like this. Assuming your source code is under "src" in the current directory:

```
docker pull lokori/findbugs-sec
docker run --rm  -v `pwd`:/workdir/src thomasyuan/spotbug-findsecbug src
```

## Getting useful report out of the container.

Docker volume mount lets the container output the file for you.

To get a HTML report in your current working directory out of the Docker container you could try this:
```
 docker run --rm -v `pwd`:/workdir/src thomasyuan/spotbug-findsecbug -html -output /workdir/src/findsec-report.html src
```

Or put some more options, with respect to your preferences. This is my current default:
```
docker run --rm -v `pwd`:/workdir/src thomasyuan/spotbug-findsecbug -html:fancy-hist.xsl -effort:max -relaxed  -output /workdir/src/findsec-report.html src
```

Third example. -u option is used to maintain proper file ownership when the container writes the files as host machine has different users.

```
docker run --rm -u 498:497 -v `pwd`:/workdir/src thomasyuan/spotbug-findsecbug -nested:false -onlyAnalyze fi.solita.- -html -output /workdir/src/findsec-report.html src/awesome-api-0.0.1-SNAPSHOT.jar
```
