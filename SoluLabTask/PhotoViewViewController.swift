//
//  PhotoViewViewController.swift
//  SoluLabTask
//
//  Created by pampana ajay on 28/10/21.
//

import UIKit
import SDWebImage

class PhotoViewViewController: UIViewController {

   
    @IBOutlet weak var colletionView:UICollectionView!
    
    var imageUrl = ""
    var arrayOfImages:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    
    }
    
    func setupUI(){
        
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.register(UINib(nibName: "PopUpCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopUpCollectionViewCell")
    }
    

    @IBAction func cancelTapped(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}

extension PhotoViewViewController:UICollectionViewDelegate{
    
    
}

extension PhotoViewViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopUpCollectionViewCell", for: indexPath) as? PopUpCollectionViewCell{
            
            cell.imagePopUp.sd_setImage(with: URL(string: arrayOfImages[indexPath.item]), completed: nil)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension PhotoViewViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: collectionView.frame.height)
    }
}
