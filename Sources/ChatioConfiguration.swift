//
//  ChatioConfiguration.swift
//  Pods
//
//  Created by Łukasz Jerciński on 15/03/2017.
//
//

import Foundation

struct ChatioConfiguration : Equatable {
    var licenseId: String
    var groupId: String = "0"
    var name: String = ""
    var email: String = ""
    
    static func == (lhs: ChatioConfiguration, rhs: ChatioConfiguration) -> Bool {
        return lhs.licenseId == rhs.licenseId &&
            lhs.groupId == rhs.groupId &&
            lhs.name == rhs.name &&
            lhs.email == rhs.email
    }
}
