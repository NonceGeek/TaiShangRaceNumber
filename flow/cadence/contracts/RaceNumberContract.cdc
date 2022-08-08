pub contract RaceNumberContract {
    // 每个号码牌的owner
    pub var owners: {UInt64: Address}
    // 总发行量
    pub let totalSupply: UInt64
    // 赛事的负责人的地址
    pub let raceOwnerAddress: Address
    // 每个号牌统一的价格
    pub let price: UFix64
    // 已经被mint过的号码
    pub var mintedNumber: [String]

    pub resource RaceNumberNFT {
        pub let id: UInt64

        // number: String
        // gameType: String
        // templateType: String
        // imgUrl: String
        pub var metadata: {String: String}

        init(id: UInt64, metadata: {String: String}) {
            self.id = id
            self.metadata = metadata
        }

        pub fun setMetadata(key: String, value: String) {
            self.metadata[key] = value
        }
    }

    pub resource interface NFTReceiver {
        // 提取NFT
        pub fun withdraw(id: UInt64): @RaceNumberNFT

        // 存入NFT
        pub fun deposit(token: @RaceNumberNFT)

        // 获取所有NFT的ID
        pub fun getTokenIds(): [UInt64]

        // 获取NFT的信息
        pub fun getTokenMetadata(id: UInt64): {String: String}

        // 更新NFT的信息
        pub fun updateTokenMetadata(id: UInt64, metadata: {String: String})
    }

    pub resource NFTCollection: NFTReceiver {
        access(account) var ownedNFTs: @{UInt64: RaceNumberNFT}

        init() {
            self.ownedNFTs <- {}
        }

        destroy (){
            destroy self.ownedNFTs
        }

        pub fun withdraw(id: UInt64): @RaceNumberNFT {
            let token <- self.ownedNFTs.remove(key: id)
            return <-token!
        }
        
        pub fun deposit(token: @RaceNumberNFT) {
            self.ownedNFTs[token.id] <-! token
        }

        pub fun getTokenIds(): [UInt64] {
            return  self.ownedNFTs.keys
        }

        pub fun getTokenMetadata(id: UInt64): {String: String} {
            return self.ownedNFTs[id]?.metadata!
        }

        pub fun updateTokenMetadata(id: UInt64, metadata: {String: String}) {
            for key in metadata.keys {
                self.ownedNFTs[id]?.setMetadata(key: key, value: metadata[key]!)
            }
        }
    }

    pub fun createNFTCollection(): @NFTCollection {
        return <- create NFTCollection()
    }

    pub resource NFTMinter {
        pub var idCount: UInt64

        init() {
            self.idCount = 1
        }

        pub fun mint(_ metadata: {String: String}, _ addr: Address): @RaceNumberNFT {
            pre {
                // 判断mint出来的数量是否超过了总数量
                self.idCount <= RaceNumberContract.totalSupply : "idCount must be less than totalSupply"
                // 号码不能重复
                !RaceNumberContract.checkNumberExist(number: metadata["number"]!) : "number must be unique"
            }

            let token <- create RaceNumberNFT(id: self.idCount, metadata: metadata)
            RaceNumberContract.owners[self.idCount] = addr
            self.idCount = self.idCount + 1
            RaceNumberContract.mintedNumber.append(token.metadata["number"]!)
            return <-token
        }

        
    } 

    pub fun createNFTMinter(): @NFTMinter {
        return <- create NFTMinter()
    }

    // 查重
    pub fun checkNumberExist(number: String): Bool {
        return RaceNumberContract.mintedNumber.contains(number)
    }

    // raceOwnerAddress: Address, totalSupply: UInt64, price: UFix64
    init() {
        self.raceOwnerAddress = 0x83f8ed4318375647
        self.totalSupply = 3
        self.price = 0.1
        self.owners = {}
        self.mintedNumber = []

        self.account.save(<-create NFTCollection(), to: /storage/NFTCollectionRaceNumber)
        self.account.link<&{NFTReceiver}>(/public/NFTReceiverRaceNumber, target: /storage/NFTCollectionRaceNumber)
        self.account.save(<-create NFTMinter(), to: /storage/NFTMinterRaceNumber)
    }
}