#!/bin/bash

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

case "$1" in
    "gdb") runner=run_gdb ;;
    "valgrind" ) runner=run_valgrind ;;
esac

for i in corpus/5.18/* ; do
    if run_valgrind $i ]; then
        echo $i pass
    else
        run_gdb $i
        exit
    fi
done
