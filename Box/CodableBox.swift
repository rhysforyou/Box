//
//  CodableBox.swift
//  Box-Mac
//
//  Created by Rhys Powell on 1/5/18.
//  Copyright © 2018 Rob Rix. All rights reserved.
//

import Foundation

public final class CodableBox<T: Codable>: BoxType, CustomStringConvertible, Codable {
    /// Initializes a `Box` with the given value.
    public init(_ value: T) {
        self.value = value
    }

    /// Constructs a `Box` with the given `value`.
    public class func unit(_ value: T) -> Box<T> {
        return Box(value)
    }

    /// The (immutable) value wrapped by the receiver.
    public let value: T

    /// Constructs a new Box by transforming `value` by `f`.
    public func map<U>(_ f: (T) -> U) -> Box<U> {
        return Box<U>(f(value))
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return String(describing: value)
    }

    // MARK: - Codable

    public init(from decoder: Decoder) throws {
        value = try Value(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
