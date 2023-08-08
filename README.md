# AtomicSwap

Project details:
This truffle project contains the smart contracts which cab be refered to understand how to implement the cross chain swap.

Swap Ether to ERC20
For atomic swap between Ether and ERC20 tokens, the SwapEtherToERC20 contract should be used. For this example, PersonA holds Ether and PersonB holds ERC20 tokens. PersonA is looking to give Ether to PersonB in exchange for his ERC20 tokens.

PersonA calls open using a unique _swapID that has been negotiated between both traders. This is a payable call and PersonA must send her Ether when she makes this call.
PersonB calls check to verify the details of the trade. If he does not agree then he does not need to do anything. At any point, PersonA can call expire and get a refund of her Ether. Doing this cancels the swap.
PersonB provides an allowance to the SwapEtherToERC20 contract, using his ERC20 contract to do so.
PersonB calls close, which will check the allowance and use it to transfer his ERC20 tokens to PersonA. At the same time, it will transfer PersonA's Ether to PersonB. PersonA can no longer expire the swap.
Swap ERC20 to ERC20
For atomic swap between ERC20 and another ERC20 token, the SwapERC20ToERC20 contract should be used. For this example, PersonA holds ERC20 tokens and PersonB also holds ERC20 tokens. PersonA is looking to give her ERC20 tokens to PersonB in exchange for his ERC20 tokens, and PersonA has agreed to initiate the atomic swap.

PersonA provides an allowance to the SwapERC20ToERC20 contract, using her ERC20 contract to do so.
PersonA calls open using a unique _swapID that has been negotiated between both traders. The allowance will be checked and used to transfer PersonA's ERC20 tokens to the SwapERC20ToERC20 contract.
PersonB calls check to verify the details of the trade. If he does not agree then he does not need to do anything. At any point, PersonA can call expire and get a refund of her ERC20 tokens. Doing this cancels the swap.
PersonB provides an allowance to the SwapERC20ToERC20 contract, using his ERC20 contract to do so.
PersonB calls close, which will check the allowance and use it to transfer his ERC20 tokens to PersonA. At the same time, it will transfer PersonA's ERC20 tokens to PersonB. PersonA can no longer expire the swap.
Ether to Bitcoin
An atomic swap between Ether and Bitcoin, the SwapEtherToBitcoin contract should be used. For this example, PersonA holds Ether and PersonB also holds Bitcoin. PersonA is looking to give her Ether to PersonB in exchange for his Bitcoins.

PersonB generates a random secret key and hashes it using SHA256 to generate a secret lock.
PersonB uses the secret lock, and a Bitcoin Script, to setup a transaction to PersonA on the condition that she produces the secret key. If she does not do so within 48 hours then PersonB can withdraw the funds.
PersonB sends the secret lock to PersonA along with the address of his transaction on the Bitcoin blockchain.
PersonA checks PersonB's transaction, verifying the details of the trade. If she does not agree then she does not need to do anything. After 48 hours, PersonB can withdraw his funds.
PersonA calls open using a unique _swapID that has been negotiated between both traders. She also uses the secret lock that was provided by PersonB. This is a payable call and PersonA must send her Ether when she makes this call.
PersonB calls check to verify the details of the trade. If he does not agree, then he does not need to do anything. After 24 hours, PersonA can call expire, getting a refund of her Ether.
PersonB calls close, which requires that he submits the secret key associated with the secret lock. If he has provided the correct secret key, it will transfer PersonA's Ether to PersonB and store the secret key.
PersonA calls checkSecretKey, acquiring the secret key.
PersonA provides the secret key to PersonB's Bitcoin Script, and receives his Bitcoin.
ERC20 to Bitcoin
To perform an atomic swap between ERC20 and Bitcoin, the SwapERC20ToBitcoin contract should be used. For this example, PersonA holds ERC20 tokens and PersonB also holds Bitcoin. PersonA is looking to give her ERC20 tokens to PersonB in exchange for his Bitcoins.

PersonB generates a random secret key and hashes it using SHA256 to generate a secret lock.
PersonB uses the secret lock, and a Bitcoin Script, to setup a transaction to PersonA on the condition that she produces the secret key. If she does not do so within 48 hours then PersonB can withdraw the funds.
PersonB sends the secret lock to PersonA along with the address of his transaction on the Bitcoin blockchain.
PersonA checks PersonB's transaction, verifying the details of the trade. If she does not agree then she does not need to do anything. After 48 hours, PersonB can withdraw his funds.
PersonA provides an allowance to the SwapERC20ToBitcoin contract, using her ERC20 contract to do so.
PersonA calls open using a unique _swapID that has been negotiated between both traders. She also uses the secret lock that was provided by PersonB. The allowance will be checked and used to transfer PersonA's ERC20 tokens to the SwapERC20ToBitcoin contract.
PersonB calls check to verify the details of the trade. If he does not agree, then he does not need to do anything. After 24 hours, PersonA can call expire, getting a refund of her ERC20 tokens.
PersonB calls close, which requires that he submits the secret key associated with the secret lock. If he has provided the correct secret key, it will transfer PersonA's ERC20 tokens to PersonB and store the secret key.
PersonA calls checkSecretKey, acquiring the secret key.
PersonA provides the secret key to PersonB's Bitcoin Script, and receives his Bitcoin.
Contract deployment
Prior to deployment, create an .env file at the root level and provide 'MNEMONIC' and 'INFURA_PROJECT_ID'[See '.env.reference' for reference]. To deploy contracts : In goerli : truffle migrate --network goerli in localhost[Ganache] : truffle migrate --network development

Upgrade contract :
To do contract upgrade, all the contracts are deployed using 'deployProxy' and it uses '@openzeppelin/truffle-upgrades' package. Please see sample file '7_upgradeSwapERC20ToBitcoin.js' under 'scripts' folder.

AtomicSwap/AtomicSwaps at main · wasim162010/AtomicSwap 
