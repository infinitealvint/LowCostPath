//
//  MatrixTests.swift
//  LeastCostMatrix
//
//  Created by Alvin Tu on 3/30/17.
//  Copyright © 2017 NA. All rights reserved.
//

import XCTest
@testable import LowCostPathing

class MatrixTests: XCTestCase {
    
    // 6*5 normal path
    func testForSampleSet1() {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4";
        let expectedPath = [1,2,3,4,4,5]
        
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertTrue(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==16)
        print(processedOutput!.path)
        XCTAssertTrue(processedOutput!.path==expectedPath)
    }
    
    //6X5 with edge paths
    func testForSampleSet2() {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3";
        let expectedPath = [1,2,1,5,4,5]
        
        let validationResult = MatrixParse.parse(through: input, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertTrue(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==11)
        XCTAssertTrue(processedOutput!.path==expectedPath)
    }
    
    //5X3 with edge paths
    func testForSampleSet3() {
        let inputCost = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10";
        let expectedPath = [1,1,1]
        
        let validationResult = MatrixParse.parse(through: inputCost, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertFalse(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==48)
        XCTAssertTrue(processedOutput!.path==expectedPath)
    }
    
    //1X5 matrix Single row
    func testForSampleSet4() {
        let inputCost = "5 8 5 3 5";
        let expectedPath = [1,1,1,1,1]
        
        let validationResult = MatrixParse.parse(through: inputCost, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertTrue(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==26)
        XCTAssertTrue(processedOutput!.path==expectedPath)
    }
    
    //5X1 matrix Single column
    func testForSampleSet5() {
        let inputCost = "5\n8\n5\n3\n5"
        let expectedPath = [4]
        
        let validationResult = MatrixParse.parse(through: inputCost, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertTrue(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==3)
        XCTAssertTrue(processedOutput!.path==expectedPath)
    }
    
    // All values of First column >50
    func testForSampleSet8() {
        let inputCost = "69 10 19 10 19\n51 23 20 19 12\n60 12 20 11 10"
        let expectedPath:[Int] = []
        
        let validationResult = MatrixParse.parse(through: inputCost, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertFalse(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==0)
        XCTAssertTrue(processedOutput!.path == expectedPath)
        
    }
    
    // First cell >50
    func testForSampleSet9() {
        let inputCost = "60 3 3 6\n6 3 7 9\n5 6 8 3"
        let expectedPath:[Int] = [3,2,1,3]
        
        let validationResult = MatrixParse.parse(through: inputCost, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertTrue(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==14)
        XCTAssertTrue(processedOutput!.path == expectedPath)
        
    }
    
    //Negative values
    func testForNegativeValues() {
        let inputCost = "6 3 -5 9\n-5 2 4 10\n3 -2 6 10\n6 -1 -2 10"
        let expectedPath:[Int] = [2,3,4,1]
        
        let validationResult = MatrixParse.parse(through: inputCost, delimitedBy: ("\n"," "))
        let matrix = Matrix(storedCostValues: validationResult.costMatrix!)
        let matrixCalculator = MatrixCalculator(with: matrix)
        let processedOutput = matrixCalculator.calculateMinimumCost()
        
        XCTAssertTrue(processedOutput!.pathCompleted)
        XCTAssertTrue(processedOutput!.cost==0)
        XCTAssertTrue(processedOutput!.path == expectedPath)
        
    }
    
}
