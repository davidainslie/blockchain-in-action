# Smart Contracts and Dapps with Solidity

Following the book `Blockchain in Action`.

## Essentials of Dapp Development

- For every Dapp project, a `<project>-app` module for the web application and a `<project>-contract` module for smart contracts
- A web server and a package manager (`Node.js` and the `Node Package Manager` [npm])
- A blockchain provider (such as `Ganache`) called `web3 provider`
- A development tool, the `Truffle` suite (IDE) that provides an integrated environment to deploy and test a Dapp
- Account management using the `MetaMask` browser plugin

## Truffle

`Truffle` is an integrated development environment and testing framework that provides a suite of features and commands for end-to-end Ethereum-based Dapp development, including commands for:

- Initializing a template or base directory structure for a Dapp (`truffle init`)
- Compiling and deploying smart contracts (`truffle compile`)
- Launching a personal blockchain for testing with a console (`truffle develop`)
- Running migration scripts for deploying smart contracts (`truffle migrate`)
- Opening a command-line interface to Truffle for testing without the Dapp UI (`truffle console`)
- Testing the deployed contract (`truffle test`)

## Development Process

Here are the major steps in the development process:

- Analyze the problem statement; design and represent the solution guided by design principles and UML diagrams.
- Develop and test the smart contract, using the Remix web IDE.
- Code the end-to-end Dapp, test and deploy it on test blockchains, and migrate it to main networks using the Truffle IDE.

## Mac Setup

```shell
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js and npm
brew install node

node -v
# e.g.
v16.10.0

npm -v                
# e.g.
7.24.1

# Install Truffle
npm install -g truffle

# If there are issues installing Truffle, then choose the LTS version e.g.
# npm uninstall -g truffle
# npm install -g truffle@nodeLTS

truffle version     
# e.g.
Truffle v5.4.16 (core: 5.4.16)
Solidity v0.5.16 (solc-js)
Node v16.10.0
Web3.js v1.5.3

# Install Ganache (https://www.trufflesuite.com/ganache), a blockchain client (test chain)
# It provides 10 accounts each with 100 mock either
brew install --cask ganache

# Start Ganache (via spotlight) and upon selecting "Quickstart".
# Copy the mnemonics (each time you boot Ganache) - you'll need them to authenticate access to the chain during testing of the Dapp
# e.g.
# gasp flash faculty now purchase doctor flame uniform surprise elephant water menu
```

## Example Dapp Directory Structure

We will develop a `ballot` Dapp:

```shell
|--- ballot-dapp
          |
          |--- ballot-app
          |
          |--- ballot-contract
```