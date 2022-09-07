//
//  UserDetailViewController.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit

class UserDetailViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var webSite: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var suite: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        name.text = user?.name
        userName.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        webSite.text = user?.website
        street.text = user?.address?.street
        suite.text = user?.address?.suite
        city.text = user?.address?.city
        zipCode.text = user?.address?.zipcode
        latitude.text = user?.address?.geo?.lat
        longitude.text = user?.address?.geo?.lng
    }

    @IBAction func postsButton() {
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTableViewController") as! PostsTableViewController
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albumsButton() {
        let storyboard = UIStoryboard(name: "AlbomsAndPhotos", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbomsTVC") as! AlbomsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func location() {let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapsVC") as! MapsVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func toDoButton() {
        
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
