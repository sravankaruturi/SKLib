//
//  Ext+URLResponse.swift
//

import Foundation

extension HTTPURLResponse {
    public var isResponseOk: Bool {
         return (200...299).contains(self.statusCode)
     }
}
