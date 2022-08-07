import NonFungibleToken from 0x02
pub contract Racenumber:NonFungibleToken {
    pub var totalSupply:UInt64

    pub let EventsStoragePath:StoragePath
    pub let EventsPublicPath:PublicPath
    pub let NumberNFTCollectionStoragePath: StoragePath
    pub let NumberNFTCollectionPublicPath:PublicPath
    pub let ThemeNFTCollectionStoragePath: StoragePath
    pub let ThemeNFTCollectionPublicPath:PublicPath

    //Event相关Metadata
    pub struct EventDetail{
        pub var hostAddr:Address
        pub var name:String
        pub var totalSupply:UInt64
        pub var startDate: UInt32
        pub var id:UInt64
        pub(set) var imgUrl: String;
        pub(set) var types:[UInt8];

        init(hostAddr:Address,name:String, totalSupply:UInt64, startDate: UInt32, id:UInt64) {
            self.hostAddr = hostAddr
            self.name = name
            self.totalSupply = totalSupply
            self.startDate = startDate
            self.id = id
            self.imgUrl = ""
            self.types = []
        }
    }

    //Number NFT相关Metadata
    pub struct NumberNFTMeta{
        pub let id:UInt64
        pub let eventId:UInt64
        pub let name:String
        pub let host:Address

        init(id:UInt64,eventId:UInt64,name:String, host:Address){
            self.id = id
            self.eventId = eventId
            self.name = name
            self.host = host
        }
    }
    //theme相关metadata
    pub struct ThemeMeta{
        pub let id:UInt64
        pub let eventId:UInt64
        pub let name:String
        pub let host:Address
        pub let type:UInt8

        init(id:UInt64,eventId:UInt64,name:String,host:Address,type:UInt8){
            self.id = id
            self.eventId = eventId
            self.name = name
            self.host = host
            self.type = type
        }
    }

    pub var allEvents:{UInt64:EventDetail}  //每个主办方办的所有比赛,通过Events的Capability找到每个event

    //不用触发事件，接口必须
    pub event ContractInitialized()
    pub event Withdraw(id: UInt64, from: Address?)
    pub event Deposit(id: UInt64, to: Address?)

//B端创建比赛的模板
    //缺少权限管理, capabilities
    pub resource Events {
        pub var totalEvents:UInt64
        pub var events: @{UInt64:Event}
        pub fun createEvent(name:String, totalSupply:UInt64, startDate: UInt32, hostAddr: Address): UInt64 {
            let eventId = self.totalEvents;
            let event <- create Event(name:name,totalSupply:totalSupply, startDate: startDate, hostAddr: hostAddr,eventId:eventId);
            self.events[eventId] <-! event
            let id = (&self.events[eventId] as &Event?)!.id
            assert(!Racenumber.allEvents.containsKey(id), message: "event id is not unique")
            let _eventDetail = EventDetail(hostAddr:hostAddr,name:name, totalSupply:totalSupply, startDate: startDate,id:id)
            Racenumber.allEvents.insert(key: id, _eventDetail)
            self.totalEvents = self.totalEvents + 1;
            return eventId;
        }
        
        //to do修改为正确的返回格式
        pub fun getAllEvents():{UInt64:String} {
            let res: {UInt64: String} = {}
            for id in self.events.keys {
                let ref = (&self.events[id] as &Event?)!
                res[id] = ref.name;
            }
            return res
        }

        init() {
            self.totalEvents = 0
            self.events <- {}
        }

        destroy()  {
            destroy self.events
        }
    }

    pub resource Event {
        pub var totalSupply:UInt64;
        pub(set) var minted:{UInt64:Address};
        pub(set) var mintedAddrs:[Address];
        pub var name: String;
        pub var startDate: UInt32;
        pub var hostAddr: Address
        pub let eventId: UInt64;
        pub var imgUrl: String;
        pub var types:[UInt8];
        pub var id:UInt64;
        
        //用户mint
        pub fun mintNumber(num:UInt64, recipient: &Collection{NonFungibleToken.CollectionPublic}) {
            pre {
                num < self.totalSupply: "This number exceed the totalSupply!"
                !self.minted.containsKey(num) : "This number has been minted!"
                
            }
            let addr:Address = recipient.owner!.address;
            assert(!self.mintedAddrs.contains(addr),message:"Your address has minted!")
            let token <- create NFT(
                host: self.hostAddr,
                eventId: self.eventId,
                name: self.name,
                num:num
                )
            self.minted.insert(key:num,addr);
            self.mintedAddrs.append(addr)
            recipient.deposit(token: <-token)
        }
        pub fun mintTheme(num:UInt64, type:UInt8,recipient: &ThemeCollection) :UInt64 {
            //todo 校验是否有权限mint
            let addr:Address = recipient.owner!.address;
            //获取到他的号牌NFT
            //getAccount(addr).getCapability(Racenumber.NumberNFTCollectionPublicPath).borrow(<&

            //self.mintedNum = self.mintedNum +1;
            //recipient.deposit(token: <-token)
            return 0
        }

        init(name:String,totalSupply:UInt64, startDate: UInt32, hostAddr: Address, eventId:UInt64) {
            self.name = name;
            self.totalSupply = totalSupply;
            self.startDate = startDate;
            self.hostAddr = hostAddr;
            self.eventId = eventId;
            self.minted = {};
            self.imgUrl = "";
            self.types = [];
            self.id = self.uuid
            self.mintedAddrs = []
        }
        
        pub fun setImgAndTypes(imgUrl:String, types: [UInt8]) {
            let id = self.uuid
            let ref = &Racenumber.allEvents[id]! as &EventDetail
            ref.imgUrl = imgUrl
            ref.types = types
            self.imgUrl = imgUrl;
            self.types = types;
        }
        
        destroy (){

        }

    }

//////////用户存储部分//////////////////
    pub resource interface CollectionPublic{
        pub fun deposit(token:@NonFungibleToken.NFT)
        pub fun getIDs():[UInt64]
        pub fun borrowNFT(id:UInt64): &NonFungibleToken.NFT
        pub fun borrowNumberNFT(id:UInt64):&NFT
    }
    pub resource NFT:NonFungibleToken.INFT {
        pub let id:UInt64
        pub let eventId:UInt64
        pub let name:String
        pub let host:Address
        pub let eventsCap: Capability<&Events>
        init(host:Address, eventId:UInt64, name:String,num:UInt64){
            //校验
            self.id = num
            self.eventId = eventId
            self.name = name
            self.host = host
            self.eventsCap = getAccount(host).getCapability<&Events>(Racenumber.EventsPublicPath)
        }     

        destroy (){
        }

    }

    pub resource ThemeNFT:NonFungibleToken.INFT {
        pub let id:UInt64
        pub let eventId:UInt64
        pub let name:String
        pub let host:Address
        pub let numberNFTCap: Capability<&NFT>
        pub let type:UInt8
        init(eventId:UInt64,name:String,host:Address, type:UInt8,owner:Address) {
            self.id = self.uuid
            self.eventId = eventId
            self.name = name
            self.host = host
            self.type = type
            self.numberNFTCap = getAccount(host).getCapability<&NFT>(Racenumber.NumberNFTCollectionPublicPath)
        }
    }

    pub resource Collection: NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic, CollectionPublic {
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}

        pub fun withdraw(withdrawID:UInt64):@NonFungibleToken.NFT {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("You donnot own this NFT")
            let nft <- token as! @NFT
            return <- nft
        }

        pub fun deposit(token:@NonFungibleToken.NFT) {
            let nft <- token as! @NFT;
            let id = nft.id;
            self.ownedNFTs[id]<-! nft;
        }

        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys;
        }

        pub fun borrowNFT(id:UInt64): &NonFungibleToken.NFT {
            return (&self.ownedNFTs[id] as &NonFungibleToken.NFT?)!
        }

        pub fun borrowNumberNFT(id:UInt64): &NFT{
            pre{
                self.ownedNFTs[id]!=nil: "Number NFT doesn't exist!"
            }
            let ref = (&self.ownedNFTs[id] as auth&NonFungibleToken.NFT?)!
            return ref as! &NFT
        }

        init(){
            self.ownedNFTs <- {}
        }
        destroy (){
            destroy self.ownedNFTs
        }
    }

    pub resource interface ThemeCollectionPublic {
        pub fun deposit(token:@NonFungibleToken.NFT)
        pub fun getIDs(): [UInt64]
        pub fun borrowNFT(id:UInt64): &ThemeNFT
    }

    pub resource ThemeCollection:ThemeCollectionPublic {
        pub var ownedNFTs: @{UInt64: ThemeNFT}

        pub fun withdraw(withdrawID:UInt64):@ThemeNFT {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("You donnot own this NFT")
            return <- token
        }

        pub fun deposit(token:@NonFungibleToken.NFT) {
            let nft <- token as! @ThemeNFT;
            let id = nft.id;
            self.ownedNFTs[id]<-! nft;
        }

        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys;
        }

        pub fun borrowNFT(id:UInt64): &ThemeNFT {
            pre {
                self.ownedNFTs[id]!=nil: "Theme NFT doesn't exist!"
            }
            return (&self.ownedNFTs[id] as &ThemeNFT?)!
        }

        init(){
            self.ownedNFTs <- {}
        }
        destroy (){
            destroy self.ownedNFTs
        }
    }

    pub fun createEmptyCollection(): @Collection {
        return <- create Collection()
    }

    pub fun createEmptyThemeCollection(): @ThemeCollection {
        return <- create ThemeCollection()
    }

    pub fun createEmptyEvents():@Events{
        return <- create Events();
    }

    init() {
        self.EventsStoragePath = /storage/EventsStoragePath
        self.EventsPublicPath = /public/EventsStoragePath
        self.NumberNFTCollectionStoragePath = /storage/NumberNFTCollectionStoragePath
        self.NumberNFTCollectionPublicPath = /public/NumberNFTCollectionPublicPath
        self.ThemeNFTCollectionStoragePath = /storage/ThemeNFTCollectionStoragePath
        self.ThemeNFTCollectionPublicPath = /public/ThemeNFTCollectionPublicPath
        self.totalSupply = 0
        self.allEvents = {}
    }

}

