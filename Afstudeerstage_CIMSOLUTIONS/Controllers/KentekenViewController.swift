//
//  KentekenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 15/04/2021.
//

import UIKit

class KentekenViewController: UIViewController {

//Interface Items
    //Initializeren van de verschillende interface attributen
    @IBOutlet weak var kentekenLijst: UITableView!
    
//Variabelen
    //lege lijst met Abonnementen van de gebruiker
    private var data: [Auto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //zet de styling binnen een cel
        let nib = UINib(nibName: "KentekenTableViewCell", bundle: nil)
        kentekenLijst.register(nib, forCellReuseIdentifier: "KentekenTableViewCell")
        self.kentekenLijst.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Toevoegen van de + aan de rechter kant
        let newAddButton = UIBarButtonItem(title: "+", style: UIBarButtonItem.Style.plain, target: self, action: #selector(KentekenViewController.addKenteken(_:)))
        self.navigationItem.rightBarButtonItem = newAddButton
        
        kentekenLijst.delegate = self
        kentekenLijst.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Haal de autos van de gebruiker op en zet deze in de lijst
        getAutos{(autoLijst) in
            DispatchQueue.main.async {
                self.data = autoLijst
                self.kentekenLijst.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if data[indexPath.row].Auto_Id == UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id"){
                createAlert(title: "Error", message: "Kenteken kan niet verwijderd worden wanneer deze actief is.")
            }else{
                verwijderAuto(autoid: data[indexPath.row].Auto_Id){(auto) in
                    DispatchQueue.main.async {
                        self.createAlert(title: "Auto verwijderen", message: auto.resultaat)
                    }
                }
            }
        }
    }
    
    //Aanmaken van een alert om de error te tonen aan de gebruiker
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            self.viewWillAppear(true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //verwijst naar het de kentekenview
    func verwijsScherm(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addKenteken(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let kentekenToevoegenController = storyBoard.instantiateViewController(withIdentifier: "kentekenToevoegenId") as! KentekenToevoegenViewController
        kentekenToevoegenController.modalPresentationStyle = .overCurrentContext
        kentekenToevoegenController.modalTransitionStyle = .crossDissolve
        self.show(kentekenToevoegenController, sender: self)
    }
}

extension KentekenViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let auto = data[indexPath.row]
        UserDefaults.standard.set(auto.Auto_Id, forKey: "Actief_Kenteken_Id")
        tableView.deselectRow(at: indexPath, animated: true)
        self.kentekenLijst.reloadData()
    }
}

extension KentekenViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KentekenTableViewCell", for: indexPath) as! KentekenTableViewCell
        cell.kentekenLabel.text = data[indexPath.row].Auto_Kenteken
        if data[indexPath.row].Auto_Id == UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id"){
            cell.actiefLabel.text = "Actief"
        }else{
            cell.actiefLabel.text = ""
        }
        return cell;
    }
}
