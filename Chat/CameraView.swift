//
//  CameraView.swift
//  Rogers
//
//  Created by Amir Afzali on 2018-05-02.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit
import AVFoundation
import Hero

class CameraView: UIViewController, AVCapturePhotoCaptureDelegate {
    var session: AVCaptureSession?
    var cameraOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var settings : AVCapturePhotoSettings?
    var backCamera: AVCaptureDevice!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session = AVCaptureSession()
        session?.sessionPreset = .hd1920x1080
        backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            cameraOutput = AVCapturePhotoOutput()
            settings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            if session!.canAddOutput(cameraOutput!) {
                session!.addOutput(cameraOutput!)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewView.layer.addSublayer(videoPreviewLayer!)
                session!.startRunning()
                previewView.bringSubview(toFront: captureButton)
                previewView.bringSubview(toFront: captureImageView)
                previewView.bringSubview(toFront: cancelButton)
                previewView.bringSubview(toFront: settingsButton)
                previewView.bringSubview(toFront: sendButton)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.bounds
    }
    

    @IBAction func takePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        cameraOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let  previewBuffer = previewPhotoSampleBuffer, let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            let dataProvider = CGDataProvider(data: imageData as CFData)
            let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!,
                                     decode: nil,
                                     shouldInterpolate: true,
                                     intent: CGColorRenderingIntent.defaultIntent)
            
            // The image taken
            let image: UIImage = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.leftMirrored)
            captureImageView.image = image
            curImage = image;
            captureImageView.contentMode = UIViewContentMode.scaleAspectFill
            captureImageView.frame = previewView.bounds
            captureImageView.isHidden = false
            cancelButton.isHidden = false
            sendButton.isHidden = false
            captureButton.isHidden = true
            
        }
    }
    
    @IBAction func cancelPreview(_ sender: Any) {
        captureImageView.isHidden = true
        cancelButton.isHidden = true
        captureButton.isHidden = false
        sendButton.isHidden = true
    }
    
    @IBAction func goSettings(_ sender: Any) {
        let next = self.storyBoard.instantiateViewController(withIdentifier: "settings")
        next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
        self.hero.replaceViewController(with: next)
    }
    
    @IBAction func sendPhoto(_ sender: Any) {
        sending = true
        let next = self.storyBoard.instantiateViewController(withIdentifier: "friends")
        next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
        self.hero.replaceViewController(with: next)
        print("lol")
    }
    
    @IBAction func pinch(_ sender: Any) {
        
    }
    

    
    
}
