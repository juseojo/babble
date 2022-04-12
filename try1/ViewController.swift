//
//  ViewController.swift
//  try1
//
//  Created by seongjun cho on 2022/04/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var main_view: UIView!
    
    @IBOutlet weak var babble_btn_1: UIButton!
    @IBOutlet weak var babble_btn_2: UIButton!
    @IBOutlet weak var babble_btn_3: UIButton!
    @IBOutlet weak var babble_btn_4: UIButton!
    
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    var btns: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btns = [babble_btn_1,babble_btn_2,babble_btn_3,babble_btn_4]
        
        
        img_view.image = UIImage(named: "임시_크기 수정.png")
        img_view.frame = CGRect(x: 0, y: screen_height - 1715, width: 1112, height: 1720)
        
        babble_btn_1.frame = CGRect(x: screen_width * 0.25 + 400, y: screen_height * 0.2 - 400, width: 100, height: 100)
        babble_btn_2.frame = CGRect(x: screen_width * 0.7 + 400, y: screen_height * 0.3 - 400, width: 100, height: 100)
        babble_btn_3.frame = CGRect(x: screen_width * 0.5 + 400, y: screen_height * 0.5 - 400, width: 100, height: 100)
        babble_btn_4.frame = CGRect(x: screen_width * 0.25 + 400, y: screen_height * 0.7 - 400, width: 100, height: 100)
        
        babble_btn_1.layer.cornerRadius = babble_btn_1.frame.height / 2
        babble_btn_1.backgroundColor = UIColor.lightGray
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.click_action))
        img_view.addGestureRecognizer(gesture)
        img_view.isUserInteractionEnabled = true
    }
    
    @objc func click_action(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 1, animations:{
            self.img_view.transform = CGAffineTransform(translationX: -400, y: 400)
        })
        UIButton.animate(withDuration: 1, animations:{
            self.babble_btn_1.transform = CGAffineTransform(translationX: -400, y: 400)
            self.babble_btn_2.transform = CGAffineTransform(translationX: -400, y: 400)
            self.babble_btn_3.transform = CGAffineTransform(translationX: -400, y: 400)
            self.babble_btn_4.transform = CGAffineTransform(translationX: -400, y: 400)
        })
    }
    @IBAction func btn_choice(_ sender: UIButton) {
        
        var i = 0
        print("btn_click")
        while (i < 4)
        {
            if (btns[i] != sender)
            {
                UIButton.animate(withDuration: 1, animations:{
                    self.btns[i].isHidden = true
                    self.btns[i].isEnabled = false
                })
            }
            else
            {
                let food_btn1 = UIButton()
                let food_btn2 = UIButton()
                let food_btn3 = UIButton()
                let food_btn4 = UIButton()
                
                food_btn1.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                food_btn2.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                food_btn3.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                food_btn4.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                
                food_btn1.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                food_btn2.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                food_btn3.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                food_btn4.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
               
                self.main_view.addSubview(food_btn1)
                self.main_view.addSubview(food_btn2)
                self.main_view.addSubview(food_btn3)
                self.main_view.addSubview(food_btn4)
            
                UIButton.animate(withDuration: 2, animations:{
                    self.btns[i].frame.origin = CGPoint(x: self.screen_width * 0.1 , y: self.screen_height * 0.1)
                    
                    food_btn1.frame = CGRect(x: self.screen_width * 0.7 , y: self.screen_height * 0.3, width: 100, height: 100)
                    food_btn2.frame = CGRect(x: self.screen_width * 0.5 , y: self.screen_height * 0.5, width: 100, height: 100)
                    food_btn3.frame = CGRect(x: self.screen_width * 0.25 , y: self.screen_height * 0.7, width: 100, height: 100)
                    food_btn4.frame = CGRect(x: self.screen_width * 0.7 , y: self.screen_height * 0.8, width: 100, height: 100)
                })
            }
            
            i += 1
        }
    }
}

