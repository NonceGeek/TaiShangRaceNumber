# Cadence 

> https://github.dev/emerald-dao/beginner-dapp-course/tree/main/chapter2.0/day1

1. generate testnet keys

```
❯ flow keys generate --network=testnet
🙏 If you want to create an account on testnet with the generated keys use this link:
https://testnet-faucet.onflow.org/?key=5f5373a17e38af85d0489f2a7a8ef6ab880a8b8d35afcef375d1a9479f291e5e848266dbb29ba2b27e4458d5fb158e86b58cf6d4a9524d90d80e9a199203ab65 


🔴️ Store private key safely and don't share with anyone! 
Private Key      2d162ccbb4523c09558203a6e52ad48cb9553d5fdd3f4d4208e54e8c40d8ce46 
Public Key       5f5373a17e38af85d0489f2a7a8ef6ab880a8b8d35afcef375d1a9479f291e5e848266dbb29ba2b27e4458d5fb158e86b58cf6d4a9524d90d80e9a199203ab65 
```

2. copy address

> https://testnet-faucet.onflow.org/

```
0x16fa33cab0a7b7c2
```

3. Deploy it

```
❯ flow project deploy --network=testnet

Deploying 1 contracts for accounts: testnet-account

HelloWorld -> 0x16fa33cab0a7b7c2 (1ce1d8a5ed4d422b1d0d90e8fedf524d4cbb7498368e676696a7f34bb90bce33) 


✨ All contracts deployed successfully
```

4. Read and Write

```
❯ flow scripts execute ./flow/cadence/scripts/readGreeting.cdc --network=testnet

Result: "Goodbye, Loser"

❯ flow transactions send ./flow/cadence/transactions/changeGreeting.cdc "Goodbye, Loser" --network=testnet --signer=testnet-account
Transaction ID: 903e12cb7e955de255bfc3011a4ed55812b54ab1e012741fc26f67dd260e48e6

Status          ✅ SEALED
ID              903e12cb7e955de255bfc3011a4ed55812b54ab1e012741fc26f67dd260e48e6
Payer           16fa33cab0a7b7c2
Authorizers     [16fa33cab0a7b7c2]

Proposal Key:
    Address     16fa33cab0a7b7c2
    Index       0
    Sequence    1

No Payload Signatures

Envelope Signature 0: 16fa33cab0a7b7c2
Signatures (minimized, use --include signatures)

Events:          
    Index       0
    Type        A.7e60df042a9c0868.FlowToken.TokensWithdrawn
    Tx ID       903e12cb7e955de255bfc3011a4ed55812b54ab1e012741fc26f67dd260e48e6
    Values
                - amount (UFix64): 0.00000204 
                - from (Address?): 0x16fa33cab0a7b7c2 

    Index       1
    Type        A.7e60df042a9c0868.FlowToken.TokensDeposited
    Tx ID       903e12cb7e955de255bfc3011a4ed55812b54ab1e012741fc26f67dd260e48e6
    Values
                - amount (UFix64): 0.00000204 
                - to (Address?): 0x912d5440f7e3769e 

    Index       2
    Type        A.912d5440f7e3769e.FlowFees.FeesDeducted
    Tx ID       903e12cb7e955de255bfc3011a4ed55812b54ab1e012741fc26f67dd260e48e6
    Values
                - amount (UFix64): 0.00000204 
                - inclusionEffort (UFix64): 1.00000000 
                - executionEffort (UFix64): 0.00000021 



Code (hidden, use --include code)

Payload (hidden, use --include payload)
```