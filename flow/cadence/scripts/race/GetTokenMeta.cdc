import RaceNumberContract from 0xf8d6e0586b0a20c7


// testnet
// import RaceNumberContract from 0x83f8ed4318375647

pub fun main(id: UInt64) : {String: String} {

    let ownerAddress = RaceNumberContract.owners[id]!
    log(ownerAddress)

    let ownerAccount = getAccount(ownerAddress)

    let receiverRef = ownerAccount.getCapability<&{RaceNumberContract.NFTReceiver}>(/public/NFTReceiverRaceNumber)
            .borrow()
            ?? panic("Could not borrow receiver reference")

    return receiverRef.getTokenMetadata(id: id)
}