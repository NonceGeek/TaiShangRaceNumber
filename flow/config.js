import { config } from "@onflow/fcl";

config()
    // .put("accessNode.api", "https://rest-testnet.onflow.org") // This connects us to Flow TestNet
    // .put("discovery.wallet", "https://fcl-discovery.onflow.org/testnet/authn/") // Allows us to connect to Blocto & Lilico Wallet
    // Point App at Emulator REST API
    .put("accessNode.api", "http://localhost:8888")
    // Point FCL at dev-wallet (default port)
    .put("discovery.wallet", "http://localhost:8701/fcl/authn")
