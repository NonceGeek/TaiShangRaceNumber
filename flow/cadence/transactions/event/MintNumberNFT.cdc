import Racenumber from 0xf8d6e0586b0a20c7
import FlowToken from 0xf8d6e0586b0a20c7
import FungibleToken from 0xf8d6e0586b0a20c7

transaction(hostAddr:Address,eventId:UInt64,num:UInt64) {

  prepare(acct: AuthAccount) {
    let hostAcct = getAccount(hostAddr)
    let eventsRef = hostAcct.getCapability<&Racenumber.Events{Racenumber.EventsPublic}>(Racenumber.EventsPublicPath).borrow() ?? panic("Events resource not found")
    let eventRef = eventsRef.borrowPublicEventRef(eventId: eventId)
    if !acct.getCapability<&Racenumber.Collection{Racenumber.CollectionPublic}>(Racenumber.NumberNFTCollectionPublicPath).check(){
        let collection <- Racenumber.createEmptyCollection()   
        acct.save<@Racenumber.Collection>(<- collection, to: Racenumber.NumberNFTCollectionStoragePath)
        acct.link<&Racenumber.Collection{Racenumber.CollectionPublic,NonFungibleToken.CollectionPublic}>(Racenumber.NumberNFTCollectionPublicPath, target:Racenumber.NumberNFTCollectionStoragePath)
        log("Number Collection created!")
    }
    let numberCollectionRef = acct.getCapability<&Racenumber.Collection{NonFungibleToken.CollectionPublic}>(Racenumber.NumberNFTCollectionPublicPath).borrow() ?? panic("Number Collection not found")

    let vault = acct.borrow<&FlowToken.Vault>(from: FlowToken.FlowTokenVaultStorage) ?? panic("Flowtoken Vault not found!")
    let flowToken <- vault.withdraw(amount: eventRef.price) as! @FlowToken.Vault
    eventRef.mintNumber(num:num,recipient:numberCollectionRef,flowVault:<-flowToken)
    log("Expected Number NFT minted!")
  }

  execute {
    
  }
}
