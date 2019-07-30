//
//  ViewController.swift
//  day09
//
//  Created by Yaroslava HLIBOCHKO on 7/5/19.
//  Copyright © 2019 Yaroslava HLIBOCHKO. All rights reserved.
//

import UIKit
import LocalAuthentication
import yhliboch2019
import CoreData

class ViewController: UIViewController {
    let context = LAContext()
    @IBOutlet weak var loginOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.authenticationWithPathword()
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            switch context.biometryType {
            case .none:
                self.loginOutlet.setTitle("Login with Password", for: .normal)
                loginOutlet.layer.cornerRadius = 5
            case .touchID:
                self.loginOutlet.setImage(UIImage(named: "icons8-touch-id-48"), for: .normal)
                self.loginOutlet.layer.cornerRadius = 5
            case .faceID:
                self.loginOutlet.setImage(UIImage(named: "icons8-face-id-64"), for: .normal)
                self.loginOutlet.layer.cornerRadius = 5
            @unknown default:
                print("error")
            }
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "You need to be authenticate") {succes,error in
            if succes {
                self.performSegue(withIdentifier: "tabelView", sender: "Foo")
            }
        }
    }

}

