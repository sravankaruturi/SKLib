//
//  ResultExtensionTests.swift
//  
//
//  Created by Sravan Karuturi on 7/22/24.
//

import Testing
import Foundation

// SwiftTesting suite for ext+Result file

@Suite("Result Extensions Tests")
struct ResultExtensionTests {
    
    @Test func ResultSuccessCheck() async throws {
        
        let result = Result<Int, Error>.success(10)
        
        #expect(result.successValue == 10)
        #expect(result.failureError == nil)
        
    }
    
    @Test func ResultFailureCheck() async throws {
        
        let result = Result<Int, Error>.failure(NSError(domain: "", code: 0, userInfo: nil))
        
        #expect(result.successValue == nil)
        #expect(result.failureError != nil)
        
    }
    
}
