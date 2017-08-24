//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by asood2 on 8/23/17.
//  Copyright © 2017 Ankur Sood. All rights reserved.
//

import UIKit

protocol VCSettingsDelegate {
    func exchangeData(data: Array<Double>, value: Int)
}

class SettingsViewController: UIViewController {

    var delegate: VCSettingsDelegate?
    var tipPercentages: [Double] = []
    
    @IBOutlet weak var TipValue1: UITextField!
    @IBOutlet weak var TipValue2: UITextField!
    @IBOutlet weak var TipValue3: UITextField!
    @IBOutlet weak var SwitchOn: UISwitch!
    var tip1:Double?, tip2:Double?, tip3:Double?
    var tipArray: Array<Double> = []
    var gradient: CAGradientLayer!
    
    func createGradient(){
        gradient = CAGradientLayer()
        let grad1 = UIColor(red:52/255, green:232/255, blue:158/255, alpha:1.0).cgColor
        let grad2 = UIColor(red:51/255, green:51/255, blue:153/255, alpha:1.0).cgColor
        gradient.colors = [grad1, grad2]
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradient()
        SwitchOn.setOn(false, animated: true)
        TipValue1.isUserInteractionEnabled = false
        TipValue1.isEnabled = false
        TipValue2.isUserInteractionEnabled = false
        TipValue2.isEnabled = false
        TipValue3.isUserInteractionEnabled = false
        TipValue3.isEnabled = false
    }

    @IBAction func `switch`(_ sender: UISwitch) {
        if sender.isOn == true {
            TipValue1.isUserInteractionEnabled = true
            TipValue1.isEnabled = true
            TipValue2.isUserInteractionEnabled = true
            TipValue2.isEnabled = true
            TipValue3.isUserInteractionEnabled = true
            TipValue3.isEnabled = true
        } else {
            TipValue1.isUserInteractionEnabled = false
            TipValue1.isEnabled = false
            TipValue2.isUserInteractionEnabled = false
            TipValue2.isEnabled = false
            TipValue3.isUserInteractionEnabled = false
            TipValue3.isEnabled = false
        }
    }
    
    @IBAction func getTipValue(_ sender: UITextField) {
        tip1 = Double(TipValue1.text!) ?? 0
        tip2 = Double(TipValue2.text!) ?? 0
        tip3 = Double(TipValue3.text!) ?? 0
        tipArray = [tip1!, tip2!, tip3!]
        delegate?.exchangeData(data: tipArray, value: 0)
    }
}
