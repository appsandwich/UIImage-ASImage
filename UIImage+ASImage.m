//
//  UIImage+ASImage.m
//
//  Created by Vinny Coyne on 28/05/2012.
//  Copyright (c) 2012 App Sandwich Limited. All rights reserved.
//

#import "UIImage+ASImage.h"

@implementation UIImage (ASImage)

+(NSURL *)as_applicationDocumentsDirectory {
    
    static NSURL *url = nil;
    
    if (!url)
        url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    return url;
}

+(NSURL *)as_applicationCacheDirectory {
    
    static NSURL *url = nil;
    
    if (!url)
        url = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    
    return url;
}

// Load cached image from the "Caches" directory
+(UIImage *)as_cachedImageNamed:(NSString *)name {
    
    if ((name) && ([name length] > 0)) {
        
        NSString *cachePath = [[UIImage as_applicationCacheDirectory] path];
        
        if (cachePath) {
        
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", cachePath, name];
            
            if (filePath) {
        
                // Find the relative path to the directory containing the "Caches" directory
                static NSString *rootPath = nil;
                
                if (!rootPath) {
                    NSString *documentsPath = [[UIImage as_applicationDocumentsDirectory] path];
                    rootPath = [documentsPath stringByReplacingOccurrencesOfString:@"/Documents" withString:@""];
                }
                
                // Create the relative path to the image on-disk
                NSString *relativeFilePath = [filePath stringByReplacingOccurrencesOfString:rootPath withString:@".."];
                
                // Load the image (uses the system cache also, which improves performance considerably)
                UIImage *image = [UIImage imageNamed:relativeFilePath];
                
                // Fallback in case loading from system cache ever breaks - load directly from the on-disk cache.
                if (!image)
                    return [UIImage imageWithContentsOfFile:filePath];
                
                return image;
            }
        }
    }
    
    return nil;
}

// Load cached image from the "Documents" directory
+(UIImage *)as_documentsImageNamed:(NSString *)name {
    
    if ((name) && ([name length] > 0)) {
        
        NSString *documentsPath = [[UIImage as_applicationDocumentsDirectory] path];
        
        if (documentsPath) {
            
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, name];
            
            if (filePath) {
                
                // Find the relative path to the directory containing the "Documents" directory
                static NSString *rootPath = nil;
                
                if (!rootPath) {
                    rootPath = [documentsPath stringByReplacingOccurrencesOfString:@"/Documents" withString:@""];
                }
                
                // Create the relative path to the image on-disk
                NSString *relativeFilePath = [filePath stringByReplacingOccurrencesOfString:rootPath withString:@".."];
                
                // Load the image (uses the system cache also, which improves performance considerably)
                UIImage *image = [UIImage imageNamed:relativeFilePath];
                
                // Fallback in case loading from system cache ever breaks - load directly from the on-disk cache.
                if (!image)
                    return [UIImage imageWithContentsOfFile:filePath];
                
                return image;
            }
        }
    }
    
    return nil;
}

@end
