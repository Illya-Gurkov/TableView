//
//  DetailCommentsViewController.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit

class DetailCommentsViewController: UIViewController {

    var comments: Comment?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI() {
        title = comments?.email
        name.text = comments?.name
        email.text = comments?.email
        comment.text = comments?.body
    }
}
