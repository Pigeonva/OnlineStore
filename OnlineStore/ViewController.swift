//
//  ViewController.swift
//  OnlineStore
//
//  Created by Артур Фомин on 23.10.2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var cartButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - let/var
    
    var products: [ProductModel] = []
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartButton.layer.cornerRadius = cartButton.frame.width / 2
        getProducts()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       
    }
    
    //MARK: - IBActions
    
    @IBAction func searchTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func menuTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func cartTapped(_ sender: UIButton) {
        print(products.count)
    }
    
    //MARK: - func
    
    func getProducts() {
        Manager.shared.fetchAllProducts { [weak self] prosucts in
            self?.products = prosucts
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: - extensions

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        let url = URL(string: products[indexPath.row].image)
        cell.imageView.sd_setImage(with: url, completed: nil)
        cell.label.text = String("\(products[indexPath.row].price) $")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spase = (collectionView.frame.size.width - 15)/2
        
        return CGSize(width: spase, height: spase)
    }
}
