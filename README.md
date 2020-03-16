# OLTPBench for Polypheny-FRAM

[![Build Status](https://travis-ci.org/nouda/oltpbench.svg?branch=polypheny-fram)](https://travis-ci.org/nouda/oltpbench)

This repository contains a fork of the [OLTPBenchmark](https://github.com/oltpbenchmark/oltpbench/) framework made ready to benchmark [Polypheny-FRAM](https://github.com/polypheny/Polypheny-FRAM).
Further, the build process is now performed using Gradle instead of ANT.

### Dependencies
* Java 1.8 or later

### Usage
To build this fork, use `./gradlew assemble`. The archives of the OLTPBenchmark application can be found in `build/distributions`. Extract the application on the machine of your choice, switch into the extracted folder, run `./bin/oltpbenchmark ...` and happy benchmarking.
> Alternatively: Use `./gradlew installDist` to create the folder `dist` containing the application. 

Please consult the documentation of the original repository on how to further use OLTPBenchmark: [oltpbench/wiki](https://github.com/oltpbenchmark/oltpbench/wiki).

### Supported Benchmarks for Polypheny-FRAM
* [TPC-C](./config/polypheny/tpcc.xml)\
  `./bin/oltpbenchmark -b tpcc -c ./config/polypheny/tpcc.xml --create=true --load=true --execute=true`
* [YCSB](./config/polypheny/ycsb.xml)\
  `./bin/oltpbenchmark -b ycsb -c ./config/polypheny/ycsb.xml --create=true --load=true --execute=true`


# Original README

[![Build Status](https://travis-ci.org/oltpbenchmark/oltpbench.png)](https://travis-ci.org/oltpbenchmark/oltpbench)

Benchmarking is incredibly useful, yet endlessly painful. This benchmark suite is the result of a group of
Phd/post-docs/professors getting together and combining their workloads/frameworks/experiences/efforts. We hope this
will save other people's time, and will provide an extensible platform, that can be grown in an open-source fashion. 

OLTPBenchmark is a multi-threaded load generator. The framework is designed to be able to produce variable rate,
variable mixture load against any JDBC-enabled relational database. The framework also provides data collection
features, e.g., per-transaction-type latency and throughput logs.

Together with the framework we provide the following OLTP/Web benchmarks:
  * [TPC-C](http://www.tpc.org/tpcc/)
  * Wikipedia
  * Synthetic Resource Stresser 
  * Twitter
  * Epinions.com
  * [TATP](http://tatpbenchmark.sourceforge.net/)
  * [AuctionMark](http://hstore.cs.brown.edu/projects/auctionmark/)
  * SEATS ("Stonebraker Electronic Airline Ticketing System")
  * [YCSB](https://github.com/brianfrankcooper/YCSB)
  * [JPAB](http://www.jpab.org) (Hibernate)
  * [CH-benCHmark](http://www-db.in.tum.de/research/projects/CHbenCHmark/?lang=en)
  * [Voter](https://github.com/VoltDB/voltdb/tree/master/examples/voter) (Japanese "American Idol")
  * [SIBench](http://sydney.edu.au/engineering/it/~fekete/teaching/serializableSI-Fekete.pdf) (Snapshot Isolation)
  * [SmallBank](http://ses.library.usyd.edu.au/bitstream/2123/5353/1/michael-cahill-2009-thesis.pdf)
  * [LinkBench](http://people.cs.uchicago.edu/~tga/pubs/sigmod-linkbench-2013.pdf)

This framework is design to allow easy extension, we provide stub code that a contributor can use to include a new
benchmark, leveraging all the system features (logging, controlled speed, controlled mixture, etc.)

## Dependencies

+ Java (+1.7)
+ Apache Ant

## Quick Start

See the [on-line documentation](https://github.com/oltpbenchmark/oltpbench/wiki) on how to use OLTP-Bench.

## Publications

If you are using this framework for your papers or for your work, please cite the paper:

[OLTP-Bench: An extensible testbed for benchmarking relational databases](http://www.vldb.org/pvldb/vol7/p277-difallah.pdf) D. E. Difallah, A. Pavlo, C. Curino, and P. Cudre-Mauroux. In VLDB 2014.

Also, let us know so we can add you to our [list of publications](http://oltpbenchmark.com/wiki/index.php?title=Publications_Using_OLTPBenchmark).
