let abi = [
			{
				"anonymous": false,
				"inputs": [],
				"name": "DepositSuccess",
				"type": "event"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": true,
						"internalType": "address",
						"name": "_from",
						"type": "address"
					},
					{
						"indexed": true,
						"internalType": "address",
						"name": "_to",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "_amount",
						"type": "uint256"
					}
				],
				"name": "TokensSent",
				"type": "event"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "_value",
						"type": "uint256"
					}
				],
				"name": "WithdrawSuccess",
				"type": "event"
			},
			{
				"inputs": [],
				"name": "checkAccountBalance",
				"outputs": [
					{
						"internalType": "uint256",
						"name": "",
						"type": "uint256"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [],
				"name": "checkContractBalance",
				"outputs": [
					{
						"internalType": "uint256",
						"name": "",
						"type": "uint256"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [],
				"name": "deposit",
				"outputs": [],
				"stateMutability": "payable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_value",
						"type": "uint256"
					}
				],
				"name": "proofOfReserve",
				"outputs": [],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "address",
						"name": "_receiver",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "_value",
						"type": "uint256"
					}
				],
				"name": "sendToAddress",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_value",
						"type": "uint256"
					}
				],
				"name": "withdraw",
				"outputs": [],
				"stateMutability": "payable",
				"type": "function"
			}
		];

const Web3 = require('web3');
const contractAddr = "0x442371264e257c429DB93d204EFdad170638716B";
const eventResult = "";

let accounts;
let web3;

async function enableDapp() {
    if (typeof window.ethereum != 'undefined') {
        try {
            accounts = await ethereum.request({
                method: 'eth_requestAccounts'
            });
            web3 = new Web3(window.ethereum);
            console.log("Accounts: " + accounts[0]);
        } catch (error) {
            if (error.code == 4001) {
                console.log("You don't have the permission to continue.");
            } else {
                console.error(error.message);
            }
        }
    } else {
        console.log("You need to install MetaMask");
    }
}

async function listenToEvents() {
    let contractInstance = new web3.eth.Contract(abi, contractAddr);
    console.log(contractInstance.getPastEvents('DepositSuccess'));
    contractInstance.getPastEvents("DepositSuccess", {fromBlock: 0}).then(event => {
        console.log(event);
    });

}

listenToEvents();
enableDapp();
