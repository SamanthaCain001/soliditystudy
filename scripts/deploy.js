const hre = require("hardhat");

async function main() {
  console.log("Starting deployment...");

  // Deploy HelloWorld
  const HelloWorld = await hre.ethers.getContractFactory("HelloWorld");
  const helloWorld = await HelloWorld.deploy();
  await helloWorld.waitForDeployment();
  console.log("HelloWorld deployed to:", await helloWorld.getAddress());

  // Deploy DataTypes
  const DataTypes = await hre.ethers.getContractFactory("DataTypes");
  const dataTypes = await DataTypes.deploy();
  await dataTypes.waitForDeployment();
  console.log("DataTypes deployed to:", await dataTypes.getAddress());

  // Deploy SimpleToken with initial supply
  const SimpleToken = await hre.ethers.getContractFactory("SimpleToken");
  const simpleToken = await SimpleToken.deploy(1000000); // 1M tokens
  await simpleToken.waitForDeployment();
  console.log("SimpleToken deployed to:", await simpleToken.getAddress());

  // Deploy Voting
  const Voting = await hre.ethers.getContractFactory("Voting");
  const voting = await Voting.deploy();
  await voting.waitForDeployment();
  console.log("Voting deployed to:", await voting.getAddress());

  console.log("Deployment complete!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });