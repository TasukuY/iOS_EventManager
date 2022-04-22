//
//  EventListTableViewController.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.shared.fetchEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellIdentifier, for: indexPath) as? EventTableViewCell
        else { return UITableViewCell() }
        cell.indexPath = indexPath
        cell.delegate = self
        let eventToDisplay = EventController.shared.events[indexPath.row]
        cell.updateViews(with: eventToDisplay)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.delete(eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == Strings.toDetailsView {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailsViewController
            else { return }
            let eventToSend = EventController.shared.events[indexPath.row]
            destination.event = eventToSend
        }
    }

}//End of class

extension EventListTableViewController: EventCellDelegate{
    func attendanceButtonTapped(sender: EventTableViewCell) {
        guard let indexPath = sender.indexPath else { return }
        let event = EventController.shared.events[indexPath.row]
        EventController.shared.toggleAttendanceState(of: event)
        sender.updateViews(with: event)
    }
    
}//End of extension
