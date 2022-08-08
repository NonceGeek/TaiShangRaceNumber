import RaceNumberContract from 0x83f8ed4318375647

pub fun main(id: UInt64): Address {
    let ownerAddress = RaceNumberContract.owners[id]!
    log(ownerAddress)
    return ownerAddress
}