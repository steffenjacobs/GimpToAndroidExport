; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Phoca Save Icons
; Copyright (C) 2008 Jan Pavelka ( http://www.phoca.cz )
; All rights reserved
; modified by Steffen Jacobs 2018
;
; This script is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 3 of the License, or
; (at your option) any later version.
;
; The GNU General Public License version 3 can be found at
; https://www.gnu.org/licenses/gpl-3.0.html.
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

(define (script-fu-save-icons-png image folder name interpolation x36 x48 x72 x96 x144 x192 interlace compression bKGD gAMA oFFs pHYs tIME comment svtrans)

(let* (
	(newImage 0)
	(newDraw 0)
	(newName "")
	(rawName "")
	;(folderNew "")
	(y 0)
	(partName "")
	(formats (cons-array 6 'byte))
	(formatsSelected (cons-array 6 'byte))
	(fS 0)
)


;Values - Formats
(aset formats 0 36)
(aset formats 1 48)
(aset formats 2 72)
(aset formats 3 96)
(aset formats 4 144)
(aset formats 5 192)

;Values - Selected Formats
(aset formatsSelected 0 x36)
(aset formatsSelected 1 x48)
(aset formatsSelected 2 x72)
(aset formatsSelected 3 x96)
(aset formatsSelected 4 x144)
(aset formatsSelected 5 x192)


(while (< y 6)

	(set! fS (aref formatsSelected y))

	(cond
		((= fS TRUE)
			;New Image
			(set! newImage (car (gimp-image-duplicate image)))
			(gimp-image-merge-visible-layers newImage 0)
			(gimp-image-scale-full newImage (aref formats y) (aref formats y) interpolation)
			(set! newDraw (car (gimp-image-get-active-drawable newImage)))
			
			;Name
			(set! partName (number->string (aref formats y)))
			(set! newName (string-append folder "/" name "-" partName ".png"))
			(set! rawName (string-append name "-" partName "0.png"))
			
			;Save
			(file-png-save2 1 newImage newDraw newName rawName interlace compression bKGD gAMA oFFs pHYs tIME comment svtrans)
			
			;Delete
			(gimp-image-delete newImage)
		)
	)
	
	(set! y (+ y 1))
)


)
)

(script-fu-register	"script-fu-save-icons-png"
					_"<Image>/Script-Fu/Android Icon Exporter/PNG"
					"Save Icons PNG"
					"(c) Jan Pavelka ( http://www.phoca.cz ) 2008 modified by Steffen Jacobs 2018"
					"License GPLv3"
					"December 2008"
					"RGB* GRAY* INDEXED*"
					SF-IMAGE 	"Image"				0
					SF-DIRNAME	"Folder"			""
					SF-STRING 	"Name" 				""
					SF-ENUM 	"Interpolation" 	'("InterpolationType" "cubic")
					SF-TOGGLE	"PNG 36 x 36px (120 dpi)"	TRUE
					SF-TOGGLE	"PNG 48 x 48px (160 dpi)"	TRUE
					SF-TOGGLE	"PNG 72 x 72px (240 dpi)"	TRUE
					SF-TOGGLE	"PNG 96 x 96px (320 dpi)"		TRUE
					SF-TOGGLE	"PNG 144 x 144px (480 dpi)"		TRUE
					SF-TOGGLE	"PNG 192 x 192px (640 dpi)"		TRUE
					
					SF-TOGGLE		"Use Adam7 interlacing?"				FALSE
					SF-ADJUSTMENT	"Deflate Compression factor (0--9)"  	'(9 0 9 1 10 0 0)
					SF-TOGGLE		"Write bKGD chunk?"						TRUE
					SF-TOGGLE		"Write gAMA chunk?"						FALSE
					SF-TOGGLE		"Write oFFs chunk?"						FALSE
					SF-TOGGLE		"Write pHYs chunk?"						TRUE
					SF-TOGGLE		"Write tIME chunk?"						TRUE
					SF-TOGGLE		"Write comment?"						TRUE
					SF-TOGGLE		"Preserve color of transparent pixels?" TRUE
					
)