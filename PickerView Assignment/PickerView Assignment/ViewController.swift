//
//  ViewController.swift
//  PickerView Assignment
//
//  Created by Sagar Thummar on 15/06/19.
//  Copyright © 2019 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

enum ContentType {
    case name
    case subject
    case setAllValues
}

class ViewController: UIViewController {

    @IBOutlet weak var nameSelectionLabel: UILabel!
    @IBOutlet weak var subjectSelectionLabel: UILabel!
    @IBOutlet weak var nameSelectionButton: UIButton!
    @IBOutlet weak var subjectSelectionButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dissmissSaveButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.dataSource = self
            pickerView.delegate = self
        }
    }

    var contentType: ContentType? {
        didSet {
            pickerView.reloadAllComponents()
            for (component, selectedRow) in selectedIndexes.enumerated() where selectedRow != nil {
                pickerView.selectRow(selectedRow!, inComponent: component, animated: true)
            }
            containerView.isHidden = false
            dissmissSaveButton.isHidden = false
        }
    }
    var selectedName: String? {
        didSet {
            nameSelectionLabel.text = selectedName
        }
    }
    var selectedSubject: String? {
        didSet {
            subjectSelectionLabel.text = selectedSubject
        }
    }

    var arrNames: [String] {
        return ["Dharmik", "Irshad Ali", "Kyati", "Kishan", "Milan", "Parth", "Shaheb", "Shidharth"]
    }
    var arrSubjects: [String] {
        return ["Maths", "C", "DMBS", "ERP", "Distributed System"]
    }

    var collections: [[String]] {
        guard contentType != nil else {
            return []
        }
        switch contentType! {
            case .name: return [arrNames]
            case .subject: return [arrSubjects]
            case .setAllValues: return [arrNames, arrSubjects]
        }
    }

    var selectedIndexes: [Int?] {
        guard contentType != nil else {
            return []
        }
        switch contentType! {
            case .name:
                let nameIndex = arrNames.firstIndex(where: { $0 == selectedName })
                return [nameIndex]
            case .subject:
                let subjectIndex = arrSubjects.firstIndex(where: { $0 == selectedSubject })
                return [subjectIndex]
            case .setAllValues:
                let nameIndex = arrNames.firstIndex(where: { $0 == selectedName })
                let subjectIndex = arrSubjects.firstIndex(where: { $0 == selectedSubject })
                return [(nameIndex), (subjectIndex)]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectedName = nil
        selectedSubject = nil
    }

}

//MARK: IBAction Methods
extension ViewController {

    @IBAction func nameSelectionButtonTapped(_ sender: UIButton) {
        contentType = .name
    }

    @IBAction func subjectSelectionButtonTapped(_ sender: UIButton) {
        contentType = .subject
    }

    @IBAction func resultButtonTapped(_ sender: UIButton) {
        contentType = .setAllValues
    }

    @IBAction func dismissSaveButtonTapped(_ sender: UIButton) {
        guard contentType != nil else {
            return
        }
        switch contentType! {
            case .name:
                let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
                selectedName = arrNames[selectedRowIndex]
            case .subject:
                let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
                selectedSubject = arrSubjects[selectedRowIndex]
            case .setAllValues:
                let selectedNameIndex = pickerView.selectedRow(inComponent: 0)
                let selectedSubjectIndex = pickerView.selectedRow(inComponent: 1)
                selectedName = arrNames[selectedNameIndex]
                selectedSubject = arrSubjects[selectedSubjectIndex]
        }
        containerView.isHidden = true
        dissmissSaveButton.isHidden = true
        contentType = nil
    }

    @IBAction func clearValuesButtonTapped(_ sender: UIButton) {
        selectedName = nil
        selectedSubject = nil
        containerView.isHidden = true
        dissmissSaveButton.isHidden = true
        contentType = nil
    }
}

//MARK: PickerView Delegate Methods
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return collections.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return collections[component].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return collections[component][row]
    }
}
