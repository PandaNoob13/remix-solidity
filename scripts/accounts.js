(async () => {

    let abiArray = [
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
    let address = "0x3e37eC7D6ACbEDd75D1eAE7daaEE187d7505E1c1";

    let contractInstance = new web3.eth.Contract(abiArray, address);

    console.log(await contractInstance.methods.checkContractBalance().call());
    let accounts = await web3.eth.getAccounts();

    // await contractInstance.methods.deposit().send({value: 1000, from: accounts[0]});

    console.log(await contractInstance.methods.checkContractBalance().call());    
})()