//
//  ViewController.swift
//  GenderClassification
//
//  Created by Milo Bizzotto on 28/04/23.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var tx1: UITextField!
    @IBOutlet weak var tx2: UITextField!
    @IBOutlet weak var sc1: UISegmentedControl!
    @IBOutlet weak var sc2: UISegmentedControl!
    @IBOutlet weak var sc3: UISegmentedControl!
    @IBOutlet weak var sc4: UISegmentedControl!
    @IBOutlet weak var conferma: UIButton!
    var gender : String = ""
    func receiveJson(s1 : String,s2 : String,s3:String,s4:String,s5:String,s6:String) {
        let str = "http://127.0.0.1:5000/prediction/"+s1+"/"+s2+"/"+s3+"/"+s4+"/"+s5+"/"+s6
        
        guard let url = URL(string: str) else { return }
        
             let task = URLSession.shared.dataTask(with: url) { data, response, error in guard let data = data, error == nil else { return }
                 do {
                     if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                         self.gender = (json["genere"]) as! String
                         DispatchQueue.main.async {
                             self.performSegue(withIdentifier: "PopUp", sender: nil)
                         }
                     }
                 } catch let error as NSError {
                     print("Failed to load: \(error.localizedDescription)")
                 }
             }
             task.resume()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func action_conferma(_ sender: Any) {
        var s1 : String? = nil
        var s2 : String? = nil
        if(tx1.text!.isFloat()){
            if(tx1.text!.contains(".")){
                s1 = tx1.text!
            }else{
                s1 = tx1.text! + ".0"
                tx1.text = s1
            }
        }
        else{
            tx1.text = "ERRORE NELLA FORMATTAZIONE"
        }
        if(tx2.text!.isFloat()){
            if(tx2.text!.contains(".")){
                s2 = tx2.text!
            }else{
                s2 = tx2.text! + ".0"
                tx2.text = s2
            }
        }
        else{
            tx2.text = "ERRORE NELLA FORMATTAZIONE"
        }
        let s3 = String(sc1.selectedSegmentIndex)
        let s4 = String(sc2.selectedSegmentIndex)
        let s5 = String(sc3.selectedSegmentIndex)
        let s6 = String(sc4.selectedSegmentIndex)
        if(s1 != nil && s2 != nil){
            receiveJson(s1: s1!, s2: s2!, s3: s3, s4: s4, s5: s5, s6: s6)
        }
        tx1.text = ""
        tx2.text = ""
        sc1.selectedSegmentIndex = 0
        sc2.selectedSegmentIndex = 0
        sc3.selectedSegmentIndex = 0
        sc4.selectedSegmentIndex = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let ViewController = segue.destination as! PopUp
        ViewController.gender = self.gender
        }
    @IBAction func DeleteText(_ sender: UITextField) {
        sender.text = ""
    }
    
}
           extension String{
               func isFloat() -> Bool {

                       if let floatValue = Float(self) {
                           return true
                       }

                       return false
                   }
           }
