import {Game} from "./Game.sol";

contract GameFactory {
    mapping(address=>address[]) public gameHostMap;
    address[] public allGames;

    function createGame(string memory name, uint timestamp, uint  issues) external returns (address) {
        address hostAddr = msg.sender;

        Game game = new Game();
        game.initialize();
        address gameAddr = address(game);
        allGames.push(gameAddr);
        gameHostMap[hostAddr].push(gameAddr);
        return gameAddr;
    }

    function getAllGamesByHost(address hostAddr) external returns (address[] memory hostGames) {
        hostGames = gameHostMap[hostAddr];
    }
}