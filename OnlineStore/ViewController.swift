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
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    //MARK: - let/var
    
    var allProducts: [ProductModel] = []
    var products: [ProductModel] = []
    var categories: Categories = []
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProducts()
        getCategories()
        adjustUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchTextField.delegate = self
        searchTextField.delegate = self
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    //MARK: - IBActions
    
    @IBAction func searchTapped(_ sender: UIButton) {
        if let text = searchTextField.text {
            filter(by: text)
        }
    }
    
    @IBAction func menuTapped(_ sender: UIButton) {
        widthConstraint.constant = self.view.frame.width / 2
        self.blurView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.menuView.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func cartTapped(_ sender: UIButton) {
        print(products.count)
    }
    @IBAction func closeMenuTapped(_ sender: UIButton) {
        self.blurView.isHidden = true
        self.widthConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.menuView.isHidden = true
        }
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - func
    
    func adjustUI() {
        cartButton.layer.cornerRadius = cartButton.frame.width / 2
        blurView.isHidden = true
        widthConstraint.constant = 0
        menuView.isHidden = true
    }
    
    func getProducts() {
        Manager.shared.fetchAllProducts { [weak self] productsArray in
            self?.allProducts = productsArray
            self?.products = productsArray
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func getCategories() {
        Manager.shared.fetchCategories { [weak self] categoriesArray in
            self?.categories = categoriesArray
            DispatchQueue.main.async {
                self?.categoriesTableView.reloadData()
            }
        }
    }
    
    func filter(by text: String) {
        if searchTextField.text != "" {
            products = allProducts.filter { product in
                product.title.contains(text)
            }
            collectionView.reloadData()
        } else {
            products = allProducts
            collectionView.reloadData()
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
        cell.layer.cornerRadius = 10
        
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

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] _ in
            if let text = textField.text {
                self?.filter(by: text)
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.categoriesLabel.text = categories[indexPath.row]
        
        return cell
    }
    
}
