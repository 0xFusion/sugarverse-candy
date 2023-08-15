const hre = require("hardhat");

async function main() {
  console.log("Starting deploy CNDY Airdrop Token...");
  const AirdropCandyToken = await hre.ethers.getContractFactory(
    "AirdropCandyToken"
  );
  const airdropCandyToken = await AirdropCandyToken.deploy(
    process.env.OWNER_ADDRESS,
    process.env.INITIAL_MINT,
    process.env.MAX_SUPPLY
  );

  await airdropCandyToken.deployed();

  console.log(
    `Airdrop CNDY Token deployed to: https://bscscan.com/address/${airdropCandyToken.address}`
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
