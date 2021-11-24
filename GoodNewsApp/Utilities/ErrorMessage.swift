//
//  ErrorMessage.swift
//  GoodNewsApp
//
//  Created by M. Raşit Öner on 29.10.2021.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidResponse = "Sorry, we can not reach the websites at the moment!"
    case invalidData = "Please modify your search and try again!"
}
