//
//  NotDetayViewController.swift
//  NotUygulamasiTasarim
//
//  Created by Emirhan Cankurt on 21.01.2023.
//

import UIKit

class NotDetayViewController: UIViewController {
    
    
    @IBOutlet weak var textfieldDersAdi: UITextField!
    @IBOutlet weak var textfieldNot1: UITextField!
    @IBOutlet weak var textfieldNot2: UITextField!
    
    var selectedTextField : Notlar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldDersAdi.text = selectedTextField!.ders_adi
        textfieldNot1.text = selectedTextField!.not1
        textfieldNot2.text = selectedTextField!.not2
    }
    
    
    @IBAction func notGuncelle(_ sender: Any) {
        
        if let n = selectedTextField , let ad = textfieldDersAdi.text , let no1 = textfieldNot1.text , let no2 = textfieldNot2.text{
            if let nid = Int(n.not_id!) , let n1 = Int(no1) ,let n2 = Int(no2) {
                notGuncelle(not_id: nid, ders_adi: ad, not1: n1, not2: n2)
            }
            
        }
    }
    
    
    
    func notGuncelle(not_id:Int,ders_adi:String,not1:Int,not2:Int) {
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/update_not.php")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)&ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    print(json)
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    
    
    
    @IBAction func notSil(_ sender: Any) {
        notSil(not_id: selectedTextField!.not_id!)
        
    }
    
    
    
    func notSil(not_id:String){
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/delete_not.php")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    print(json)
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
