//
//  WordViewController.swift
//  baedal
//
//  Created by 박소진 on 2023/07/21.
//

import UIKit

class WordViewController: UIViewController {
    
    @IBOutlet var wordButtons: [UIButton]!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var xButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()
        
    }
    
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func xButtonTapped(_ sender: UIButton) {
        inputTextField.text = ""
    }
    
    //검색버튼, 키보드 엔터를 누르면 키보드가 내려가고 검색이 되는 것
    @IBAction func searchEnterButtonTapped(_ sender: Any) {
        
        //텍스트필드 텍스트와 딕셔너리 키를 비교 후 밸류를 가져온다.
        //딕셔너리 밸류 = 딕셔너리[키]
        guard let inputWord = inputTextField.text, inputWord.count > 1 else {
            showAlert(title: "내용을 두 글자 이상 입력해 주세요") //위 조건이 참이 아니면 여기 실행
            return
        }
        
        if let value = allDictionary()[inputWord] { //옵셔널 바인딩
            resultLabel.text = value
        } else {
            showAlert(title: "검색 결과가 없습니다")
        }
        
    }
    
    //신조어 버튼을 누르면 버튼 타이틀이 텍스트 필드에 써지고, 키보드가 올라온다.
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        inputTextField.text = sender.currentTitle
        inputTextField.becomeFirstResponder() //키보드 활성화
    }
    
    //알림창
    func showAlert(title: String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okButton)
        present(alert, animated: true)

    }
    
    //디자인, 세팅 모음
    func setDesign() {
        showRandomWordInButton()
        designWordButton()
        designSearchButton()
        designTextFeild()
        designResultLabel()
        designXButton()
    }
    
    //텍스트필드 디자인
    func designTextFeild() {
        inputTextField.layer.borderWidth = 3
        inputTextField.layer.borderColor = UIColor.black.cgColor
        inputTextField.placeholder = "신조어를 입력해 주세요!"
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0)) //왼쪽 여백
        inputTextField.leftViewMode = .always
    }
    
    //x버튼
    func designXButton(){
        xButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        xButton.setTitle("", for: .normal)
        xButton.tintColor = .systemGray4
    }
    
    //검색버튼 디자인
    func designSearchButton() {
        searchButton.layer.backgroundColor = UIColor.black.cgColor
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.setTitle("", for: .normal)
        searchButton.tintColor = .white
    }
    
    //신조어 버튼 디자인
    func designWordButton() {
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .trailing
        config.baseForegroundColor = .black //타이틀 컬러
        config.baseBackgroundColor = .white
        config.background.strokeWidth = 1
        config.background.strokeColor = .black
        config.cornerStyle = .fixed
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        config.titleLineBreakMode = .byTruncatingTail //라인 제한
        
        for button in wordButtons {
            button.configuration = config
            button.layer.shadowOffset = CGSize(width: 1, height: 1)
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 2
        }
    }
    
    //밸류 레이블 디자인
    func designResultLabel() {
        resultLabel.text = ""
//        resultLabel.layer.borderColor = UIColor.black.cgColor
//        resultLabel.layer.borderWidth = 3
        resultLabel.textAlignment = .center
    }
    
    //버튼에 신조어 랜덤 표시
    func showRandomWordInButton() {

        //딕셔너리 키 중 5개를 랜덤(중복x)으로 가져오기
        let randomWords = Array(keyWordsInDictionary().shuffled().prefix(5))
        
        // 버튼콜렉션 타이틀에 하나씩 넣는다.
        for (index, wordButton) in wordButtons.enumerated() {
            wordButton.setTitle("\(randomWords[index])", for: .normal)
        }
        
    }
    
    //모든 딕셔너리
    func allDictionary() -> Dictionary<String, String> {
        
        let wordDictionary = [
            "알잘딱깔센": "알아서 잘 딱 깔끔하고 센스있게",
            "요즘잘자쿨냥이": "통모짜핫도그(통 못자서 피곤하다)의 반댓말.\n핫도그가 뜨거운 강아지라 쿨냥이가 나왔고\n요즘 잘 잔다는 말로 사용하게 되었다.",
            "폼미쳤다": "FORM + 미쳤다\n무언가 범상치 않다 \n(칭찬 & 비꼼 모두 가능)",
            "좋댓구알": "좋아요, 댓글, 구독, 알림설정",
            "억텐": "억지 텐션",
            "스불재": "스스로 불러온 재앙",
            "점메추": "점심 메뉴 추천",
            "갓생": "부지런하고 열심히 사는 삶",
            "뇌꾸": "뇌 꾸미기(=공부)"
        ] //어떻게 관리..
        
        return wordDictionary
    }
    
    //딕셔너리 키 값만
    func keyWordsInDictionary() -> [String] {
        let words = Array(allDictionary().keys) //인덱스 주려고 배열에
        return words
    }
    
}
