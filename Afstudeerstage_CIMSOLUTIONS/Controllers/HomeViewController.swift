//
//  ViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor het aansturen van de homepagina
class HomeViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate {
   
    
//Interface Items
    //Connectie met de TableView uit de storyboard
    @IBOutlet weak var HomeReserveringenTabel: UITableView!
    @IBOutlet weak var HomeVerlopenReserveringenTabel: UITableView!
    @IBOutlet weak var NaamLabel: UILabel!
    
    
//Variabelen
    //lege lijst met reserveringen
    private var dataAankomend: [InfoReservering] = []
    private var dataVerlopen: [InfoReservering] = []

    
    
//Functies
    override func viewDidLoad() {
        //leeg maken van de lijsten
        self.dataAankomend = []
        self.dataVerlopen = []
        
        //zet de styling binnen een cel
        let nib = UINib(nibName: "MijnReserveringenTableViewCell", bundle: nil)
        HomeReserveringenTabel.register(nib, forCellReuseIdentifier: "MijnReserveringenTableViewCell")
        HomeVerlopenReserveringenTabel.register(nib, forCellReuseIdentifier: "MijnReserveringenTableViewCell")
        self.HomeReserveringenTabel.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.HomeVerlopenReserveringenTabel.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        super.viewDidLoad()
        
        //Zet de tabel in de interface
        HomeReserveringenTabel.delegate = self
        HomeReserveringenTabel.dataSource = self
        HomeVerlopenReserveringenTabel.dataSource = self
        
        //Stemt de tab bar af
        tabBarController?.delegate = self
        HomeReserveringenTabel.reloadData()
        HomeVerlopenReserveringenTabel.reloadData()
        
        //Zet de naam van de gebruiker op de homepagina
        NaamLabel.text = UserDefaults.standard.string(forKey: "Bestuurder_Naam")
    }
    
    //Zorgt ervoor dat bij het tab parkeren altijd naar de root wordt genavigeert.
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            // im my example the desired view controller is the second one
            // it might be different in your case...
            let secondVC = tabBarController.viewControllers?[1] as! UINavigationController
            secondVC.popToRootViewController(animated: false)
            let thirdVC = tabBarController.viewControllers?[2] as! UINavigationController
            thirdVC.popToRootViewController(animated: false)
        }
    
    //Herlaad de pagina wanneer de er genavigeerd wordt naar de pagina
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            //Haal de reserveringen van de gebruiker op en zet deze in de lijst
            getReserveringenVanGebruiker { (array) in
                DispatchQueue.main.async {
                    for reservering in array{
                        
                        //Als de huidige datum onder de datum van de begintijd zit, voeg de reservering aan dataAankomend toe
                        if(self.checkReserveringVoorbij(begintijd: reservering.reservering_Begintijd, datum: reservering.reservering_Datum)){
                            self.dataAankomend.append(reservering)
                        }else{
                            //Anders voeg reservering aan dataVerlopen toe
                            self.dataVerlopen.append(reservering)
                        }
                    }
                    self.HomeVerlopenReserveringenTabel.allowsSelection = false;
                    self.HomeReserveringenTabel.reloadData()
                    self.HomeVerlopenReserveringenTabel.reloadData();
                }
            }
            self.viewDidLoad()
        }
    }
    
    //check of de reservering al is verlopem
    func checkReserveringVoorbij(begintijd: String, datum: String) -> Bool{
        //formatter initializeren
        let formatterTijd = DateFormatter()
        let formatterDatum = DateFormatter()
        formatterTijd.dateFormat = "HH:mm"
        formatterDatum.dateFormat = "dd-MM-yyyy"
        formatterTijd.locale = NSLocale(localeIdentifier: "nl") as Locale
        formatterDatum.locale = NSLocale(localeIdentifier: "nl") as Locale
        
        //in en uitrij tijd constateren van de parkeergarage
        let begintijd = formatterTijd.date(from: begintijd)
        let datum = formatterDatum.date(from: datum)
        
        //omzetten gekozen tijd naar Calendar
        let componentsHuidigeDateTimeCalendar = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day, .month], from: Date())
        let begintijdCalendar = Calendar.current.dateComponents([.hour, .minute], from: begintijd!)
        let datumCalendar = Calendar.current.dateComponents([.year, .day, .month], from: datum!)
        
        if((datumCalendar.year! <= componentsHuidigeDateTimeCalendar.year! && datumCalendar.month! <= componentsHuidigeDateTimeCalendar.month! && datumCalendar.day! < componentsHuidigeDateTimeCalendar.day!) || (datumCalendar.year! == componentsHuidigeDateTimeCalendar.year! && datumCalendar.month! == componentsHuidigeDateTimeCalendar.month! && datumCalendar.day! == componentsHuidigeDateTimeCalendar.day! && begintijdCalendar.hour! <= componentsHuidigeDateTimeCalendar.hour! && begintijdCalendar.minute! <= componentsHuidigeDateTimeCalendar.minute!)){
            return false
        }else{
            return true
        }
    }
    
}


//Extenties
//Zet de tabel in de storyboard
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let reservering = dataAankomend[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "infoReserverenVCIdentifier") as! InfoReserveringViewController
        newVC.gekozenReservering = reservering
        self.show(newVC, sender: self)
    }
}

//dataAankomend in de cellen zetten
extension HomeViewController: UITableViewDataSource{
    //toon x aantal cellen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == HomeReserveringenTabel{
            return dataAankomend.count
        }else{
            return dataVerlopen.count
        }
    }
    
    //zet de dataAankomend in de cellen.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == HomeReserveringenTabel{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MijnReserveringenTableViewCell",
                                                     for: indexPath) as! MijnReserveringenTableViewCell
            cell.CellDatum.text = dataAankomend[indexPath.row].reservering_Datum
            cell.CellTijd.text = "\(dataAankomend[indexPath.row].reservering_Begintijd) - \(dataAankomend[indexPath.row].reservering_Eindtijd)"
            cell.CellParkeergarage.text = dataAankomend[indexPath.row].reservering_Parkeergarage
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MijnReserveringenTableViewCell",
                                                     for: indexPath) as! MijnReserveringenTableViewCell
            cell.CellDatum.text = dataVerlopen[indexPath.row].reservering_Datum
            cell.CellTijd.text = "\(dataVerlopen[indexPath.row].reservering_Begintijd) - \(dataVerlopen[indexPath.row].reservering_Eindtijd)"
            cell.CellParkeergarage.text = dataVerlopen[indexPath.row].reservering_Parkeergarage
            return cell
        }
    }
}

