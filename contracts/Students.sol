//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract StudentCollection {
    struct Student {
        string name;
        uint8 semester;
        mapping(uint=>uint) lend_books;
    }
    mapping(address => string) student_details_uri;
    mapping(address => Student) student_details;
    mapping(address => uint[]) book_lended;

    function addNewStudentDetails(
        string memory uri,
        address studentAddress
    ) public {
        student_details_uri[studentAddress] = uri;
    }

    function checkBookLended(
        address studentAddress
    ) public view returns (uint[] memory) {
        return book_lended[studentAddress];
    }

    function lendBook(address studentAddress, uint bookId) public {
        book_lended[studentAddress].push(bookId);
    }
}

// this will store the details of students
