//
//  ViewController.swift
//  CatchKenny
//
//  Created by Eray İnal on 7.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    //Score:
    var puan = 0
    
    
    
    //StoredHighScore:
    var highPuan = 0
    
    
    
    //Kenny gizleme
    var kennyArray = [UIImageView]()    // Kenny gizleyip geri getirmek için
    var hideTimer = Timer()
    
    
    
    //Timer
    var counter = 0
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scoreLabel.text = "Score: \(puan)"
        
        
        
        //Score:
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
        
        
        //Check HighScore:
        let storedHighscore = UserDefaults.standard.object(forKey: "highpuan")
        if(storedHighscore == nil){
            highPuan = 0
            highscoreLabel.text = "Highscore: \(highPuan)"
        }
        
        if let newScore = storedHighscore as? Int{
            highPuan = newScore
            highscoreLabel.text = "Highscore: \(highPuan)"
        }
        
        
        
        
        
        // Kenny yok olup geri gelme
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
        
        
        
        // Timer
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
        
        
        
        
        
        // Kenny Gizleme:
        hideKenny()
        
        
        
        
        
        
        
        
        
    }
    
    
    
    //Score için function
    @objc func increaseScore(){
        puan += 1
        scoreLabel.text = "Score: \(puan)"
        print(puan)
        
        UserDefaults.standard.setValue(puan, forKey: "puan")
    }
    
    
    
    
    //Timer and Alert:
    @objc func timerFunction(){
        //Timer
        timeLabel.text = "\(counter)"
        counter -= 1
        if counter == -1{
            timer.invalidate()
            hideTimer.invalidate() // Süre dolduğunda Kenny'in yerini değiştirmeyi de durdursun
            // Hatta bittiğinde kennyleri de tekrar gizlesin:
            for hiding in kennyArray{
                hiding.isHidden = true
            }
        }
        
        
        //Store HighScore:
        if(puan > highPuan){
            highPuan = puan
            highscoreLabel.text = "Highscore: \(highPuan)"
            UserDefaults.standard.set(highPuan, forKey: "highpuan") // Burada highPuan'ı UserDefaults'a kaydettik
        }
        
        
        
        //Alert:
        if(counter == -1){
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let noButton = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel)
            let yesButton = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) { UIAlertAction in
                //Code:
                self.puan = 0
                self.scoreLabel.text = "Score: \(self.puan)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                // Timer'ları tekrar çalıştırmamız lazım o yüzden kopyalayıp yapıştıralım:
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(yesButton)
            alert.addAction(noButton)
            
            self.present(alert, animated: true, completion: nil)
        }
        //Zaman dolduğu için scoru sıfırlamamız lazım
        if(counter == -1){
            puan = 0
            scoreLabel.text = "Score: \(puan)"
        }
    }
    
    
    
    
    
    //Kenny gizleme func
    @objc func hideKenny(){
        
        for hiding in kennyArray{
            hiding.isHidden = true
        }
        
        let randomNumber = Int.random(in: 0...8)
        kennyArray[randomNumber].isHidden = false
        print(randomNumber)
    }
    
    
    
    
    

}

