const hre = require("hardhat");

async function main() {
  try {
    const initBalance = 1;
    const Assessment = await hre.ethers.getContractFactory("wallet"); // Make sure contract name is correct
    const assessment = await Assessment.deploy(initBalance);
    await assessment.deployed();

    console.log(`A contract with a balance of ${initBalance} eth has been deployed to ${assessment.address}`);
  } catch (error) {
    console.error("Error:", error);
    process.exit(1);
  }
}

// Using async IIFE to call the main function and handle errors
(async () => {
  await main();
})();
