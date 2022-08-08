import Racenumber from 0xf8d6e0586b0a20c7


pub fun main(addr:Address):[Racenumber.NumberNFTMeta]{
    let acct = getAccount(addr)
    let nfts:[Racenumber.NumberNFTMeta] = []
    if !acct.getCapability<&Racenumber.Collection{Racenumber.CollectionPublic}>(Racenumber.NumberNFTCollectionPublicPath).check(){
        return nfts
    }
    let numberCollectionRef = acct.getCapability<&Racenumber.Collection{Racenumber.CollectionPublic}>(Racenumber.NumberNFTCollectionPublicPath).borrow()!
    let ids = numberCollectionRef.getIDs()
    for id in ids{
        let nft = numberCollectionRef.borrowNumberNFT(id: id)
        let metadata = Racenumber.NumberNFTMeta(id:nft.id,eventId:nft.eventId,name:nft.name, host:nft.host)
        nfts.append(metadata)
    }
    log(nfts.length)
    return nfts
}