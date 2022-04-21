//
//  ViewController.swift
//  try1
//
//  Created by seongjun cho on 2022/04/03.
//

import UIKit
import NMapsMap
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var main_view: UIView!
    
    @IBOutlet weak var babble_btn_1: UIButton!
    @IBOutlet weak var babble_btn_2: UIButton!
    @IBOutlet weak var babble_btn_3: UIButton!
    @IBOutlet weak var babble_btn_4: UIButton!
    
    @IBOutlet weak var food_inform_view: UIView!
    
    @IBOutlet weak var map_view: UIView!
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    
    var locationManager: CLLocationManager!
    
    var btns: [UIButton] = []
    var food_btns: [UIButton] = []
    var choiced_btn: UIButton?

    let naver_map = NMFMapView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        btns = [babble_btn_1,babble_btn_2,babble_btn_3,babble_btn_4]
        
        
        img_view.image = UIImage(named: "임시_크기 수정.png")
        img_view.frame = CGRect(x: 0, y: screen_height - 1715, width: 1112, height: 1720)
        
        babble_btn_1.frame = CGRect(x: screen_width * 0.25 + 400, y: screen_height * 0.2 - 400, width: 100, height: 100)
        babble_btn_2.frame = CGRect(x: screen_width * 0.7 + 400, y: screen_height * 0.3 - 400, width: 100, height: 100)
        babble_btn_3.frame = CGRect(x: screen_width * 0.5 + 400, y: screen_height * 0.5 - 400, width: 100, height: 100)
        babble_btn_4.frame = CGRect(x: screen_width * 0.25 + 400, y: screen_height * 0.7 - 400, width: 100, height: 100)
        
        babble_btn_1.layer.cornerRadius = babble_btn_1.frame.height / 2
        babble_btn_1.backgroundColor = UIColor.lightGray
        
        food_inform_view.frame = CGRect(x: 0, y: screen_height, width: screen_width, height: screen_height)
        food_inform_view.layer.cornerRadius = 20
        
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
    
    //업종 선택
    @IBAction func btn_choice(_ sender: UIButton) {
        
        var i = 0
        choiced_btn = sender
        
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
                
                
                food_btns = [food_btn1, food_btn2, food_btn3, food_btn4]
                
                food_btn1.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                food_btn2.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                food_btn3.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                food_btn4.frame = CGRect(x:0, y: screen_height, width: 0, height: 0)
                
                food_btn1.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                food_btn2.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                food_btn3.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                food_btn4.setBackgroundImage(UIImage(named: "bubble.jpeg"), for: .normal)
                
                food_btn1.addTarget(self, action: #selector(food_choice(_:)), for: .touchUpInside)
                food_btn2.addTarget(self, action: #selector(food_choice(_:)), for: .touchUpInside)
                food_btn3.addTarget(self, action: #selector(food_choice(_:)), for: .touchUpInside)
                food_btn4.addTarget(self, action: #selector(food_choice(_:)), for: .touchUpInside)
               
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

    //음식 선택
    @objc func food_choice(_ sender: UIButton)
    {
        naver_map.frame = view.frame
        map_view.addSubview(naver_map)
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            print("위치 서비스 On 상태")
            self.locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.locationManager.location?.coordinate.latitude ?? 0, lng: self.locationManager.location?.coordinate.longitude ?? 0))
            print("위도: \(self.locationManager.location?.coordinate.latitude)")
            print("경도: \(self.locationManager.location?.coordinate.longitude)")
            naver_map.moveCamera(cameraUpdate)
        }
        else {
                    print("위치 서비스 Off 상태")
            }
        
        naverSearchPlace(searchText: "장안동 짜장면")
        
        UIButton.animate(withDuration: 1, animations:{
            var i = 0
            sender.frame = CGRect(x: 0 , y: 0, width: self.screen_width, height: self.screen_width)
            while (i < 4)
            {
                if (self.food_btns[i] != sender)
                {
                        self.food_btns[i].isHidden = true
                        self.food_btns[i].isEnabled = false
                        
                        self.choiced_btn?.isHidden = true
                        self.choiced_btn?.isEnabled = false
                }
                i += 1
            }
        })

        UIView.animate(withDuration: 1, animations:{
            self.food_inform_view.frame.origin = CGPoint(x: 0, y: self.screen_height * 0.48)
        })
        
    }

    var searchedPlaces : String!
    var searchedLatitude : String!
    var searchedLongitude : String!

    func naverSearchPlace(searchText : String) {
            
            let encodeAddress = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    
            let header1 = HTTPHeader(name: "X-Naver-Client-Id", value: "MtquRJ3FZdTiwZ9Cqpgw")
            let header2 = HTTPHeader(name: "X-Naver-Client-Secret", value: "CHzkas7dAr")
            let headers = HTTPHeaders([header1,header2])
            
            AF.request("https://openapi.naver.com/v1/search/local.json?query=" + encodeAddress + "&display=5", method: .get,headers: headers).validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value as [String:Any]):
                        let json = JSON(value)
                        print(json)
                        let data = json["items"]
                        var i = 0
                        while (i < 5)
                        {
                            self.make_marker( data: data, i: i)
                            i += 1
                        }
                    case .failure(let error):
                        print(error.errorDescription ?? "")
                    default :
                        fatalError()
                    }
                }
    }
    // 출처 : https://github.com/xio9971/NaverSearchPlaceEx/blob/master/NaverMapEx/ViewController.swift
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
            if let location = locations.first {
                print("위도: \(location.coordinate.latitude)")
                print("경도: \(location.coordinate.longitude)")
                
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
                naver_map.moveCamera(cameraUpdate)
            }
    }
    */
    func make_marker( data: JSON, i : Int)
    {
        let food_lat = data[i]["mapy"].doubleValue
        let food_lon = data[i]["mapx"].doubleValue
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: food_lat, lng: food_lon)
        marker.mapView = self.naver_map
        print("x : \(food_lat) y :  \(food_lon) ")
    }
}
