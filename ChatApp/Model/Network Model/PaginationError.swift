//
//  PaginationError.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//


import Foundation

struct PaginationError: LocalizedError {
    
    var message: String
    
    var errorDescription: String? {
        return message
    }
}

