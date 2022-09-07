//
//  CommentsTableViewController.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    var user: User?
    var posts: Post?
    var comment: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCommentw()
        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        comment.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comments = comment[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath)
        cell.textLabel?.text = comments.name
        cell.detailTextLabel?.text = comments.body
    
        return cell
    }
    
    
    // MARK: Func's
    
    private func fetchCommentw() {
        guard let postId = posts?.id else { return }
        let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postId)"
        
        guard let url = URL(string: pathUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.comment = try JSONDecoder().decode([Comment].self, from: data) //
            } catch {
                print (self.comment)
            }
            // отправляем данные в главный поток
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } .resume()
    }

     // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comments = comment[indexPath.row]
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailCommentsViewController") as! DetailCommentsViewController
        vc.comments = comments
        navigationController?.pushViewController(vc, animated: true)
    }
}
