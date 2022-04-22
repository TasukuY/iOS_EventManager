//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDatesLabel: UILabel!
    @IBOutlet weak var attendanceButton: UIButton!
    
    
    //MARK: - IBActions
    @IBAction func attendanceButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Methods
    func updateViews(with event: Event){
        eventTitleLabel.text = event.title
        eventDatesLabel.text = event.date?.toString()
        if event.attending {
            attendanceButton.setImage(UIImage(systemName: Strings.attendImage), for: .normal)
        }else{
            attendanceButton.setImage(UIImage(systemName: Strings.absentImage), for: .normal)
        }
    }

}//End of class
