//
//  UIImage+ASImage.h
//
//  Created by Vinny Coyne on 28/05/2012.
//  Copyright (c) 2012 App Sandwich Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ASImage)

+(NSURL *)as_applicationDocumentsDirectory;
+(NSURL *)as_applicationCacheDirectory;

// Load cached image from the "Caches" directory
+(UIImage *)as_cachedImageNamed:(NSString *)name;

// Load cached image from the "Documents" directory
+(UIImage *)as_documentsImageNamed:(NSString *)name;

@end
