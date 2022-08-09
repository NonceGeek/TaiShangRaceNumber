import Racenumber from 0x01

pub fun main(uid:UInt64):Racenumber.EventDetail? {
    return Racenumber.allEvents[uid]
}
