//
//  PixelFormat.swift
//  VisionCamera
//
//  Created by Marc Rousavy on 17.08.23.
//  Copyright © 2023 mrousavy. All rights reserved.
//

import AVFoundation
import Foundation

enum PixelFormat: String, JSUnionValue {
  case yuv
  case rgb
  case native
  case unknown

  init(jsValue: String) throws {
    if let parsed = PixelFormat(rawValue: jsValue) {
      self = parsed
    } else {
      throw CameraError.parameter(.invalid(unionName: "pixelFormat", receivedValue: jsValue))
    }
  }

  var jsValue: String {
    return rawValue
  }

  init(mediaSubType: OSType) {
    switch mediaSubType {
    case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
         kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
         kCVPixelFormatType_420YpCbCr10BiPlanarFullRange,
         kCVPixelFormatType_420YpCbCr10BiPlanarVideoRange,
         kCVPixelFormatType_Lossless_420YpCbCr8BiPlanarFullRange,
         kCVPixelFormatType_Lossless_420YpCbCr8BiPlanarVideoRange,
         kCVPixelFormatType_Lossless_420YpCbCr10PackedBiPlanarVideoRange:
      self = .yuv
    case kCVPixelFormatType_32BGRA, kCVPixelFormatType_Lossless_32BGRA:
      self = .rgb
    default:
      self = .unknown
    }
  }
}
