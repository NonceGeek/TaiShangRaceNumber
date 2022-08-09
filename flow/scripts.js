// 这里都是get方法
import * as fcl from '@onflow/fcl'

export async function getAllGames() {
    const resp = await fcl.query({
        cadence: `
        import Racenumber from 0x01
        pub fun main():{UInt64:Racenumber.GameDetail} {
            return Racenumber.getAllGames()
        }
        `,
        args: (arg, t) => []
    })

    console.log("Response from our script: " + resp)
    return resp
}
