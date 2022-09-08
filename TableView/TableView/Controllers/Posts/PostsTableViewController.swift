//
//  PostsTableViewController.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit

class PostsTableViewController: UITableViewController {
    var user: User?
    var posts: [Post] = []
    var comment: [Comment] = []

    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath)
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }

    // MARK: Func's

    private func fetchPosts() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data) //
            } catch {
                print(self.posts)
            }
            // отправляем данные в главный поток
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newPostVC = segue.destination as? NewPostVC {
            newPostVC.user = user
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let posts = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailPostsViewController") as! DetailPostsViewController
        vc.posts = posts
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let id = posts[indexPath.row].id {
            NetworkService.deletePost(postID: id) { [weak self] json, error in
                if json != nil {
                    self?.posts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }
}
