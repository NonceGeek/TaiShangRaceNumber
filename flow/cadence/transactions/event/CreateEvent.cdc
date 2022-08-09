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
