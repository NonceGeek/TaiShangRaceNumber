import Racenumber from 0x01

transaction(name:String, totalSupply:UInt64, startDate: UInt32) {

  prepare(acct: AuthAccount) {
    let hasEvents = acct.getCapability<&Racenumber.Events>(Racenumber.EventsPublicPath).check()
    if !hasEvents {
      let events <- Racenumber.createEmptyEvents()   
      acct.save<@Racenumber.Events>(<- events, to: Racenumber.EventsStoragePath)
      acct.link<&Racenumber.Events>(Racenumber.EventsPublicPath, target:Racenumber.EventsStoragePath)
      log("Events resource created")
    } 
    let eventsRef = acct.getCapability<&Racenumber.Events>(Racenumber.EventsPublicPath).borrow() ?? panic("Events resource not found")
    let eventId = eventsRef.createEvent(name: name, totalSupply: totalSupply, startDate: startDate, hostAddr: acct.address)
    log("Event id:")
    log(eventId)
    log(" created")

  }

  execute {
    
  }
}
