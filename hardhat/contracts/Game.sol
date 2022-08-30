contract Game{
    address public factory; // 工厂合约地址

    uint totalSupply;

    string number;
    string gameType;
    string templateType;

    mapping(address => NFT) nftMap;

    constructor() payable {
        factory = msg.sender;

    }

    // called once by the factory at time of deployment
    function initialize() external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
    }

    function mint() {
        
    }

    function set(id) {

    }
}