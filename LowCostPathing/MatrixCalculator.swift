//
//  MatrixCalculator.swift
//  LowCostPathing
//
//  Created by Alvin Tu on 3/30/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation

// Process the matrix and returns the minimum cost and its path.
class MatrixCalculator {
    
    private(set) var originalMatrix:Matrix?
    private(set) var calculatedMatrix:Matrix?
    
    init(with inputMatrix:Matrix) {
        originalMatrix = inputMatrix
        calculatedMatrix = Matrix(withMatrix: inputMatrix)
    }
    
    // Returns original user input matrix
    func getOriginalMatrix()-> Matrix? {
        return originalMatrix
    }
    
    // Returns calculated Matrix
    func getCalculatedMatrix()-> Matrix? {
        return calculatedMatrix
    }
    
    // Calculates each column costs and traces the minimum path from last processed column
    func calculateMinimumCost()->(path:[Int],cost:Int,pathCompleted:Bool)?{
        
        //Return if matrix or values are nil
        guard calculatedMatrix != nil, calculatedMatrix!.costValues != nil else{
            return nil
        }
        
        // Calculate all columns costs
        for currentColumn in 0..<calculatedMatrix!.numOfColumns{
            
            // Checks for least possbile cost for all rows in particular column
            let columnCosts = calculatedMatrix!.processColumn(column: currentColumn)
            
            //Stop execution when threadhold limit has reached.
            if columnCosts.proceedNext == false {
                break
            }
        }
        
        //Traces the minimum path on the processed Matrix
        if let minimumCostDetails = calculatedMatrix!.traceShortestPath() {
            let paths = minimumCostDetails.path
            //Processes only the rows, ignore the columns
            var rowDetails = [Int]()
            for path in paths {
                rowDetails.append(path.0+1)
            }
            return(rowDetails,minimumCostDetails.cost,minimumCostDetails.pathExists)
        }
        
        //Didnt move from first column
        return([],0,false)
    }
    
}
