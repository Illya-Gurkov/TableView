import UIKit


enum Actions: String, CaseIterable /* CaseIterable позволяет из перечисления сделать массив */ {
    case downloadImage = "Download Image"
    case users = "Users"
}

class ActionsCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "ActionCell"
    
    // Создаем массив наших actions
    private let actions = Actions.allCases
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCollectionViewCell
        cell.label.text = actions[indexPath.row].rawValue // rawValue преобразует в String формат
        return cell
    }

    // метод отлавливающий нажатие на ячейку
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "goToShowImage", sender: nil)
        case .users:
            performSegue(withIdentifier: "goToShowUser", sender: nil)
        }
    }
}


// метод возврвщает размер ячейки для CollectionView
extension ActionsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20
        return CGSize(width: (width), height: width / 2)
    }
}
