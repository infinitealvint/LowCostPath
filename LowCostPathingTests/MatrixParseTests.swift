//
//  MatrixParseTests.swift
//  LeastCostMatrix
//
//  Created by Alvin Tu on 3/30/17.
//  Copyright © 2017 NA. All rights reserved.
//

import XCTest
@testable import LowCostPathing

class MatrixParseTests: XCTestCase {
    
    //Non-Numeric
    func testForNonNumericInputCharacters() {
        let input = "1 a c\n2 3 4"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertFalse(validationResult.success)
    }
    
    //Empty input
    func testForEmptyInput() {
        let input = " "
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertFalse(validationResult.success)
    }
    
    //Unbalanced matrix, extra columns
    func testForIncorrectColumns() {
        let input = "1 2 3 4 5\n1 2 3 4 5 6"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertFalse(validationResult.success)
    }
    
    //Single row
    func testForSingleRowInput() {
        let input = "1 2 3 4 5"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertTrue(validationResult.success)
    }
    
    //Unbalanced Matrix, extra spacings
    func testForIncorrectSpacings() {
        let input = "1 2 3 4 5\n1 2 3 4  5"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertFalse(validationResult.success)
    }
    
    //Proper Matrix
    func testForNonNilMatrix() {
        let input = "1 20 3 4 5\n1 2 3 4 5\n2 3 4 1 4\n1 2 3 8 90"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertNotNil(validationResult.costMatrix)
    }
    
    //Unbalanced Matrix, missing columns
    func testForNilMatrix() {
        let input = "1 20 3 4 5\n1 2"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssertNil(validationResult.costMatrix)
    }
    
    // -ve test case scenario for row count
    func testForFailureRowCount() {
        let input = "1 20 3 4 5\n1 2 3 1 2\n2 4 1 3 1\n1 24 1 8 9"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssert(validationResult.costMatrix?.count != 2)
    }
    
    // +ve test case scenario for row count
    func testForCorrectRowCount() {
        let input = "1 20 3 4 5\n1 2 3 1 2\n2 4 1 3 1\n1 24 1 8 9"
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        XCTAssert(validationResult.costMatrix?.count == 4)
    }
    
}
