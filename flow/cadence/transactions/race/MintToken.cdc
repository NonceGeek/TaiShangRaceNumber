import RaceNumberContract from 0xf8d6e0586b0a20c7

// testnet
// import RaceNumberContract from 0x83f8ed4318375647

transaction {
    let receiverRef: &{RaceNumberContract.NFTReceiver}

    let minterRef: &RaceNumberContract.NFTMinter

    let metadata: {String: String}

    let addr: Address

    prepare(account: AuthAccount) {
        if account.borrow<&RaceNumberContract.NFTCollection>(from: /storage/NFTCollectionRaceNumber) == nil {
            account.save(<-RaceNumberContract.createNFTCollection(), to: /storage/NFTCollectionRaceNumber)
            account.link<&{RaceNumberContract.NFTReceiver}>(/public/NFTReceiverRaceNumber, target: /storage/NFTCollectionRaceNumber)
        }

        if account.borrow<&RaceNumberContract.NFTMinter>(from: /storage/NFTMinterRaceNumber) == nil{
            account.save(<-RaceNumberContract.createNFTMinter(), to: /storage/NFTMinterRaceNumber)
        }
 
        self.receiverRef = account.getCapability<&{RaceNumberContract.NFTReceiver}>(/public/NFTReceiverRaceNumber)
            .borrow()
            ?? panic("Could not borrow receiver reference")

        self.minterRef = account.borrow<&RaceNumberContract.NFTMinter>(from: /storage/NFTMinterRaceNumber)
            ?? panic("Could not borrow minter reference")

        self.metadata = {
            "number": "003",
            "gameType": "1",
            "templateType": "1",
            "imgUrl": "abcdefg"
        }
        
        self.addr = account.address
    }

    execute {
        let newToken <- self.minterRef.mint(self.metadata, self.addr)
        self.receiverRef.deposit(token: <-newToken)
    }
}