//
//  PhotoGridViewController.swift
//  SoluLabTask
//
//  Created by pampana ajay on 28/10/21.
//

import UIKit
import Alamofire
import SDWebImage

class PhotoGridViewController: UIViewController {

    @IBOutlet weak var collectionView:UICollectionView!
    
    var photoArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDataApi()
    }
    
    func setupUI(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGridCollectionViewCell")
    }


}

extension PhotoGridViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoViewViewController") as? PhotoViewViewController{
            
            vc.imageUrl = photoArray[indexPath.row]
            vc.arrayOfImages = photoArray
            
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

extension PhotoGridViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCollectionViewCell", for: indexPath) as? PhotoGridCollectionViewCell{
            cell.photoImageRef.sd_setImage(with: URL(string: photoArray[indexPath.row]), placeholderImage: UIImage(systemName: "photo"), options: .allowInvalidSSLCertificates, completed: nil)
            
        
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}


extension PhotoGridViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/3-2, height: screenWidth/3-2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


extension PhotoGridViewController{
    
    func getDataApi(){
        
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=42") else {return}
        
        let request = AF.request(url)
        request.responseJSON { response in
            
            if let error = response.error {
                print(error.errorDescription)
            }
            else{
                if let data = response.value as? [Any]{
                    print(data.count)
                    
                    for photo in 0...data.count-1{
                        if let dataa = data[photo] as? [String:Any]{
                          
                            
                            if let image = dataa["url"] as? String{
                                self.photoArray.append(image)
                                self.collectionView.reloadData()
                            }
                        }
                        
                    }
                    if let dataa = data[0] as? [String:Any]{
                   print(dataa)
                    }
                    }

                    }
                    
                }
            }
            
}
  
