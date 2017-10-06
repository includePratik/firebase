
//
//  loginController.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 8/21/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//
import Firebase
import UIKit

protocol  resetNavBar {
    func resetNavigationTitleView(str: String)
}

class loginController: UIViewController {
    
    var usr,eml,pas: UITextField!
    let items = ["Login","Registration"]
    var segmentedControl: UISegmentedControl!
    let inputContainsView = UIView()
    var buttonIni: Int = 0
    var nameTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTFSeprator = UIView()
    var passwordTFSeprator = UIView()
    var emailTFSeprator = UIView()
    var emailTextField: UITextField!
    var firstInitialize: Bool = true
    var profileImage: UIImage!
    var imageView = UIImageView()
    var heightConstraint = NSLayoutConstraint()
     var delegate:resetNavBar? = nil
    
   
    
    
    
    
    
    var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        initializer()
        
        
        view.backgroundColor = UIColor(r: 51, g: 91, b: 151)
        
        
        
    }
    
    
    func addSegmentedControl() {
        
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.layer.cornerRadius = 8
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        view.addSubview(segmentedControl)
        segmentedControlAnchor()
    }
    
    func segmentedControlAnchor() {
        segmentedControl.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        
        segmentedControl.bottomAnchor.constraint(lessThanOrEqualTo: inputContainsView.topAnchor, constant: -20).isActive = true
    }
    
    func buttonInitializer(){
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = UIColor(r: 61, g: 101, b: 171)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        button.topAnchor.constraint(greaterThanOrEqualTo: inputContainsView.bottomAnchor, constant: 10).isActive = true
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 40))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.inputContainsView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        
        
    }
    
    func initializer(){
        
        
        inputContainsView.backgroundColor = UIColor.white
        inputContainsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputContainsView)
        inputContainsView.layer.cornerRadius = 5
        inputContainsView.layer.masksToBounds = true
        
        self.view.addConstraint(NSLayoutConstraint(item: inputContainsView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 1.0))
        
        self.view.addConstraint(NSLayoutConstraint(item: inputContainsView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 1.0))
        
        self.view.addConstraint(NSLayoutConstraint(item: inputContainsView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 0.9, constant: 1.0))
        
        
        
        
        heightConstraint = (NSLayoutConstraint(item: inputContainsView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.height, multiplier: 0.141, constant: 0.0))
        self.view.addConstraint(heightConstraint)
        
        nameTextField = UITextField(frame: CGRect(x: 12, y: 12, width: 500, height: 22))
        nameTextField.placeholder = "Email Address"
        
        nameTFSeprator = UIView(frame: CGRect(x: 0, y: 42, width: 500, height: 2))
        nameTFSeprator.backgroundColor = UIColor.gray
        
        
        passwordTextField = UITextField(frame: CGRect(x: 12, y: 52, width: 300, height: 22))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        
        passwordTFSeprator = UIView(frame: CGRect(x: 0, y: 82, width: 500, height: 2))
        passwordTFSeprator.backgroundColor = UIColor.gray
        
        
        emailTextField = UITextField(frame: CGRect(x: 12, y: 92, width: 300, height: 22))
        emailTextField.placeholder = "Email Address"
        emailTextField.isHidden = true
        
        emailTFSeprator = UIView(frame: CGRect(x: 0, y: 122, width: 500, height: 2))
        emailTFSeprator.backgroundColor = UIColor.gray
        emailTextField.isHidden = true
        
        
        
        inputContainsView.addSubview(nameTextField)
        inputContainsView.addSubview(nameTFSeprator)
        inputContainsView.addSubview(passwordTextField)
        inputContainsView.addSubview(passwordTFSeprator)
        inputContainsView.addSubview(emailTFSeprator)
        inputContainsView.addSubview(emailTextField)
        
        
        addSegmentedControl()
        
        buttonInitializer()
        button.setTitle("Login", for: .normal)
        button.setNeedsDisplay()
        
        self.hideKeyboardWhenTappedAround()
        addPorfilePicture()
        
    }
    
    
    
    func addPorfilePicture(){
        
        profileImage = UIImage(named: "chatImage")
        
        imageView = UIImageView(image: profileImage)
        imageView .translatesAutoresizingMaskIntoConstraints = false // This line enables Auto Layout
        
        self.view.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 30))
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.lessThanOrEqual, toItem: self.segmentedControl, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -20))
        
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTouchHandler(_:)))
        imageView.addGestureRecognizer(tabGesture)
        
        imageView.isUserInteractionEnabled = true
        
        
    }
    func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            

            emailTextField.isHidden = false
            emailTFSeprator.isHidden = false
            //inputContainsViewHeightAdjust()
            segmentedControl.selectedSegmentIndex = 0
            button.setTitle("Login", for: .normal)
            button.setNeedsDisplay()
            nameTextField.placeholder = "Email Address"
            eml = nameTextField
            pas = passwordTextField
            
            heightConstraint.constant = 0
            
            
        }
        if segment.selectedSegmentIndex == 1 {
            

            
            
            heightConstraint.constant = 46
            
            
            self.view.updateConstraints()
            
            
            nameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
            
            nameTextField.placeholder = "Name"
            emailTextField.isHidden = false
            emailTFSeprator.isHidden = false
            
            
            usr = nameTextField
            pas = passwordTextField
            eml = emailTextField
            
            button.setTitle("Registration", for: .normal)
            button.setNeedsDisplay()
            
            segmentedControl.selectedSegmentIndex = 1
            
        }
    }
    
    func Dissmiss(){

        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func buttonAction(sender: UIButton!) {
        

        if segmentedControl.selectedSegmentIndex == 1 {
            guard let email = emailTextField.text, let pwd = passwordTextField.text, let user = nameTextField.text else {

                let errorMessage = UIAlertController(title: "Error", message: "Please enter value for all fields", preferredStyle: .alert)
                errorMessage.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(errorMessage,animated: true, completion: nil)
                
                return
            }
            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (firusers: FIRUser?, Error) in
                if Error != nil {
                    print(Error.debugDescription)
                   // print("in error")
                    let errorMessage = UIAlertController(title: "Error", message: Error?.localizedDescription, preferredStyle: .alert)
                    errorMessage.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(errorMessage,animated: true, completion: nil)
                    
                    return
                }
                guard let uid = firusers?.uid else{
                    return
                }
                
                let imageString = NSUUID().uuidString
                let storageRef = FIRStorage.storage().reference().child("profile_image").child("\(imageString).jpg")
            
                
                if let image = self.imageView.image {
                    let newresizedImage = UIImage().resizeImage(image: image, targetSize: CGSize(width: 60, height: 60))
                    let uploaddata =  UIImagePNGRepresentation(newresizedImage)//UIImageJPEGRepresentation(newresizedImage,0.0)
                    storageRef.put(uploaddata! , metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                         //   print(error as Any)
                            return
                        }
                        // print(metadata)
                        if let downloadURL = metadata?.downloadURL()?.absoluteString {
                            let value = ["name": user,"email": email,"profileImage": downloadURL ]
                            self.registerUserwithUID(uid: uid, values: (value as AnyObject) as! [String : AnyObject])
                        }
                    })
                }
            })
        }else{
            
           
            guard var email = nameTextField.text, let pwd = passwordTextField.text else {
              //  print("NOT VALID")
                return
            }
            email = email.trimmingCharacters(in: .whitespaces)
            email = email.appending("@gmail.com")
            email = email.trimmingCharacters(in: .whitespaces)
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (_firuser: FIRUser?, Error) in
              //  print("inAuth")
                if Error != nil {
                   // print(Error as Any)
                    let alertMessage = UIAlertController(title: "Error", message: Error?.localizedDescription, preferredStyle: .alert)
                    alertMessage.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertMessage, animated: true, completion: nil)
                    return
                }
                let objectViewController = ViewController()
               //  objectViewController.setNavigationTitleViewDetails()
                
                    self.delegate?.resetNavigationTitleView(str: "send")
        
            
                self.dismiss(animated: true, completion: nil)
            })
            
        }
        
    }
    
    
    
    private func registerUserwithUID(uid: String, values: [String:AnyObject] ){
        let ref = FIRDatabase.database().reference(fromURL: "https://mytry-cc118.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values)
        
        
        
        let successMessage = UIAlertController(title: "Success", message: "User is added", preferredStyle: .alert)
        successMessage.addAction(UIAlertAction(title: "ok,", style: UIAlertActionStyle.default, handler: nil))
        self.present(successMessage, animated: true, completion: nil)
        
        
    }
    
}
extension UIColor{
    convenience init(r: CGFloat, g: CGFloat,b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
}

