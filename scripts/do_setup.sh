#!/bin/bash -ex

mkdir -p ../build
cd ../build

npx circom ../src/factor/circuit.circom
npx snarkjs setup
