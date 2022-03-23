//
//  ViewController.swift
//  NasaDemo
//
//  Created by Admin on 22/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var labelTitle: UILabel?
    @IBOutlet var labelDescription: UITextView?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var textFieldDatePicker: UITextField?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    private var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setDatePicker()
    }
   
    //Set Date picket through textfield
    private func setDatePicker() {
        
        self.textFieldDatePicker?.rightViewMode = UITextField.ViewMode.always
        self.textFieldDatePicker?.datePicker(target: self,
                                     doneAction: #selector(doneAction),
                                     cancelAction: #selector(cancelAction),
                                     datePickerMode: .date)
        
        activityIndicator.color = UIColor.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
    
    //Call ViewModel to get Data
    private func getDataByDate(date:Date) {
        
        if Reachability.isConnectedToNetwork(){
            activityIndicator.startAnimating()
            homeViewModel.callApodApi(queryDate: date) {[weak self] (isSuccess,error) in
                if(isSuccess) {
                    self?.updateUIData()
                }else {
                    self?.showAlert(error: error)
                }
            }
        }else{
            showAlert(error: "Internet Connection not Available!")
        }
        
    }
    
    //DatePicker Done Action
    @objc private func doneAction() {
        if let datePickerView = self.textFieldDatePicker?.inputView as? UIDatePicker {
            
            DispatchQueue.main.async { [self] in
                self.textFieldDatePicker?.resignFirstResponder()
                self.activityIndicator.startAnimating()
                self.clearUIData()
            }
            //Call Selected Date APod
            getDataByDate(date: datePickerView.date)
        }
    }
    
    //DatePicker Cancel Action
    @objc private func cancelAction() {
        self.textFieldDatePicker?.resignFirstResponder()
    }
    
    //Clear UI Data before New API call
    private func clearUIData() {
        
        self.labelTitle?.text = ""
        self.labelDescription?.text = ""
        self.textFieldDatePicker?.text = ""
        self.imageView?.image = nil
    }
    
    //Update UI Data
    private func updateUIData() {
        
        DispatchQueue.main.async {
            self.labelTitle?.text = self.homeViewModel.title
            self.labelDescription?.text = self.homeViewModel.explanation
            self.textFieldDatePicker?.text = self.homeViewModel.date
            if (self.homeViewModel.media_type == Constants.MediaType.image) {
                self.imageView?.loadImage(withUrl: self.homeViewModel.url ?? "")
            }else {
                self.imageView?.image = UIImage(named: Constants.NoImage)
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    //Show Error Alert
   private func showAlert(error: String?) {
        
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: Constants.ErrorText, message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.OKText, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

}

