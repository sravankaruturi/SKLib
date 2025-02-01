//
//  ext+Date.swift
//  SKLib
//
//  Created by Sravan Karuturi on 1/31/25.
//
import Foundation

extension Date {
    
    func formatToMonYear() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM y"
        return formatter.string(from: self)
        
    }
    
}
