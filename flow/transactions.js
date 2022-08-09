// 这里是update
import * as fcl from '@onflow/fcl'

import { config } from "@onflow/fcl";

config()
  // .put("accessNode.api", "https://rest-testnet.onflow.org") // This connects us to Flow TestNet
  // .put("discovery.wallet", "https://fcl-discovery.onflow.org/testnet/authn/") // Allows us to connect to Blocto & Lilico Wallet
  // Point App at Emulator REST API
  .put("accessNode.api", "http://localhost:8888")
  // Point FCL at dev-wallet (default port)
  .put("discovery.wallet", "http://localhost:8701/fcl/authn")


// 创建比赛
export async function createGame() {
  const txId = await fcl.mutate({
    cadence: `
        import Racenumber from 0xf8d6e0586b0a20c7
        import FlowToken from 0xf8d6e0586b0a20c7
        import FungibleToken from 0xf8d6e0586b0a20c7
        
        transaction(name:String, totalSupply:UInt64, startDate: UInt32) {
        
          prepare(acct: AuthAccount) {
            //创建events collection
            let hasEvents = acct.getCapability<&Racenumber.Events>(Racenumber.EventsPublicPath).check()
            if !hasEvents {
              let events <- Racenumber.createEmptyEvents()   
              acct.save<@Racenumber.Events>(<- events, to: Racenumber.EventsStoragePath)
              acct.link<&Racenumber.Events{Racenumber.EventsPublic}>(Racenumber.EventsPublicPath, target:Racenumber.EventsStoragePath)
              log("Events resource created")
            } 
            //创建钱包
            if !acct.getCapability<&FlowToken.Vault{FungibleToken.Balance}>(FlowToken.FlowTokenVaultPublic).check(){
              acct.save(<-FlowToken.createEmptyVault(), to: FlowToken.FlowTokenVaultStorage)
              acct.link<&FlowToken.Vault{FungibleToken.Provider, FungibleToken.Receiver, FungibleToken.Balance}>(FlowToken.FlowTokenVaultPublic, target: FlowToken.FlowTokenVaultStorage)
            }
            //创建event
            let eventsRef = acct.borrow<&Racenumber.Events>(from: Racenumber.EventsStoragePath)?? panic("Events resource not found")
            let eventId = eventsRef.createEvent(name: name, totalSupply: totalSupply, startDate: startDate, hostAddr: acct.address)
            log("Event id:")
            log(eventId)
            log(" created")
        
          }
        
          execute {
            
          }
        }
        
        `,
    args: (arg, t) => [
      arg("racezzf", t.String),
      arg(10, t.UInt64),
      arg(1234, t.UInt32)
    ],
    proposer: fcl.authz,
    payer: fcl.authz,
    authorizations: [fcl.authz],
    limit: 999,
  })

  console.log('Here is the transaction: ' + txId)
  fcl.tx(txId).subscribe((res) => {
    console.log(res)
    if (res.status === 0 || res.status === 1) {
      console.log('Pending...');
    } else if (res.status === 2) {
      console.log('Finalized...')
    } else if (res.status === 3) {
      console.log('Executed...');
    } else if (res.status === 4) {
      console.log('Sealed!');
      setTimeout(() => console.log('Run Transaction'), 2000); // We added this line
    }
  })

  await fcl.tx(txId).onceSealed()
}