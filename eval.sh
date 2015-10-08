#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: eval.sh <path-to-golden.key> <path-to-system.key>"
    exit
fi

cct_jar="target/cluster-comparison-tools-1.0.0-jar-with-dependencies.jar"
golden=$1  # ~/work/joint/eval/semeval-2013-13/keys/gold/all.key"
system=$2  # ~/work/joint/eval/semeval-2013-13/keys/systems/AI-KU/remove5-add1000/y-22-cluster-test-remove5-add1000.key
sense_mapping=""  # or "--no-remapping" for .wn.


for metric in edu.ucla.clustercomparison.cl.JaccardIndexScorer edu.ucla.clustercomparison.cl.WeightedNdcgScorer  edu.ucla.clustercomparison.cl.WeightedTauScorer edu.ucla.clustercomparison.FuzzyNormalizedMutualInformation edu.ucla.clustercomparison.FuzzyBCubed
do
    printf "$metric\n"
    java -cp $cct_jar $metric $sense_mapping $golden $system
done
