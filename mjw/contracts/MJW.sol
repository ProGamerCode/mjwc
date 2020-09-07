// contracts/MJW.sol
// SPDX-License-Identifier: CC-BY-NC-ND-3.0
pragma solidity ^0.6.0;

import "../node_modules/@openzeppelin/contracts/access/AccessControl.sol";
import "../node_modules/@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";
import "../node_modules/@openzeppelin/contracts/GSN/Context.sol";

abstract contract MJW is Context, AccessControl, ERC20PresetMinterPauser {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) public ERC20PresetMinterPauser(name, symbol) {
        name = "MJWCoin";
        symbol = "MJW";
        initialSupply = 420710;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _mint(msg.sender, initialSupply);
        address burner = msg.sender;
        address stoner = msg.sender;
        address dealer = msg.sender;
        address distributer = msg.sender;
        address grower = msg.sender;
        address weedfarmer = msg.sender;
        address driver4247 = msg.sender;
        address delivery = msg.sender;
    }

    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant STONER_ROLE = keccak256("STONER_ROLE");
    bytes32 public constant DEALER_ROLE = keccak256("DEALER_ROLE");
    bytes32 public constant DISTRIBUTER_ROLE = keccak256("DISTRIBUTER_ROLE");
    bytes32 public constant GROWER_ROLE = keccak256("GROWER_ROLE");
    bytes32 public constant WEEDFARMER_ROLE = keccak256("WEEDFARMER_ROLE");
    bytes32 public constant DRIVER4247_ROLE = keccak256("DRIVER4247_ROLE");
    bytes32 public constant DLIVERY_ROLE = keccak256("DLIVERY_ROLE");

    function rollSetup(
        address burner,
        address stoner,
        address dealer,
        address distributer,
        address grower,
        address weedfarmer,
        address driver4247,
        address delivery
    ) public {
        _setupRole(BURNER_ROLE, burner);
        _setupRole(STONER_ROLE, stoner);
        _setupRole(DEALER_ROLE, dealer);
        _setupRole(DISTRIBUTER_ROLE, distributer);
        _setupRole(GROWER_ROLE, grower);
        _setupRole(WEEDFARMER_ROLE, weedfarmer);
        _setupRole(DRIVER4247_ROLE, driver4247);
        _setupRole(DLIVERY_ROLE, delivery);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20PresetMinterPauser) {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "errrrr");
    }
}
