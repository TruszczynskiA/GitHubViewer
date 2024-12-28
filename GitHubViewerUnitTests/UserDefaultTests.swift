// --------------------------------------------------
// UserDefaultTests.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Testing
import Foundation
@testable import GitHubViewer

struct UserDefaultTests {
    
    @Test("Testing read/write of Int from/to UserDefaults")
    func setAndReadPrimitive() {
        
        let expectedValue = 123
        @UserDefault(key: "test1") var testValue: Int?
        testValue = expectedValue
        
        #expect(testValue == expectedValue)
    }
    
    @Test("Testing removing Int from UserDefaults")
    func clearPrimitive() {
        
        @UserDefault(key: "test2") var testValue: Int?
        testValue = nil
        
        #expect(testValue == nil)
    }
    
    @Test("Testing read/write of Struct from/to UserDefaults")
    func setAndReadStruct() {
        
        let expectedStruct = TestStruct(foo: nil, bar: "Hello")
        @UserDefault(key: "test3") var testStruct: TestStruct?
        testStruct = expectedStruct
        
        #expect(testStruct == expectedStruct)
    }
    
    @Test("Testing removing Struct from UserDefaults")
    func clearStruct() {
        
        @UserDefault(key: "test4") var testStruct: TestStruct?
        testStruct = nil
        
        #expect(testStruct == nil)
    }
    
    @Test("Testing read/write of Object from/to UserDefaults")
    func setAndReadObject() {
        
        let expectedObject = TestObject(foo: nil, bar: "Hello")
        @UserDefault(key: "test5") var testObject: TestObject?
        testObject = expectedObject
        
        #expect(testObject == expectedObject)
    }
    
    @Test("Testing removing Object from UserDefaults")
    func clearObject() {
        
        @UserDefault(key: "test6") var testObject: TestObject?
        testObject = nil
        
        #expect(testObject == nil)
    }
}

// MARK: - Elements

private struct TestStruct: Equatable, Codable {
    let foo: Int?
    let bar: String
}

private final class TestObject: Equatable, Codable {
    
    let foo: Int?
    let bar: String
    
    init(foo: Int?, bar: String) {
        self.foo = foo
        self.bar = bar
    }
    
    static func == (lhs: TestObject, rhs: TestObject) -> Bool {
        lhs.foo == rhs.foo && lhs.bar == rhs.bar
    }
}
