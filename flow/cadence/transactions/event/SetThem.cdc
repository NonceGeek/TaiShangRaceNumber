import Racenumber from 0xf8d6e0586b0a20c7

transaction(eventId:UInt64,imgUrl:String, types:[UInt8]) {

  prepare(acct: AuthAccount) {
    let eventsRef = acct.borrow<&Racenumber.Events>(from: Racenumber.EventsStoragePath) ?? panic("Events resource not found")
    let eventRef = eventsRef.borrowEventRef(eventId:eventId)
    eventRef.setImgAndTypes(imgUrl: imgUrl, types: types)
    log("Theme setted!")
  }

  execute {
    
  }
}
