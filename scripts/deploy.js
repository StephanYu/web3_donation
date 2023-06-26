async function main() {
    const charityContract = await hre.ethers.deployContract("Charity");

    await charityContract.waitForDeployment();
    const address = await charityContract.getAddress();
    console.log(`Successfully deployed Charity contract. The contract address is: ${address}`);
}

main().catch((error) => {
    console.log(error);
    process.exitCode = 1;
});