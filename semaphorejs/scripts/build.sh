cd $1

if [ ! -f "circuit.json" ]; then
    echo -e "\ncircuit.json not existed, please execute 'circom <your circuit>' first."
    exit 1;
fi 

echo -e "\ncalculating witness..."
if [ ! -f "input.json" ]; then
    echo -e "\ninput.json not existed, please create 'input.json' first."
    cd -
    exit 1;
fi
SECONDS=0
snarkjs calculatewitness
if [ ! -f "witness.json" ]; then
    echo -e "\nwitness.json not existed, some error happens at 'snarkjs calculatewitness'."
    cd -
    exit 1;
fi
echo "withness takes $SECONDS secs"

SECONDS=0
echo "setting up...(groth)"
snarkjs setup --protocol groth
if [ ! -f "proving_key.json" ]; then
    echo -e "\nproving_key.json not existed, some error happens at 'snarkjs setup'."
    cd -
    exit 1;
fi
echo "setup takes $SECONDS seconds"

SECONDS=0
echo "generating proof..."
snarkjs proof
if [ ! -f "proof.json" ]; then
    echo -e "\nproof.json not existed, some error happens at 'snarkjs proof'."
    cd -
    exit 1;
fi
echo "generating proof takes $SECONDS seconds"

SECONDS=0
echo -e "verifying...\n"
snarkjs verify
echo "verifying takes $SECONDS seconds"

cd -
