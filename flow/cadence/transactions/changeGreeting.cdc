import HelloWorld from "../contracts/HelloWorld.cdc" // THIS IS NO LONGER CORRECT

transaction(myNewGreeting: String) {

  prepare(signer: AuthAccount) {}

  execute {
    HelloWorld.changeGreeting(newGreeting: myNewGreeting)
  }
}