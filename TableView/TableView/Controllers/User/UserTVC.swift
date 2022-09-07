//
//  UserTVC.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit

class UserTVC: UITableViewController {

    var user: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        user.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = user[indexPath.row].name
        cell.detailTextLabel?.text = user[indexPath.row].username

        return cell
    }

    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = user[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

    // метод преобразующий стринговый URL адрес в URL
    private func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.user = try JSONDecoder().decode([User].self, from: data) // декодируем данные из формата Data в модель (User)
            } catch {
                print (error)
            }
            // отправляем данные в главный поток
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } .resume()
    }

}

