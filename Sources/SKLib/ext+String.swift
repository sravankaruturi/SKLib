//
//  ext+String.swift
//  
//
//  Created by Sravan Karuturi on 7/22/24.
//
import Foundation

extension String {
    public var isEmptyOrWhitespace: Bool {
        return self.isEmpty || self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String {
    public var isEmptyOrWhitespace: Bool {
        return self?.isEmptyOrWhitespace ?? true
    }
}
