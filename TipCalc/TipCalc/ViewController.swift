//
//  ViewController.swift
//  TipCalc
//
//  Created by asood2 on 8/23/17.
//  Copyright © 2017 Ankur Sood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VCSettingsDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    var tipPercentages: [Double] = []
    var tipControl: UISegmentedControl!
    var dataFromSettingsVC:Int?
    var tip:Double?
    var gradient: CAGradientLayer!
    var const = [NSLayoutConstraint]()
    let grad1 = UIColor(red:52/255, green:232/255, blue:158/255, alpha:1.0).cgColor
    let grad2 = UIColor(red:51/255, green:51/255, blue:153/255, alpha:1.0).cgColor
    
    func createGradient(){
        gradient = CAGradientLayer()
        gradient.colors = [grad1, grad2]
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = 0
        createGradient()
        if tipPercentages.isEmpty{
            tipPercentages = [0.18, 0.2, 0.25]
        } else if (String(tipPercentages[0]) == "0.0") {
            tipPercentages = [0.18, 0.2, 0.25]
        }else {
            tipControl.removeAllSegments()
            tipControl = UISegmentedControl(items: [String(Int(100*tipPercentages[0]))+"%", String(Int(100*tipPercentages[1]))+"%",String(Int(100*tipPercentages[2]))+"%"])
            tipControl.tintColor = UIColor.white
            self.view.addSubview(tipControl)
            tipControl.layer.borderWidth = CGFloat(1.5)
            tipControl.layer.cornerRadius = CGFloat(2.0)
            tipControl.layer.masksToBounds = true
            tipControl.tintColor = UIColor.white
            tipControl.addTarget(self, action: #selector(ViewController.calculateTip(_:)), for: .allEvents)
            tipControl.translatesAutoresizingMaskIntoConstraints = false
            let leadingCons = tipControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
            let trailingCons = tipControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
            let topCons = tipControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300)
            const.append(contentsOf: [leadingCons, trailingCons, topCons])
            NSLayoutConstraint.activate(const)
        }
    }
    
    func exchangeData(data: Array<Double>, value: Int)
    {
        tipPercentages[0] = data[0]/100
        tipPercentages[1] = data[1]/100
        tipPercentages[2] = data[2]/100
        print(data)
        tipControl.selectedSegmentIndex = value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCSettings = segue.destination as? SettingsViewController {
            VCSettings.delegate = self
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        billField.placeholder = "Enter Amount"
        tipControl = UISegmentedControl (items: ["18%","20%","25%"])
        self.view.addSubview(tipControl)
        tipControl.layer.borderWidth = CGFloat(1.5)
        tipControl.layer.cornerRadius = CGFloat(2.0)
        tipControl.layer.masksToBounds = true
        tipControl.tintColor = UIColor.white
        tipControl.addTarget(self, action: #selector(ViewController.calculateTip(_:)), for: .allEvents)
        tipControl.translatesAutoresizingMaskIntoConstraints = false
        tipControl.selectedSegmentIndex = 0
        let leadingCons = tipControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:10)
        let trailingCons = tipControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        let topCons = tipControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300)
        const.append(contentsOf: [leadingCons, trailingCons, topCons])
        NSLayoutConstraint.activate(const)
    }

    @IBAction func OnTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        let index = tipControl.selectedSegmentIndex
        if (index == -1){
            tipControl.selectedSegmentIndex = 0
        }
        let bill = Double(billField.text!) ?? 0
        tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip!
        tipLabel.text = String(format: "$%.2f", tip!)
        totalLabel.text = String(format: "$%.2f", total)
    }
}
