import Racenumber from 0xf8d6e0586b0a20c7

pub fun main(addr:Address):{UInt64:String} {
  let acct = getAccount(addr)
  let eventsRef = acct.getCapability<&Racenumber.Events>(Racenumber.EventsPublicPath).borrow() ?? panic("Events resource not found")
  let allEvents = eventsRef.getAllEvents()
  return allEvents
}
