// import RaceNumberContract from 0xf8d6e0586b0a20c7


// testnet
import RaceNumberContract from 0x83f8ed4318375647

pub fun main() : Bool {
    let account = getAccount(0xbc8976c68e9195c4)

    if account.getCapability<&{RaceNumberContract.NFTReceiver}>(/public/NFTReceiverRaceNumber)
            .borrow() == nil {
        return false
    }

    return true
}