// --------------------------------------------------
// DateFormattersTests.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Testing
import Foundation
@testable import GitHubViewer

struct DateFormattersTests {

    // MARK: - ISO 8601
    
    @Test("ISO 8601 - Testing String to Date conversion for valid input")
    func iso8601DateFromValidInput() {
        
        let input = "2001-02-03T13:34:56Z"
        
        let components = DateComponents(year: 2001, month: 2, day: 3, hour: 13, minute: 34, second: 56)
        let expectedDate = Calendar.current.date(from: components)!
        
        let date = DateFormatter.iso8601.date(from: input)
        #expect(date == expectedDate)
    }
    
    @Test("ISO 8601 - Testing String to Date conversion for valid ISO 8601 input with different format")
    func iso8601DateFromLongInput() {
        let input = "2001-02-03T13:34:56.999+0200Z"
        let date = DateFormatter.iso8601.date(from: input)
        #expect(date == nil)
    }
    
    @Test("ISO 8601 - Testing String to Date conversion for invalid input")
    func iso8601DateFromInvalidInput() {
        let input = "I'm Error"
        let date = DateFormatter.iso8601.date(from: input)
        #expect(date == nil)
    }
    
    // MARK: - UI Format
 
    @Test("UI Date Format - Testing Date to Srting formatting")
    func uiFormatFromValidInput() {
        
        let components = DateComponents(year: 2001, month: 2, day: 3, hour: 13, minute: 34, second: 56)
        let input = Calendar.current.date(from: components)!
        let expectedOutput = "3 February 2001 at 13:34:56"
        
        let formattedDate = DateFormatter.userInterfaceFormat.string(from: input)
        
        #expect(formattedDate == expectedOutput)
    }
}
