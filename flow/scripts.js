// 这里都是get方法
import * as fcl from '@onflow/fcl'

export async function getAllGames() {
    const resp = await fcl.query({
        cadence: `
        import HelloWorld from 0xf8d6e0586b0a20c7
        
        `,
        args: (arg, t) => []
    })

    console.log("Response from our script: " + resp)
    return {}
}
