//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract book_collection{
    struct Book{
        string bookName;
        uint8 edition;
        uint8 stock;
        uint8 total;
        address[] lender;
    }
    mapping(uint=>Book) books;
}

// this will contains collection of all books and their details