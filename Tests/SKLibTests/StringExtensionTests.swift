//
//  StringExtensionTests.swift
//  
//
//  Created by Sravan Karuturi on 7/22/24.
//
import Testing

@Suite("String Extension Tests")
struct StringExtensionTests {
    
    @Test func isEmptyOrWhitespaceSucceedsForEmptyString() async throws {
        
        let str = ""
        #expect(str.isEmptyOrWhitespace == true)
        
    }
    
    @Test func isEmptyOrWhitespaceSucceedsForWhitespaceString() async throws {
        
        let str = " "
        #expect(str.isEmptyOrWhitespace == true)
        
    }
    
    @Test func isEmptyOrWhitespaceSucceedsForNilString() async throws {
        let str: String? = nil
        #expect(str.isEmptyOrWhitespace == true)
    }
    
    @Test func isEmptyOrWhitespaceSucceedsForNewLineString() async throws {
        
        let str = "\n"
        #expect(str.isEmptyOrWhitespace == true)
        
    }
    
    @Test func isEmptyOrWhitespaceSucceedsForTabString() async throws {
        
        let str = "\t"
        #expect(str.isEmptyOrWhitespace == true)
        
    }
    
    @Test func isEmptyOrWhitespaceSucceedsForNonEmptyString() async throws {
        
        let str = "Hello"
        #expect(str.isEmptyOrWhitespace == false)
        
    }
}
