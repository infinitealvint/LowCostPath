//
//  ViewController.swift
//  LowCostPathing
//
//  Created by Alvin Tu on 3/30/17.
//  Copyright © 2017 NA. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var _pathLowestCost: UILabel!
    @IBOutlet weak var _lowestCost: UILabel!
    @IBOutlet weak var _doesPathExist: UILabel!
    @IBOutlet weak var _inputTxtView: UITextView!
    @IBOutlet weak var _selectMatrixTxtFld: UITextField!
    
    var matrixInputPicker = UIPickerView()
    var toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._inputTxtView.delegate = self
        self.matrixInputPicker.delegate = self
        self.matrixInputPicker.dataSource = self
        
        //Configuring the toolbar and setting the pickerview
        configureToolbar(toolBar: toolbar)
        _selectMatrixTxtFld.inputView = matrixInputPicker
        _selectMatrixTxtFld.inputAccessoryView = toolbar
    }


    //MARK: ToolBar Configuration
    //Configuring Toolbar for UIPicker
    func configureToolbar(toolBar: UIToolbar){
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
    func donePicker(){
        _selectMatrixTxtFld.endEditing(true)
        resetView()
    }
    
    //Enter the user input

    @IBAction func Enter(_ sender: Any) {
        
        //Parse the input from textview delimited by new line character and spaces
        let validateResult = MatrixParse.parse(through: _inputTxtView.text, delimitedBy: ("\n"," "))
        
        //Display an alert if input is not parsed successfully
        if(!validateResult.success){
            let alert = UIAlertController(title: "Error", message: validateResult.error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.show(alert, sender: nil)
            return

    }
  
        //Init the matrix with textview parsed matrix values
        let matrix = Matrix(storedCostValues: validateResult.costMatrix)
        
        //Initia the matrix calculator with the matrix
        let matrixCalculator  = MatrixCalculator(with: matrix)
        
        //Calculate the minimum cost
        let lowestCost = matrixCalculator.calculateMinimumCost()
        
        //Refresh interface with the processed details
        _lowestCost.text = "Cost of Path : \(lowestCost!.cost)"
        
        if(lowestCost?.pathCompleted)!{
            _doesPathExist.text = "Path Completed : Yes"
        }else{
            _doesPathExist.text = "Path Completed : No"
        }
        
        _pathLowestCost.text = "Path : \(lowestCost!.path)"
    }
    
    //Reset the MainVC
    func resetView(){
        _lowestCost.text = "Cost of Path :"
        _pathLowestCost.text = "Path :"
        _doesPathExist.text = "Path Completed :"
    }
    
    //MARK: Keyboard Dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //MARK: PickerView DataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  matrixPickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return matrixPickerArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //MARK: PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectMatrixTxtFld.text = matrixPickerArray[row]
        
        if row != 0 {
            _inputTxtView.text = inputArray[row - 1]
        }
    }
    

}




