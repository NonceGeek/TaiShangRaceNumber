import RaceNumberContract from 0x83f8ed4318375647


transaction {
    prepare(account: AuthAccount) {
        if account.borrow<&RaceNumberContract.NFTCollection>(from: /storage/NFTCollectionRaceNumber) == nil {
            account.save(<-RaceNumberContract.createNFTCollection(), to: /storage/NFTCollectionRaceNumber)
            account.link<&{RaceNumberContract.NFTReceiver}>(/public/NFTReceiverRaceNumber, target: /storage/NFTCollectionRaceNumber)
        }

        if account.borrow<&RaceNumberContract.NFTMinter>(from: /storage/NFTMinterRaceNumber) == nil{
            account.save(<-RaceNumberContract.createNFTMinter(), to: /storage/NFTMinterRaceNumber)
        }
    }

    execute {
        log("Finished setting up the account")
    }
}