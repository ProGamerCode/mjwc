// contracts/MJWCoin.sol
// SPDX-License-Identifier: CC-BY-NC-ND-3.0
pragma solidity ^0.6.0;

import "../contracts/MJW.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/TokenTimelock.sol";

contract MJWCoin is MJW {
    uint256 private _cap;

    constructor(
        uint256 cap,
        uint256 initialSupply,
        string memory name,
        string memory symbol
    ) public MJW(name, symbol, initialSupply) {
        name = "MJWCoin";
        symbol = "MJW";
        initialSupply = 420710;
        cap = 21522982;
        require(cap > 0, "ERC20Capped: cap is 0");
        _cap = cap;
    }

    function mint(address to, uint256 amount)
        public
        virtual
        override(ERC20PresetMinterPauser)
    {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "ERC20PresetMinterPauser: must have minter role to mint"
        );
        _mint(to, amount);
    }

    function burn(uint256 amount) public virtual override(ERC20Burnable) {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "ERC20Burnable: must have burner role to burn"
        );
        _burn(_msgSender(), amount);
    }

    function pause() public virtual override(ERC20PresetMinterPauser) {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "ERC20PresetMinterPauser: must have pauser role to pause"
        );
        _pause();
    }

    function unpause() public virtual override(ERC20PresetMinterPauser) {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "ERC20PresetMinterPauser: must have pauser role to unpause"
        );
        _unpause();
    }

    function cap() public view returns (uint256) {
        return _cap;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(MJW) {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused() && totalSupply().add(amount) <= cap(), "errrrr");
    }
}
