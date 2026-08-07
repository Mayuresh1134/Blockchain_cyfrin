// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19; //The ^ symbol means "this version or any compatible newer version up to but not including the next major version.

//pragma solidity 0.8.19; // Only use version 0.8.19

//pragma solidity >=0.8.19 <0.9.0; // Any version from 0.8.19 up to but not including 0.9.0


//1. Contract declaration
contract MyContract {
    //contract code goes here
}

//2. Variables : State Variables : Permanently stored on the blockchain in storage

contract StorageExample {

    uint256 public mynum = 56; //  a pubic number
    string public mytxt = "Hello"; //text
    bool public newbool = true; // a true/ false value
    address public myadress; // an ethereum address
    uint256 private secretnum; // a private number 
}

// State variable visility: public, private, internal

contract StateVarVisibility{

    uint256 public num_public = 234; // visible and accesible to all files in the code and solidity creates a getterfunction for public variables.
    uint256 private num_private = 56; // only accessible and visible inside the same contract.
    uint256 internal num_internal; // can be accessed through the contract and child contracts that inherit from it.

}

// Constant and immutable variables : Used to save gas costs in a contract both values cannot be changed once assigned.

//Constant: It is declared and assigned a value at the start of the contract itself and the value does not change afterwards.
//Immutable variables: It is declared inside the contract and can be assigned only once which happens inside a constructor


contract ConstantImmutablevar {
    //Constants must be assigned values at declaration
    uint256 public constant NUM3 = 343;
    string public constant TOKEN_NAME = "My Token";
    address public constant DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD; 
    
    //Declared but not assigned yet
    address public immutable deployer;
    uint256 public immutable deploymentTime;

    constructor(){
        deployer = msg.sender;
        deploymentTime = block.timestamp;
    }

}

//3. Data Types: 
//Value Types: store their data directly in the variable. Each variable has its own separate copy of the data.

contract DataTypes {

    uint256 public score = 100; // positive whole numbers no negative or decimals
    int256 public temperature = -5; // whole numbers that can be negative still no decimals
    bool public isComplete = false; // true or false value
    address public contractCreator = 0x343; // an ethereum account wallet address
    bytes32 public dataHash = 0xabdf; // fixed size byte arrays

}

// Reference types : don't store values directly in the var but store a pointer or reference to where the data is located.

contract RefDataTypes {

    string public message = "Welcome"; // Text values in dynamic length bytes
    uint256[] public scores = [23, 34, 55]; // ordered lists of same type in an array
    mapping(address => uint256) public balances; // key value paris like a dictionary or lookup table where each address has an associated uint256 value.
    struct Person{ // it is a custom grouping of related data
        string name;
        uint256 age;
        address walletAddress;
    } 
    bytes32 public dynamicData; //Variable length byte array
}



// 4. Pointers: It is a variable that stores the location for another piece of data rather than the data itself.
//In solidity reference types like strings, arrays, mappings, structs are stored as pointers.

//Example: (Pseudocode)

//Declare and initialize an array in storage(blockchain permanent memory)
array storageArray = [1,2,3];

//Create a pointer to the storage array 
//This doesn't copy the data, it just creates a reference to the same storage
array storagePointer = storageArray; // Points to the same data

//Modify the array through the pointer
storagePointer[0] = 100; // changes the actual storage array

//At this point:
//storageArray is [100,2,3]

//Create a memory copy of the storage array
//This copies the entire array to a new location in temporary memory
array memoryCopy = copy of storageArray; //memoryCopy is [100,2,3]

memoryCopy[1] = 200; //only changes the copy not the original storageArray

//Final result:
// storageArray is [100,2,3] (unchanged by memory modifications)
// memoryCopy is [100,200,3] {modified locally}


//Main Example:

contract PointerExample {

   // State array in storage
    uint256[] public storageArray = [1,2,3];

    function ArrayManipulation() pubic {
        //This creates a pointer to the storage array
        uint256[] storage storageArrayPointer = storageArray;
        
        //This modifies the actual storage array through the pointer
        storageArrayPointer[0] = 100;
         
        //At this point the array storageArray = [100,2,3]
    
        //This creates a copy in the memory, not a pointer to storage
        uint256[] memory StorageArrayCopy = storageArray;

        // This modifies only the memory copy not the storage copy , 
        StorageArrayCopy[1] = 200;

        //storageArrayCopy = [100,200,3] and original storageArray = [100,2,3]
    }
}


//Storage Locations
//1. storage: permanent storage on blockchain with high gas costs which means expensive.
//2. memory: creates a copy or temporary storage during function execution, cheaper than storage, generally using in function parameters, return values.
//3. calldata: read only temporary storage for function parameters like getting input and it is most gas efficient.


//State Variable - stored in storage
uint256[] permanentArray;

function passArray(uint256[] calldata inputValues) external {
    
    //inputValues exists in calldata which can't be modified only called as input.
    
    uint256[] memory tempArray = new uint256[](inputValues.length); //local variable in memory - temporary copy
    for(uint i = 0; i < inputValues.length; i++){
        tempArray[i] = inputValues[i]*2;
    }
    
    //Reference to storage - changes will persist
    uint256[] storage myStorageArray = permanentArray;
    myStorageArray.push(tempArray[0]); // This updates the blockchain state

}

// we usually  have reference types like strings, arrays and structs:
// 1. Use calldata for external function parameters like input and it is most cost efficient
// 2. Use memory for function parameters which are to be updated.
// 3. Finally use storage when we need to put that values on the chain or modify state variables.


//Functions: blocks of code that perform specific actions.  

//Example:

contract Counter{

    uint256 public counter =0;

    //This function increases the count by 1
    function increment() pubic {
        count = count +1;
    }

    function decrement() public {
        count = count -1;

    }
}

/*
A function has several components:

Name: What you call the function (like increment).

Parameters: Input values the function needs (none in the example above).

Visibility: Who can call this function (public in the example). More on this coming shortly!

Returns: What output the function provides (none in the example).

Function Body: The code inside the curly braces {}.

*/

Example:
function add(uint256 a, uint256 b) public pure returns (uint256){
    return a+b;
}

// pure means it doesn't read or modify state, returns a uint256 value

//Function visibility: 
/* 1. public: anyone can call this function
   2. private: only in that particular contract that function can be accessed
   3. internal: only that contract and the contract that inherit from it can call this function
   4. external: only calls from the outside the contract are allowed

*/

// Special function types 

//1. view: can read but not modify state

function getCount() public view returns (uint256) {
    return count;
}

// 2. pure: Cannot read or modify state

function addNumbers(uint256 a, uint256 b) public pure returns (uint256) {
    return a+b;
}

// 3. constructor: Runs only once when the contract is deployed

constructor() {
    owner = msg.sender; //sets the contract creator as the owner
}

// 4. payable: means that the function can be sent ether.

mapping(address => uint256) balances;

function sendMoney() public payable {

    balances[user] += msg.value;
}

//Transation Context Variables: provides access to transaction information and blockchain data through special builtin variables.

//1. msg.sender: the address that called the current function which is a wallet address or contract address, commonly used for access control and tracking user activity
//Example:

contract OwnerExample {
    address public owner;
    
    constructor(){
        owner = msg.sender; //The address that deploys the contract becomes the owner.
    }
}

//2. msg.value: The amount of eth sent with the function call: only available if function is marked payable and used to receive payments or deposits
//Example:

contract PaymentExample{
    mapping(address => uint256) public payments;

    //function that can receive eth
    function makePayment() public payable {
        require(msg.value> 0, "Must send some ETH");
        payments[msg.sender] += msg.value;
    }

    //Funtion that checks if minimum payment was made
    function verifyMinimumPayment(uint256 minimumAmount) public view returns (bool) {
        return payments[msg.sender] >= minimumAmount;
    }

}

//3. msg.data: The complete calldata(input data) of the transation: contains the function signature and arguments, used in advanced use cases and proxies.
//Example:

contract DataExample {
    bytes public lastCallData;

    //Store the raw calldata of the latest transaction
    function recordCallData() public {
        lastCallData = msg.data;

    }

    //View the size of the calldata
    function getCallDataSize() public view returns (uint256) {
        return lastCallData.length;
    }
}