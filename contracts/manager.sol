//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;
import "./Students.sol";
import "./book_collection.sol";

contract manager is StudentCollection,book_collection {
    address private immutable i_admin;
    address private immutable i_manager;

    constructor(address manager) {
        i_admin = msg.sender;
        i_manager = manager;
    }

    // modifier
    modifier isAdmin() {
        require(i_admin == msg.sender, "You cant access it");
        _;
    }
    modifier isManager(){
        require(i_manager==msg.sender,"You cant access it");
        _;
    }


    //function
    // add student
    function addStudent(string memory _name,uint8 _sem,address student_address)public isAdmin {
        student_details[student_address].name = _name;
        student_details[student_address].semester = _sem;
    }
    // delete student
    function deleteStudent(address student_address)public {
        delete student_details[student_address];
    }
    // update details of student
    function updateDetailsOfStudent(uint8 sem,address student_address)public {
        student_details[student_address].semester = sem;
    }
    // add book 
    function addBook(uint id,uint8 _edition,uint8 _total,string memory book_name)public{
        books[id].bookName = book_name;
        books[id].edition = _edition;
        books[id].total = _total;
        books[id].stock = 0;
    }
    // delet books
    function deleteBook(uint id)public{
        delete books[id];
    }
    // update quantities of books also edition.
    function updateBook(uint id,uint8 _newStock,uint8 _edition)public{
        books[id].total = books[id].total+_newStock;
        books[id].edition = _edition; 
    }
    // book issue

    function issueBook(uint bookId,address reciever)public{
        student_details[reciever].lend_books[bookId] = books[bookId].lender.length;
        books[bookId].stock = books[bookId].stock-1;
        books[bookId].lender.push(reciever);
    }
    // book return 
    function returnBook(uint bookId,address student)public{
        uint index = student_details[student].lend_books[bookId];
        delete books[bookId].lender[index];
       delete student_details[student].lend_books[bookId];
    }
}

// Interact contract with students and book-collections
// get book and return book
