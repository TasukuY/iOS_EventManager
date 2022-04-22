//
//  EventDetailsViewController.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewTitleLabel: UILabel!
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    //MARK: - Properties
    var event: Event?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        eventTitleTextField.delegate = self
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    
        guard let title = eventTitleTextField.text,
              !title.isEmpty
        else { return }
        
        let date = eventDatePicker.date
        
        if let event = event {
            EventController.shared.update(event, with: title, and: date)
        }else {
            EventController.shared.createNewEvent(with: title, and: date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func updateView(){
        if let event = event {
            guard let eventDate = event.date else { return }
            viewTitleLabel.text = "Event Details"
            eventTitleTextField.text = event.title
            eventDatePicker.date = eventDate
        }else {
            viewTitleLabel.text = "Create New Event"
        }
    }
    
}//End of class

extension EventDetailsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }
    
}//End of extension
