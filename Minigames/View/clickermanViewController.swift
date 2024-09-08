//
//  clickermanViewController.swift
//  Minigames
//
//  Created by Ерош Айтжанов on 09.09.2024.
//

import UIKit
import CoreData

class clickermanViewController: UIViewController {
    var counter = 0
    var record: Int = 0
    
    let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.text = "Рекорд: 0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5:00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 33, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("  Заново  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    func setupUI() {
        mainButton.addTarget(self, action: #selector(mainButtonTapped(_:)), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        
        
        view.addSubview(recordLabel)
        view.addSubview(mainButton)
        view.addSubview(timeLabel)
        view.addSubview(restartButton)
    
        NSLayoutConstraint.activate([
            // Layout the main stack view
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            mainButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            // Layout the order label
            recordLabel.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 20),
            recordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            // Layout the win label
            timeLabel.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -20),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            restartButton.bottomAnchor.constraint(equalTo: recordLabel.bottomAnchor, constant: 40),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadRecord()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    @objc func mainButtonTapped(_ sender: UIButton) {
        if counter == 0 {
            startMillisecondCountdown()
        }
        counter += 1
        mainButton.setTitle(String(counter), for: .normal)
    }
    
    @objc func restartButtonTapped(_ sender: UIButton) {
        counter = 0
        countdown = 5.00
        mainButton.setTitle("0", for: .normal)
        mainButton.isEnabled = true
    }
    
    var countdown = 5.00
    var timer: Timer?

    func startMillisecondCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if self.countdown > 0 {
                self.timeLabel.text = String(format: "%.2f", self.countdown)
                self.countdown -= 0.01
            } else {
                timer.invalidate()
                self.mainButton.isEnabled = false
                if self.record < self.counter {
                    self.record = self.counter
                    self.recordLabel.text = "Рекорд: " + String(self.counter)
                    self.saveRecord(record: self.counter)
                }
                // Stop the timer when it reaches 0
            }
        }
        
    }
    
    func saveRecord(record: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistantContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Clickerman", in: context) else {return}
        let info = NSManagedObject(entity: entity, insertInto: context)
        info.setValue(Int32(record), forKey: "record")

        do {
            try context.save()
        }
        catch {
            print("error save to CoreData")
        }
    }
    
    func loadRecord() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate cast failed")
            return
        }
        let context = appDelegate.persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Clickerman")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let result = results.first as? NSManagedObject {
                if let loadedRecord = result.value(forKey: "record") as? Int {
                    record = loadedRecord
                    recordLabel.text = "Рекорд: " + String(record)
                } else {
                    print("Record value is not of type Int")
                }
            } else {
                print("No records found")
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
