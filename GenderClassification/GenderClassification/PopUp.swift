//
//  PopUp.swift
//  GenderClassification
//
//  Created by Milo Bizzotto on 29/04/23.
//

import UIKit

class PopUp: UIViewController {
    @IBOutlet weak var out: UILabel!
    var gender : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        out.text = "questo soggetto è " + gender + "!!"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
