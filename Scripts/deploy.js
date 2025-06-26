const hre = require("hardhat");

async function main() {
  const TimeAccessControl = await hre.ethers.getContractFactory("TimeAccessControl");
  const timeAccessControl = await TimeAccessControl.deploy();

  await timeAccessControl.deployed();

  console.log("TimeAccessControl contract deployed to:", timeAccessControl.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
