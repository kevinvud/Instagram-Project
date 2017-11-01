//
//  CameraController.swift
//  Instagram Project
//
//  Created by PoGo on 11/1/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "right_arrow_shadow").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
        return button
    }()
    

    let capturePhotoButton: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupHUD()
        
    }
    
    func setupHUD(){
        
        view.addSubview(capturePhotoButton)
        view.addSubview(dismissButton)
        capturePhotoButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
        
        
    }
    
    func setupCaptureSession(){
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input){
                captureSession.addInput(input)
            }
            
        } catch {
            print(error)
        }
        
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    @objc func handleCapturePhoto(){
        
        
    }
    
    @objc func handleDissmiss(){
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
