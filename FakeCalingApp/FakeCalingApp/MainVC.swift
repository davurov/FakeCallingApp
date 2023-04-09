//
//  MainVC.swift
//  FakeCalingApp
//
//  Created by Abduraxmon on 09/04/23.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var secondsTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Fake Call"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        
        view.addGestureRecognizer(tap)
        nameTF.delegate = self
        secondsTF.delegate = self
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    func startDemo(name: String, sec: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            let callManager = CallManager()
            let id = UUID()
            callManager.reportIncomingCall(id: id, handle: name)
        }
    }
    
    @IBAction func callPressed(_ sender: Any) {
        
        if nameTF.text != "" , secondsTF.text != "" {
            if let num = Double(secondsTF.text!) {
                startDemo(name: nameTF.text!, sec: num)
            } else {
                startDemo(name: nameTF.text!, sec: 2.0)
            }
        } else if nameTF.text == "" && secondsTF.text != "" {
            if let num = Double(secondsTF.text!) {
                startDemo(name: "Unknown", sec: num)
            } else {
                startDemo(name: "Unknown", sec: 2.0)
            }
        } else if secondsTF.text == "" && nameTF.text != "" {
            startDemo(name: nameTF.text!, sec: 2.0)
        } else {
            startDemo(name: "Unkown", sec: 2.0)
        }
        
    }
    
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
