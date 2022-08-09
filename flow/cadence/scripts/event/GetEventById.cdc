import Racenumber from 0xf8d6e0586b0a20c7
pub fun main(uid:UInt64):Racenumber.EventDetail {
    return Racenumber.getEventById(id:uid)
}