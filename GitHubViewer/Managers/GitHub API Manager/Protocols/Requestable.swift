// --------------------------------------------------
// Requestable.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

protocol Requestable {
    
    associatedtype ResponseType: Decodable
    
    var path: String { get }
    var method: RequestMethod { get }
}

extension Requestable {
    var responseType: ResponseType.Type { ResponseType.self }
}
