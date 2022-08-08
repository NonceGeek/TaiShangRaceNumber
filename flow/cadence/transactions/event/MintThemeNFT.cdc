import Racenumber from 0xf8d6e0586b0a20c7

transaction(hostAddr:Address,eventId:UInt64,type:UInt8) {

  prepare(acct: AuthAccount) {
    let hostAcct = getAccount(hostAddr)
    let eventsRef = hostAcct.getCapability<&Racenumber.Events>(Racenumber.EventsPublicPath).borrow() ?? panic("Events resource not found")
    let eventRef = (&eventsRef.events[eventId] as &Racenumber.Event?)!
    if !acct.getCapability<&Racenumber.ThemeCollection{Racenumber.ThemeCollectionPublic}>(Racenumber.ThemeNFTCollectionPublicPath).check(){
        let collection <- Racenumber.createEmptyThemeCollection()   
        acct.save<@Racenumber.ThemeCollection>(<- collection, to: Racenumber.ThemeNFTCollectionStoragePath)
        acct.link<&Racenumber.ThemeCollection{Racenumber.ThemeCollectionPublic}>(Racenumber.ThemeNFTCollectionPublicPath, target:Racenumber.ThemeNFTCollectionStoragePath)
        log("Theme Collection created!")
    }
    let themeCollectionRef = acct.getCapability<&Racenumber.ThemeCollection{Racenumber.ThemeCollectionPublic}>(Racenumber.ThemeNFTCollectionPublicPath).borrow() ?? panic("Number Collection not found")
    eventRef.mintTheme(type: type, recipient: themeCollectionRef)
    log("Them NFT minted!")
  }

  execute {
    
  }
}
