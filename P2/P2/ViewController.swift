//
//  ViewController.swift
//  P2
//
//  Created by Zahraa Herz on 31/03/2022.
//

import UIKit
import Alamofire
import _Concurrency

class ViewController: UIViewController {
 
    

  var users: [Users] = []
    var Ausers = [User]()
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchUsers { data in
            self.Ausers = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
       

    }
    
    func fetchUsers(completion: @escaping ([User])-> () )
    {
    
        
            AF.request("https://reqres.in/api/users?page=2", method: .get).response {
                response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Users.self, from: data)
                    completion(userData.data!)

                } catch let error {
                    print(error)
                }
            }
    
        }
    
   
}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Ausers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  Ausers[indexPath.row].first_name! + " " +  Ausers[indexPath.row].last_name!
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DeatailesViewController") as! DeatailesViewController
        let url = URL(string: Ausers[indexPath.row].avatar!)!
        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            vc.image = UIImage(data: data)!
        }
        //vc.image = AsyncImage(url: URL(string: Ausers[indexPath.row].avatar!))//Ausers[indexPath.row].avatar!
        vc.email = Ausers[indexPath.row].email!
        vc.FN = Ausers[indexPath.row].first_name!
        vc.lN = Ausers[indexPath.row].last_name!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


