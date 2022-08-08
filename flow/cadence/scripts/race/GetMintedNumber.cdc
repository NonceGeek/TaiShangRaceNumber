import RaceNumberContract from 0xf8d6e0586b0a20c7

// testnet
// import RaceNumberContract from 0x83f8ed4318375647


pub fun main(): [String] {
    log("hello world")
    log(RaceNumberContract.mintedNumber)
    return RaceNumberContract.mintedNumber
}