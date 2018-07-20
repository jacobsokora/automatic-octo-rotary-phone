//
//  ViewController.swift
//  FieldObservations
//
//  Created by Jacob Sokora on 3/20/18.
//  Copyright © 2018 Jacob Sokora. All rights reserved.
//

import UIKit

class ObservationsViewController: UIViewController {

    @IBOutlet weak var observationsTable: UITableView!
    
    var observations = ObservationLoader.load(fileName: "field_observations")
    let dateFormat = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        observationsTable.dataSource = self
        observationsTable.delegate = self
        
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ObservationViewController,
            let row = observationsTable.indexPathForSelectedRow?.row {
            destination.observation = observations[row]
        }
    }
}

extension ObservationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "observationCell", for: indexPath)
        if let cell = cell as? ObservationTableViewCell {
            let observation = observations[indexPath.row]
            cell.classificationImageView?.image = observation.classification.image
            cell.titleLabel?.text = observation.title
            cell.dateLabel?.text = dateFormat.string(from: observation.date)
        }
        return cell
    }
}

extension ObservationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
