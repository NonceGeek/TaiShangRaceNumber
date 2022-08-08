import Racenumber from 0xf8d6e0586b0a20c7

transaction(hostAddr:Address,eventId:UInt64,imgUrl:String, types:[UInt8]) {

  prepare(acct: AuthAccount) {
    let hostAcct = getAccount(hostAddr)
    let eventsRef = hostAcct.getCapability<&Racenumber.Events>(Racenumber.EventsPublicPath).borrow() ?? panic("Events resource not found")
    let eventRef = (&eventsRef.events[eventId] as &Racenumber.Event?)!
    eventRef.setImgAndTypes(imgUrl: imgUrl, types: types)
    log("Theme setted!")
  }

  execute {
    
  }
}
