//
//  TinderCard.swift
//  testingTinderSwipe
//
//  Created by Nicky on 11/16/17.
//  Copyright © 2017 Nicky. All rights reserved.
//



let THERESOLD_MARGIN = (UIScreen.main.bounds.size.height/2) * 0.75
let XTHERESOLD_MARGIN = (UIScreen.main.bounds.size.width/2) * 0.75
let SCALE_STRENGTH : CGFloat = 4
let SCALE_RANGE : CGFloat = 0.90

import UIKit

protocol TinderCardDelegate: NSObjectProtocol {
    func cardGoesUp(card: TinderCard)
    func cardGoesDown(card: TinderCard)
    func currentCardStatus(card: TinderCard, distance: CGFloat)
     func tapedoncard()
}

class TinderCard: UIView {
    
    var xCenter: CGFloat = 0.0
    var yCenter: CGFloat = 0.0
    var originalPoint = CGPoint.zero
    var imageViewStatus = UIImageView()
    var overLayImage = UIImageView()
    var isLiked = false
    //var EntryFee : String = ""
    weak var delegate: TinderCardDelegate?
    
    public init(frame: CGRect, value: ExPloreModel) {
        super.init(frame: frame)
      //  EntryFee = entryFee
        setupView(at: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(at value:ExPloreModel) {
        
        layer.cornerRadius = 3
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        clipsToBounds = false
        
        isUserInteractionEnabled = false
        
        originalPoint = center
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.taped))
              addGestureRecognizer(tapGestureRecognizer)
        
        let backGroundView = UIView(frame:bounds)
        backGroundView.backgroundColor = .red
        
        backGroundView.clipsToBounds = true;
        addSubview(backGroundView)
        
        
        let backGroundImageView = UIImageView(frame:backGroundView.bounds)
                backGroundImageView.backgroundColor = .red
                backGroundImageView.tag = 1
                let parse = value.all[0]
        //        backGroundImageView.image = #imageLiteral(resourceName: "bg")
                backGroundImageView.contentMode = .scaleAspectFill
                backGroundImageView.image = parse
        //  backGroundImageView.clipsToBounds = false;
//        backGroundImageView.image = CommonMethod().cropToBounds(image: UIImage(named:"login_bg") ?? UIImage(), width: Double(bounds.width), height: Double(bounds.height))
//        backGroundImageView.contentMode = .center
        
        backGroundView.addSubview(backGroundImageView)
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = backGroundImageView.frame
        gradient.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradient.locations = [0.6, 1.0]
        //        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        //        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        backGroundImageView.layer.insertSublayer(gradient, at: 0)
        
      
        /////////////////////Constarint ///////////////
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = backGroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let widthConstraint = backGroundImageView.widthAnchor.constraint(equalToConstant:bounds.width )
        let heightConstraint = backGroundImageView.heightAnchor.constraint(equalToConstant: bounds.height)
        
        NSLayoutConstraint.activate([horizontalConstraint,widthConstraint,heightConstraint])
        
        backGroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        

        
        let viewbootom = UIView()
        viewbootom.backgroundColor = UIColor.clear
        viewbootom.clipsToBounds = false
        backGroundImageView.addSubview(viewbootom)
        
//        let v:TinderbottomView = Bundle.main.loadNibNamed("TinderbottomView", owner: self, options: nil)?.first as! TinderbottomView       //let tinderview = Bundle.loadNibNamed("TinderbottomView") as! TinderbottomView
//        v.match_lbl .setTitle("ssd", for: .normal)
//        v.nmPerson.text = "Deepti"
//        v.distance.text = "2 km"
//        v.imgCount .setTitle(String(value.public_photo!.count), for: .normal)
        
//        viewbootom.addSubview(v)
        
        
        
        /////////////////////Constarint ///////////////
        viewbootom.translatesAutoresizingMaskIntoConstraints = false
    
        let heightConstraint2 = viewbootom.heightAnchor.constraint(equalToConstant: 141)
        let widthConstraint2 = viewbootom.widthAnchor.constraint(equalToConstant: bounds.width)
        
        NSLayoutConstraint.activate([heightConstraint2,widthConstraint2])
        
        viewbootom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        viewbootom.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        
        viewbootom.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        
        
        /////////////////////Constarint ///////////////
//        v.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        let vH = v.heightAnchor.constraint(equalToConstant: 141)
//        let vW = v.widthAnchor.constraint(equalToConstant: viewbootom.frame.size.width)
//        
//        NSLayoutConstraint.activate([vH,vW])
//        
//        v.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        
//        v.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//        
//        v.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
    
        
        overLayImage = UIImageView(frame:bounds)
        overLayImage.alpha = 0
        addSubview(overLayImage)
        
    }
    
    @objc func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        xCenter = gestureRecognizer.translation(in: self).x
        yCenter = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        // Keep swiping
        case .began:
            originalPoint = self.center;
            break;
        //in the middle of a swipe
        case .changed:
            let rotationStrength = min(xCenter / UIScreen.main.bounds.size.width, 1)
            let rotationAngel = .pi/8 * rotationStrength
            let scale = max(1 - abs(rotationStrength) / SCALE_STRENGTH, SCALE_RANGE)
            center = CGPoint(x: originalPoint.x + xCenter, y: originalPoint.y + yCenter)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: scale, y: scale)
            self.transform = scaleTransform
            updateOverlay(xCenter)
            break;
            
        // swipe ended
        case .ended:
            afterSwipeAction()
            break;
            
        case .possible:break
        case .cancelled:break
        case .failed:break
        }
    }
    func updateOverlay(_ distance: CGFloat) {
        
        // imageViewStatus.image = distance > 0 ? UIImage (named: "tick")
        //   : UIImage (named: "remove")
        
        // overLayImage.image = distance > 0 ? #imageLiteral(resourceName: "overlay_like") : #imageLiteral(resourceName: "overlay_skip")
        imageViewStatus.alpha = min(abs(distance) / 100, 0.5)
        overLayImage.alpha = min(abs(distance) / 100, 0.5)
        delegate?.currentCardStatus(card: self, distance: distance)
    }
    
    @objc func taped(_ gestureRecognizer: UITapGestureRecognizer)  {
          delegate?.tapedoncard()
      }
    func afterSwipeAction() {
        
        if yCenter > THERESOLD_MARGIN {
            cardGoesDown()
        }
        else if yCenter < -THERESOLD_MARGIN {
            cardGoesUp()
        }
        else if xCenter > XTHERESOLD_MARGIN {
            print(xCenter)
            self.rightClickAction()
        }
        else if xCenter < -XTHERESOLD_MARGIN {
            print(xCenter)
            self.leftClickAction()
        }
        else {
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.imageViewStatus.alpha = 0
                self.overLayImage.alpha = 0
                self.delegate?.currentCardStatus(card: self, distance:0)
            })
        }
    }
    
    func cardGoesDown() {
        
        //  let finishPoint = CGPoint(x: 2 * xCenter + originalPoint.x, y: frame.size.height*2)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = self.originalPoint
            self.transform = CGAffineTransform(rotationAngle: 0)
            self.imageViewStatus.alpha = 0
            self.overLayImage.alpha = 0
            self.delegate?.currentCardStatus(card: self, distance:0)
        }, completion: {(_) in
            // self.removeFromSuperview()
        })
        // isLiked = true
        //delegate?.cardGoesDown(card: self)
        print("WATCHOUT RIGHT")
    }
    
    func cardGoesUp() {
        
        //  let finishPoint = CGPoint(x: 2 * xCenter + originalPoint.x, y: -frame.size.height*2)
        DispatchQueue.main.async {
             UIView.animate(withDuration: 0.3, animations: {
                       self.center = self.originalPoint
                       self.transform = CGAffineTransform(rotationAngle: 0)
                       self.imageViewStatus.alpha = 0
                       self.overLayImage.alpha = 0
                       self.delegate?.currentCardStatus(card: self, distance:0)
                   }, completion: {(_) in
                       // self.removeFromSuperview()
                   })
        }
       
        // isLiked = false
        // delegate?.cardGoesUp(card: self)
        print("WATCHOUT LEFT")
    }
    
    // right click action
    func rightClickAction() {
        
        // imageViewStatus.image = UIImage (named: "tick")
        // overLayImage.image = #imageLiteral(resourceName: "overlay_like")
        let finishPoint = CGPoint(x: center.x + frame.size.width * 2, y: center.y)
        imageViewStatus.alpha = 0.5
        overLayImage.alpha = 0.5
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: 1)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
        }, completion: {(_ complete: Bool) -> Void in
            self.removeFromSuperview()
        })
        isLiked = true
        delegate?.cardGoesDown(card: self)
        print("WATCHOUT RIGHT ACTION")
    }
    // left click action
    func leftClickAction() {
        
       
        imageViewStatus.image = UIImage (named: "remove")
        
        // overLayImage.image = #imageLiteral(resourceName: "overlay_skip")
        let finishPoint = CGPoint(x: center.x - frame.size.width * 2, y: center.y)
        imageViewStatus.alpha = 0.5
        overLayImage.alpha = 0.5
       
        DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0, animations: {() -> Void in
                              self.center = finishPoint
                              self.transform = CGAffineTransform(rotationAngle: -1)
                              self.imageViewStatus.alpha = 1.0
                              self.overLayImage.alpha = 1.0
                          }, completion: {(_ complete: Bool) -> Void in
                              self.removeFromSuperview()
                          })
               }
        isLiked = false
        delegate?.cardGoesUp(card: self)
        print("WATCHOUT LEFT ACTION")
    }
    
    // undoing  action
    func makeUndoAction() {
        
        // imageViewStatus.image = isLiked ? #imageLiteral(resourceName: "btn_like_pressed") : #imageLiteral(resourceName: "btn_skip_pressed")
        //  overLayImage.image = isLiked ? #imageLiteral(resourceName: "overlay_like") : #imageLiteral(resourceName: "overlay_skip")
        // imageViewStatus.alpha = 1.0
        overLayImage.alpha = 1.0
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.center = self.originalPoint
            self.transform = CGAffineTransform(rotationAngle: 0)
            //self.imageViewStatus.alpha = 0
            self.overLayImage.alpha = 0
        })
        
        print("WATCHOUT UNDO ACTION")
    }
    
    func rollBackCard(){
        
        UIView.animate(withDuration: 0.3) {
            self.removeFromSuperview()
        }
    }
    
    func shakeAnimationCard(){
        
        imageViewStatus.image = UIImage (named: "remove")
        
        overLayImage.image = #imageLiteral(resourceName: "overlay_skip")
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.center = CGPoint(x: self.center.x - (self.frame.size.width / 2), y: self.center.y)
            self.transform = CGAffineTransform(rotationAngle: -0.2)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
        }, completion: {(_) -> Void in
            UIView.animate(withDuration: 0.3, animations: {() -> Void in
                self.imageViewStatus.alpha = 0
                self.overLayImage.alpha = 0
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: {(_ complete: Bool) -> Void in
                self.imageViewStatus.image = UIImage (named: "tick")
                
                self.overLayImage.image =  #imageLiteral(resourceName: "overlay_like")
                UIView.animate(withDuration: 0.3, animations: {() -> Void in
                    self.imageViewStatus.alpha = 1
                    self.overLayImage.alpha = 1
                    self.center = CGPoint(x: self.center.x + (self.frame.size.width / 2), y: self.center.y)
                    self.transform = CGAffineTransform(rotationAngle: 0.2)
                }, completion: {(_ complete: Bool) -> Void in
                    UIView.animate(withDuration: 0.3, animations: {() -> Void in
                        self.imageViewStatus.alpha = 0
                        self.overLayImage.alpha = 0
                        self.center = self.originalPoint
                        self.transform = CGAffineTransform(rotationAngle: 0)
                    })
                })
            })
        })
        
        print("WATCHOUT SHAKE ACTION")
    }
}


