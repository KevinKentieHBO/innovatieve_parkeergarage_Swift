//
//  ViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor het aansturen van de homepagina
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //laten zien tarieven
        getTestAllTarieven { (array) in
            print(array)
        }
    }
}
