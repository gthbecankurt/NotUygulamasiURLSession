//
//  ViewController.swift
//  NotUygulamasiTasarim
//
//  Created by Emirhan Cankurt on 21.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var notlarListe = [Notlar]()
    
    @IBOutlet weak var notTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        notTableView.delegate = self
        notTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tumNotlarıAl()
    }
    
    func tumNotlarıAl(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/notlar/tum_notlar.php")!
        
        URLSession.shared.dataTask(with: url) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do {
                let cevap = try JSONDecoder().decode(NotCevap.self, from: data!)
                if let gelenNotlistesi = cevap.notlar {
                    
                    self.notlarListe = gelenNotlistesi
                    
                }
                
                DispatchQueue.main.async {
                    self.notTableView.reloadData()
                }
                
                
                
            }catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
        
    }
    
    
    
    
}


extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notlarListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre", for: indexPath) as! NotHucreTableViewCell
        
        cell.labelDersAdi.text = not.ders_adi
        cell.labelNot1.text = String(not.not1!)
        cell.labelNot2.text = String(not.not2!)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toNotDetay", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNotDetay"{
            if let indeks = sender as? Int{
                let gidilecekVC = segue.destination as! NotDetayViewController
                gidilecekVC.selectedTextField = notlarListe[indeks]
            }
        }
    }
    
}


