//
//  DetailCommentsViewController.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit

class DetailCommentsViewController: UIViewController {

    var comments: Comment?
    var user: User?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func mapAction() {
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapsVC") as! MapsVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        title = comments?.email
        name.text = comments?.name
        email.text = comments?.email
        comment.text = comments?.body
    }

}
