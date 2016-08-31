#!/bin/bash

set -e

# This should probably be replaced with a more intelligent perl script

perlbin=perl5.18.4
perlarg=-Mblib=../../Sereal/Perl/Decoder/blib

function run_gdb {
    gdb -ex "r $perlarg run-one.pl <$1" $perlbin
}

function run_valgrind {
    valgrind $perlbin $perlarg run-one.pl <$1
}

function run_perl {
    $perlbin $perlarg run-one.pl <$1
}

runner=run_perl

case "$1" in
    "gdb") runner=run_gdb ;;
    "valgrind" ) runner=run_valgrind ;;
esac

echo "using runner $runner"

for i in corpus/5.18/* ; do
    $runner $i
done
