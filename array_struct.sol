// Arrays

uint256[] favNumber = [23,44,21];

//struct

struct Person {
    uint256 my_favNUm;
    string name;
}

Person public my_friend = Person(4,"Mayuresh");

//Array of struct

Person[] public list_of_people;
Person[3] public another_list_of_people;

function add_person(string memory _name, uint256 _favorite_number) public {
    list_of_people.push(Person(_favorite_number, _name));
}


