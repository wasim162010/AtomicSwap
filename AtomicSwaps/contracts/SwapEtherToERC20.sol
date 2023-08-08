
pragma solidity ^0.8.18;

import "./ERC20.sol";

contract SwapEtherToERC20 {

  struct Swap {
    uint256 value;
    address ethTrader;
    uint256 erc20Value;
    address erc20Trader;
    address erc20ContractAddress;
  }

  enum States {
    INVALID,
    OPEN,
    CLOSED,
    EXPIRED
  }

  mapping (bytes32 => Swap) private swaps;
  mapping (bytes32 => States) private swapStates;

  event Open(bytes32 _swapID, address _closeTrader);
  event Expire(bytes32 _swapID);
  event Close(bytes32 _swapID);

  modifier onlyInvalidSwaps(bytes32 _swapID) {
    require (swapStates[_swapID] == States.INVALID);
    _;
  }

  modifier onlyOpenSwaps(bytes32 _swapID) {
    require (swapStates[_swapID] == States.OPEN);
    _;
  }

  function open(bytes32 _swapID, uint256 _erc20Value, address _erc20Trader, address _erc20ContractAddress) public onlyInvalidSwaps(_swapID) payable {
    // Store the details of the swap.
    Swap memory swap = Swap({
      value: msg.value,
      ethTrader: msg.sender,
      erc20Value: _erc20Value,
      erc20Trader: _erc20Trader,
      erc20ContractAddress: _erc20ContractAddress
    });
    swaps[_swapID] = swap;
    swapStates[_swapID] = States.OPEN;

    emit Open(_swapID, _erc20Trader);
  }

  function close(bytes32 _swapID) public onlyOpenSwaps(_swapID) {
    // Close the swap.
    Swap memory swap = swaps[_swapID];
    swapStates[_swapID] = States.CLOSED;

    // Transfer the ERC20 funds from the ERC20 trader to the ETH trader.
    ERC20 erc20Contract = ERC20(swap.erc20ContractAddress);
    require(swap.erc20Value <= erc20Contract.allowance(swap.erc20Trader, address(this)));
    require(erc20Contract.transferFrom(swap.erc20Trader, swap.ethTrader, swap.erc20Value));

    // Transfer the ETH funds from this contract to the ERC20 trader.
    address payable erc20TraderPayable = payable(swap.erc20Trader);
    erc20TraderPayable.transfer(swap.value);

    
    emit Close(_swapID);
  }

  function expire(bytes32 _swapID) public onlyOpenSwaps(_swapID) {
    // Expire the swap.
    Swap memory swap = swaps[_swapID];
    swapStates[_swapID] = States.EXPIRED;

    // Transfer the ETH value from this contract back to the ETH trader.

    address payable ethTraderPayable = payable(swap.ethTrader);
    ethTraderPayable.transfer(swap.value);
    emit Expire(_swapID);
  }

  function check(bytes32 _swapID) public view returns (uint256 value, uint256 erc20Value, address erc20Trader, address erc20ContractAddress) {
    Swap memory swap = swaps[_swapID];
    return  (swap.value, swap.erc20Value, swap.erc20Trader, swap.erc20ContractAddress);
  }
}
