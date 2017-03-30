//
//  MatrixParse.swift
//  LowCostPathing
//
//  Created by Alvin Tu on 3/30/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation


class MatrixParse {
    
    static func parse(through input:String, delimitedBy delimiters:(row:String,column:String)) -> (costMatrix:[[Int]]?,success:Bool,error:String) {
        var costInputMatrix = [[Int]]()
        let costInputRows = input.components(separatedBy: delimiters.row)
        var columnCount = 0
        var rowCount = 0
    
        // Loop through the rows delimited by (\n) new line character
        for row in costInputRows {
            let trimmedRow = row.trimmingCharacters(in: .whitespaces)
            // No Input Check
            
            // Sample 7: (No input - Optional)  //condition inside MatrixParse.swift

            if(rowCount==0 && trimmedRow.isEmpty){
                return(nil,false,"Please enter input")
            }
            
            rowCount = rowCount + 1
            
            if(rowCount==costInputRows.count && trimmedRow.isEmpty){
                return (costInputMatrix,true,"Proper Matrix")
            }
            
            // Parse  row for Columns delimited by space (" ")
            let columns = trimmedRow.components(separatedBy: delimiters.column)
            let currentRowColumnCount = columns.count;
            
            // Check for uneven columns except the first row
            if (columnCount>0 && currentRowColumnCount>0 && currentRowColumnCount != columnCount) {
                return(nil,false,"Invalid Matrix")
            }
            
            columnCount = currentRowColumnCount;
            
            // Proceed only if we have columns to process
            if columns.count > 0 {
                var columnMatrix = [Int]()
                for column in columns {
                    
                    
                    // Check for non-numeric characters
                    if let convertedInt = Int(column) {
                        
                        // Group all the columns together
                        columnMatrix.append(convertedInt)
                    } else {
                        //Sample 6: (Non numeric input, Optional)

                        return(nil,false,"Invalid Matrix")
                    }
                }
                
                // Add grouped columns for rows
                costInputMatrix.append(columnMatrix)
            }
        }
        
        //Validation success
        return (costInputMatrix,true,"Proper Matrix")
}
}
