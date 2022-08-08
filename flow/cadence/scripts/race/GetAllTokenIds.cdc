import RaceNumberContract from 0xf8d6e0586b0a20c7

// testnet
// import RaceNumberContract from 0x83f8ed4318375647


pub fun main(): [UInt64] {
    // let account = getAccount(0xf8d6e0586b0a20c7)
    
    // let receiverRef = account.getCapability<&{RaceNumberContract.NFTReceiver}>(/public/NFTReceiver).borrow() ?? panic("could not borrow receiver reference")

    // let ids = receiverRef.getTokenIds()
    // log(ids)

    log(RaceNumberContract.owners.keys)
    return RaceNumberContract.owners.keys
}